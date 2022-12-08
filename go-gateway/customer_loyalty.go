/*
*	Copyright PKA.CPD . All Rights Reserved.
*	SPDX-License-Identifier: Apache-2.0
 */

package main

import (
	"crypto/x509"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/definev/customer_loyalty_hyperledger/go-gateway/fabric"
	"github.com/definev/customer_loyalty_hyperledger/go-gateway/handler"
	"github.com/definev/customer_loyalty_hyperledger/go-gateway/middleware"
	"github.com/gin-gonic/gin"
	"github.com/hyperledger/fabric-gateway/pkg/client"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
)

const (
	// TODO: Need to expose in environment variable
	secret = "secret"
)

func main() {
	log.Println("============ application-golang starts ============")

	// The gRPC client connection should be shared by all Gateway connections to this endpoint
	clientConnection := newGrpcConnection()
	defer clientConnection.Close()

	id := fabric.NewIdentity()
	sign := fabric.NewSign()

	// Create a Gateway connection for a specific client identity
	gw, err := client.Connect(
		id,
		client.WithSign(sign),
		client.WithClientConnection(clientConnection),
		// Default timeouts for different gRPC calls
		client.WithEvaluateTimeout(5*time.Second),
		client.WithEndorseTimeout(15*time.Second),
		client.WithSubmitTimeout(5*time.Second),
		client.WithCommitStatusTimeout(1*time.Minute),
	)
	if err != nil {
		panic(err)
	}
	defer gw.Close()

	// Override default values for chaincode and channel name as they may differ in testing contexts.
	chaincodeName := "loyalty"
	if ccname := os.Getenv("CHAINCODE_NAME"); ccname != "" {
		chaincodeName = ccname
	}

	channelName := "mychannel"
	if cname := os.Getenv("CHANNEL_NAME"); cname != "" {
		channelName = cname
	}

	network := gw.GetNetwork(channelName)
	contract := network.GetContract(chaincodeName)

	r := gin.Default()
	r.Use(middleware.CORSMiddleware())
	api := r.Group("/api")

	api.POST("/registerMember", handler.CreateMember(contract))
	api.POST("/registerPartner", handler.CreatePartner(contract))
	api.POST("/earnPoints", handler.EarnPoints(contract))
	api.POST("/usePoints", handler.UsePoints(contract))
	api.POST("/memberData", handler.MemberData(contract))
	api.POST("/partnerData", handler.PartnerData(contract))

	api.Use(middleware.Auth(secret)).GET("/usePoints", handler.GetUsedPoints(contract))
	api.Use(middleware.Auth(secret)).GET("/earnPoints", handler.GetEarnedPoints(contract))

	r.Run(":8181")
}

// newGrpcConnection creates a gRPC connection to the Gateway server.
func newGrpcConnection() *grpc.ClientConn {
	certificate, err := fabric.LoadCertificate(fabric.TlsCertPath)
	if err != nil {
		panic(err)
	}

	certPool := x509.NewCertPool()
	certPool.AddCert(certificate)
	transportCredentials := credentials.NewClientTLSFromCert(certPool, fabric.GatewayPeer)

	connection, err := grpc.Dial(fabric.PeerEndpoint, grpc.WithTransportCredentials(transportCredentials))
	if err != nil {
		panic(fmt.Errorf("failed to create gRPC connection: %w", err))
	}

	return connection
}
