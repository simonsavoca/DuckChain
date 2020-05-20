# DuckChain
Private Blockchain project.

## Network

| Name | Sync | Port |
|---|---|---|---|
| DuckChain_BootNode | Fast | 30303 | 8535 8536 8537
| DuckChain_HubNode | Fast | 30304 | 8545 8546 8547


### Public network(Discover)

| Name | Sync | Port | RPC | WS |
|---|---|---|---|---|---|
| DuckChain_Public_FastNode01 | Fast | 30311 | 8111 8112 8113 | :no_entry_sign:
| DuckChain_Public_FullNode01 | Full | 30312 | 8121 8122 8123 :no_entry_sign: | :no_entry_sign:
| DuckChain_Public_ArchiveNode01 | Full+NoPruning | 30313 | 8131 8132 8133 :no_entry_sign: | :no_entry_sign:
| DuckChain_Public_WalletNode01 | Full+NoPruning | 30314 | 8141 8142 8143 :no_entry_sign: | :no_entry_sign:
| DuckChain_Public_MinerNode01 | Fast | 30315 | 8151 8152 8153 :no_entry_sign: | :no_entry_sign:


### Private Network

| Name | Sync | Port | RPC | WS |
|---|---|---|---|---|---|
| DuckChain_Private_FastNode01 | Fast | 30321 | 8211 8212 8213 :no_entry_sign: | :no_entry_sign: |
| DuckChain_Private_FullNode01 | Full | 30322 | 8221 8222 8223 :no_entry_sign: | :no_entry_sign:
| DuckChain_Private_ArchiveNode01 | Full+NoPruning | 30316 | 8231 8232 8233 :no_entry_sign: | :no_entry_sign:
| DuckChain_Private_WalletNode01 | Full | 30323 | 8241 8242 8243 :no_entry_sign: | :no_entry_sign:
| DuckChain_Private_MinerNode01 | Fast | 30324 | 8251 8252 8253 :no_entry_sign: | :no_entry_sign:

### Client network (another computer)
| Name | Sync | Port | RPC | WS |
|---|---|---|---|---|---|
| DuckChain_MinerNode01 | Light | 30303 | :heavy_check_mark: (8545) | :heavy_check_mark: (8546) |


## Go-Ethereum nodes
### Installation
```
sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum
```
### Special accounts

geth --datadir /.../.....  account new

- One for Faucet service and give free ethers
- One personnal, my precious !

Update duckchain.json pre-funded account with the resulted id.


### Initialize
Each node nead to be generated according the same genesis.json:
```
geth --datadir ./data/DuckChain_BootNode/ init ./config/duckchain.json
```
Change the `--datadir` value for each node.

### Run nodes
Duplicate toml file for each node you want to run.

#### Get enode address
To configure each toml file correctly you need all you node enode adresses.
cat ./data/DuckChain_BootNode/nodekey
bootnode -nodekeyhex -writeadress

Or run the node without discover on networkid 9999
geth --datadir data/DuckChain_BootNode/ --networkid 9999 --nodiscover console

In the same machine, you need to define the port with --port 30304 (default is 30303)


admin.nodeInfo.TrustedNodes
Return something like:
"enode://8aacd6b0f9f3e1d205b4feb48c4e3c2a3d69695a3d2f63b514a59c5985354ae5e7a1ad726fb4d40206a0e405128a2a2a3ffb021a119488e3ca242bab34829c1c@82.64.158.44:30303?discport=0"

Remove the ?discport=0 due to the --nodiscover flag (only for boot/public nodes) and you have you BootNode address, paste this value into each node toml file.

At Static and Trusted node for the private nodes, as BootstrapNodes for public nodes and clients (miners).


#### Boot node

geth --config ./config/DuckChain_BootNode.toml

#### Private node
Repeat steps to get the enode asdress, then past this address as static and trusted node on the bootnode config.

geth --config ./config/DuckChain_PrivateNode.toml

#### Public node
Public nodes adresses are shared trough the discovery process, so there is no need to set them anywhere.

geth --config ./config/DuckChain_PublicNode.toml

#### Use case to study
- Double BootNode
- Private Block miner
-
### Monitoring

git clone https://github.com/cubedro/eth-netstats.git
npm install
["123456"] > ws_secret.json
npm start

sudo cp systemd/netstats.service /etc/systemd/system
sudo service enable netstats.service


