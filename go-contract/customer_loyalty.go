/*
*	Copyright PKA.CPD . All Rights Reserved.
*	SPDX-License-Identifier: Apache-2.0
 */

package main

import (
	"log"

	"github.com/definev/customer_loyalty_hyperledger/go-contract/chaincode"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

func main() {
	loyaltyChaincode, err := contractapi.NewChaincode(&chaincode.CustomerLoyaltyContract{})
	if err != nil {
		log.Panicf("Error creating loyalty chaincode: %v", err)
	}

	if err := loyaltyChaincode.Start(); err != nil {
		log.Panicf("Error starting loyalty chaincode: %v", err)
	}
}
