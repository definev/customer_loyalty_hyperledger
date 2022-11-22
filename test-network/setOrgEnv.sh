#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0




# default to using Org1
ORG=${1:-Org1}

# Exit on first error, print all commands.
set -e
set -o pipefail

# peer lifecycle chaincode package loyalty.tar.gz --path ../go-contract --lang golang --label loyalty_1.0

# Where am I?
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

FABRIC_CFG_PATH=${DIR}/config
ORDERER_CA=${DIR}/test-network/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
PEER0_ORG1_CA=${DIR}/test-network/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem
PEER0_ORG2_CA=${DIR}/test-network/organizations/peerOrganizations/org2.example.com/tlsca/tlsca.org2.example.com-cert.pem
PEER0_ORG3_CA=${DIR}/test-network/organizations/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem


if [[ ${ORG} == "org1" || ${ORG} == "digibank" ]]; then

   CORE_PEER_LOCALMSPID=Org1MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
   CORE_PEER_ADDRESS=localhost:7051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem

elif [[ ${ORG} == "org2" || ${ORG} == "magnetocorp" ]]; then

   CORE_PEER_LOCALMSPID=Org2MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
   CORE_PEER_ADDRESS=localhost:9051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org2.example.com/tlsca/tlsca.org2.example.com-cert.pem

else
   echo "Unknown \"$ORG\", please choose Org1/Digibank or Org2/Magnetocorp"
   echo "For example to get the environment variables to set upa Org2 shell environment run:  ./setOrgEnv.sh Org2"
   echo
   echo "This can be automated to set them as well with:"
   echo
   echo '$(./setOrgEnv.sh Org2 | xargs)'
   exit 1
fi

# output the variables that need to be set
echo "export FABRIC_CFG_PATH=${FABRIC_CFG_PATH}"
echo "export CORE_PEER_TLS_ENABLED=true"
echo "export ORDERER_CA=${ORDERER_CA}"
echo "export PEER0_ORG1_CA=${PEER0_ORG1_CA}"
echo "export PEER0_ORG2_CA=${PEER0_ORG2_CA}"
echo "export PEER0_ORG3_CA=${PEER0_ORG3_CA}"

echo "export CORE_PEER_MSPCONFIGPATH=${CORE_PEER_MSPCONFIGPATH}"
echo "export CORE_PEER_ADDRESS=${CORE_PEER_ADDRESS}"
echo "export CORE_PEER_TLS_ROOTCERT_FILE=${CORE_PEER_TLS_ROOTCERT_FILE}"

echo "export CORE_PEER_LOCALMSPID=${CORE_PEER_LOCALMSPID}"
