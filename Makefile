.prony: install

install:
	@chmod +x install-fabric.sh && ./install-fabric.sh
	@cd test-network && ./network.sh deployCC -ccn loyalty -ccl go -ccp ../go-contract -cci InitLedger