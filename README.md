# Customer loyalty hyperledger

A blockchain system that stores loyalty points transparently

## Installation

- [Go](https://go.dev/doc/install)
- [Docker](https://www.docker.com/)
- [hyperledger binary]
- ```chmox +x install-fabric.sh && ./install-fabric.sh```

## Pre-run

Export `binary` to PATH
```bash
export PATH=$PATH:$PWD/bin
```

## Run the network

Vào thư mục `test-network` để thực hiện tất cả các dòng lệnh phía dưới
```bash
cd test-network
```

Nếu chưa build network lần nào hoặc muốn build lại chạy lệnh sau
```
./network.sh down
```

Dựng network trên docker bằng lệnh sau
```bash
./network.sh up createChannel -ca
```

Nén chaincode của chúng ta ở thư mục `go-contract` và đấy vào network
```bash
./network.sh deployCC -ccn loyalty -ccl go -ccp ../go-contract -cci InitLedger
```

Đã xong phần build chaincode và mở các cổng để kết nối ra ngoài

## Run the gateway

Vào thư mục `go-gateway` để thực hiện tất cả các dòng lệnh phía dưới
```bash
cd go-gateway
```

Chạy gateway server
```bash
go get
go run customer_loyalty.go
```

## Run the client

Vào thư mục `web-app` để thực hiện tất cả các dòng lệnh phía dưới
```bash
cd web-app
```

Chạy client
```bash
npm install
npm run start
```