:warning: No specials chars in secret key like @!,;. etc....

Adapt your node TOML files with the correct secret, host and port if modified:

[Ethstats]
URL = "DuckChain_PublicNode01:12345@192.168.0.250:3000"

### Sources
- https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Ubuntu
- https://www.edureka.co/blog/ethereum-private-network-tutorial
- https://ethereum.gitbooks.io/frontier-guide/listing_accounts.html
- https://ethereum.gitbooks.io/frontier-guide/sending_ether.html
- https://www.hackster.io/matt-farley/world-s-smartest-home-feat-blockchain-chores-kids-crypto-025e83
- https://github.com/ethereum/go-ethereum/wiki/Managing-your-accounts
- https://myhsts.org/tutorial-learn-how-to-work-with-ethereum-private-network-with-golang-with-geth.php
- https://ethereum.stackexchange.com/questions/2531/common-useful-javascript-snippets-for-geth

### Sources
- https://www.codeooze.com/blockchain/ethereum-wallet-private-chain-setup/
- https://github.com/ethereum/go-ethereum/wiki/Contract-Tutorial
- https://www.trufflesuite.com/docs/truffle/getting-started/compiling-contracts

# Puppeth

BootNode:
Step 3/4 : RUN   
echo 'geth --cache 512 init /genesis.json'
echo 'exec geth --networkid 3938 --cache 512 --port 30303 --nat extip:192.168.0.251 --maxpeers 512 --lightpeers=256 --lightserv=50 --ethstats \'DuckChain_BootNode01:MyVeryStrongSecret@192.168.0.251:8081\'    --miner.gastarget 0 --miner.gaslimit 0 --miner.gasprice 0' >> geth.sh

SealerNode:
Step 3/4 : RUN   echo 'geth --cache 512 init /genesis.json' > geth.sh && 	echo $'exec geth --networkid 3938 --cache 512 --port 30304 --nat extip:192.168.0.251 --maxpeers 50  --ethstats \'DuckChain_SealerNode01:MyVeryStrongSecret@192.168.0.251:8081\'  --miner.etherbase 0x898bd12e8Fc14f503c246180590e90042b9B282a --mine --miner.threads 1  --miner.gastarget 7500000 --miner.gaslimit 10000000 --miner.gasprice 1000000000' >> geth.sh

eth.coinbase

V3rY5tR0n6S3cR3T

WAlletNode:
Step 3/5 : RUN   echo 'node server.js &'                     > wallet.sh && 	echo 'geth --cache 512 init /genesis.json' >> wallet.sh && 	echo $'exec geth --networkid 21061982 --port 30306 --bootnodes  --ethstats \'DuckChain_Wallet01:MyV3rY5Tr0N6S3Cr3T@192.168.0.251:8080\' --cache=512 --rpc --rpcaddr=0.0.0.0 --rpccorsdomain "*" --rpcvhosts "*"' >> wallet.sh

Archive node:
geth --networkid=21061982 --datadir=$HOME/.duckchain --cache=1024 --syncmode=full --ethstats='yournode:V3rY5tR0n6S3cR3T@192.168.0.251:8081' --bootnodes=

Light Node:
geth --networkid=21061982 --datadir=$HOME/.duckchain --syncmode=light --ethstats='yournode:V3rY5tR0n6S3cR3T@192.168.0.251:8081' --bootnodes=

full Node:

geth --networkid=21061982 --datadir=$HOME/.duckchain --cache=512 --ethstats='yournode:V3rY5tR0n6S3cR3T@192.168.0.251:8081' --bootnodes=

# Besu

 ## Installation
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt install openjdk-11-jre


https://pegasys.tech/solutions/hyperledger-besu/
wget https://github.com/hyperledger/besu/archive/1.4.4.zip
unzip besu-1.4.4.zip
mv besu-1.4.4 besu

`./besu --data-dir=/home/simon/DuckChain/BootNode02 --genesis-file=/home/simon/DuckChain/config/genesis.json --rpc-http-enabled --host-whitelist="*" --rpc-http-cors-origins="all"`

variant =
  if is_nil(System.get_env("ETHEREUM_JSONRPC_VARIANT")) do
    "get"
  else
    System.get_env("ETHEREUM_JSONRPC_VARIANT")
    |> String.split(".")
    |> List.last()
    |> String.downcase()
  end
