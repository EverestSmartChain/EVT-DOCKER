Getting Started
These Instructions will help you create and start the Everest Smart Chain Node in a container . 

Prerequisites
Before you begin, ensure you have the following installed:
```
Git 
Docker 
Docker Compose  
Curl 
```
For installation of these applications instructions, refer to:
```
Git: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
Docker: https://docs.docker.com/get-docker/
Docker Compose: https://docs.docker.com/compose/install/
```

Installation

To set up the project for development:



Clone the Repository

```
git clone https://github.com/EverestSmartChain/evt-docker.git
```
### Navigate to the Project Directory
```
cd evt-docker
```

change the Node Moniker to your Desired Name by changing The name from master-node to your Desired on file entrypoint.sh on line number 11 before starting the containers 

### Build and Start the Container

```
docker-compose up -d
```


This command builds the Docker image (if necessary) and starts the container in detached mode.

Once your Container is runnung a Full Node of Everest Smart Chain will Start and Start Syncing the blocks .  You may monitor this Sync Process by executing following command 
```
docker exec Everest Smart Chain /bin/bash/tail -f /var/log/evtd/log
```

### How to Become Validator

Once the Chain Has synced completely , either you can create a new account or import a Seed Phrase . To start by creating Account please follow 


To create a New Account Assuming you changed name from master-node to my-node  and your Validator Name will set as my-pos-node 

Get into the Container Bash 

```
docker exec -it Everest Smart Chain /bin/bash
```

once you are inside the container shell , below is an example of self staking 14.9 EVT with 5% Commission on Staking , once validator is running more EVT cam be staked through https://stake.everestchain.net


```
./evtd tx staking create-validator   --amount=1490000000000000000000aevt   --pubkey=$(/root/go/bin/evtd tendermint show-validator)   --moniker="skwidmonk"   --chain-id="evt_8848-1"   --commission-rate="0.05"   --commission-max-rate="0.10"   --commission-max-change-rate="0.01"   --min-self-delegation="1000000"   --gas="auto"   --gas-prices="1000aevt"   --from=skwidmonk

```

For Further Information ask us on Discord or follow the official Documentation 


### Join Discord 
https://discord.gg/AFXENN7Xe7 

### Join our Telegram Group 
https://t.me/+lmujQvXsZKw5Njk1
