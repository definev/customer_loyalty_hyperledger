/*
*	Copyright PKA.CPD . All Rights Reserved.
*	SPDX-License-Identifier: Apache-2.0
 */

package fabric

import (
	"crypto/x509"
	"fmt"
	"os"
	"path"

	"github.com/hyperledger/fabric-gateway/pkg/identity"
)

const (
	MspID        = "Org1MSP"
	cryptoPath   = "../test-network/organizations/peerOrganizations/org1.example.com"
	CertPath     = cryptoPath + "/users/User1@org1.example.com/msp/signcerts/cert.pem"
	KeyPath      = cryptoPath + "/users/User1@org1.example.com/msp/keystore/"
	TlsCertPath  = cryptoPath + "/peers/peer0.org1.example.com/tls/ca.crt"
	PeerEndpoint = "localhost:7051"
	GatewayPeer  = "peer0.org1.example.com"
)

// newIdentity creates a client identity for this Gateway connection using an X.509 certificate.
func NewIdentity() *identity.X509Identity {
	certificate, err := LoadCertificate(CertPath)
	if err != nil {
		panic(err)
	}

	id, err := identity.NewX509Identity(MspID, certificate)
	if err != nil {
		panic(err)
	}

	return id
}

func LoadCertificate(filename string) (*x509.Certificate, error) {
	certificatePEM, err := os.ReadFile(filename)
	if err != nil {
		return nil, fmt.Errorf("failed to read certificate file: %w", err)
	}
	return identity.CertificateFromPEM(certificatePEM)
}

// newSign creates a function that generates a digital signature from a message digest using a private key.
func NewSign() identity.Sign {
	files, err := os.ReadDir(KeyPath)
	if err != nil {
		panic(fmt.Errorf("failed to read private key directory: %w", err))
	}
	privateKeyPEM, err := os.ReadFile(path.Join(KeyPath, files[0].Name()))

	if err != nil {
		panic(fmt.Errorf("failed to read private key file: %w", err))
	}

	privateKey, err := identity.PrivateKeyFromPEM(privateKeyPEM)
	if err != nil {
		panic(err)
	}

	sign, err := identity.NewPrivateKeySign(privateKey)
	if err != nil {
		panic(err)
	}

	return sign
}
