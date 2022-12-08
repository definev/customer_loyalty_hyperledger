.prony: install

install:
	@chmod +x install-fabric.sh && ./install-fabric.sh
	
run_network:
	@cd test-network && ./network.sh down && ./network.sh up createChannel -ca && ./network.sh deployCC -ccn loyalty -ccl go -ccp ../go-contract -cci InitLedger
