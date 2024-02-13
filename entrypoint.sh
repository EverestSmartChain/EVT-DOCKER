#!/bin/bash

# Initialization flag file location
INIT_FLAG="/root/.evtd/init_done.flag"

# Check if evtd has been initialized
if [ ! -f "$INIT_FLAG" ]; then
    echo "First-time initialization of evtd..."

    # Initialize the node
    /usr/local/bin/evtd init NODE_NAME_PLACEHOLDER --chain-id "evt_8848-1"
    echo "Node initialized."

    # Replace the genesis.json file
    curl -o /root/.evtd/config/genesis.json https://raw.githubusercontent.com/EverestSmartChain/EverestSmartChain/main/samples/genesis.json
    echo "Genesis file replaced."

    # Modify app.toml for service addresses to listen on 0.0.0.0
    echo "Updating service addresses in app.toml..."
    sed -i 's/^address = ".*:1317"/address = "tcp:\/\/0.0.0.0:1317"/' /root/.evtd/config/app.toml
    sed -i 's/^address = ".*:9090"/address = "0.0.0.0:9090"/' /root/.evtd/config/app.toml
    sed -i 's/^address = ".*:8545"/address = "0.0.0.0:8545"/' /root/.evtd/config/app.toml
    sed -i 's/^ws-address = ".*:8546"/ws-address = "0.0.0.0:8546"/' /root/.evtd/config/app.toml
    sed -i '121s/enable = false/enable = true/' /root/.evtd/config/app.toml
    sed -i '124s/swagger = false/swagger = true/' /root/.evtd/config/app.toml
    sed -i 's/^persistent_peers = ""/persistent_peers = "fda3d109e4a1d46558d9f92ad6c5b3fedcb7098b@158.69.35.30:26656"/' /root/.evtd/config/config.toml
    echo "Service addresses updated in app.toml."

    # Modify config.toml for CORS and TCP specific ports
    echo "Updating config.toml for RPC CORS and service addresses..."
    sed -i 's/^proxy_app = ".*:26658"/proxy_app = "tcp:\/\/0.0.0.0:26658"/' /root/.evtd/config/config.toml
    sed -i 's/^laddr = ".*:26656"/laddr = "tcp:\/\/0.0.0.0:26656"/' /root/.evtd/config/config.toml
    sed -i 's/^laddr = ".*:26657"/laddr = "tcp:\/\/0.0.0.0:26657"/' /root/.evtd/config/config.toml
    sed -i '/\[rpc\]/,/^\[/ s/^cors_allowed_origins = .*/cors_allowed_origins = ["*", ]/' /root/.evtd/config/config.toml
    echo "CORS and service addresses updated in config.toml."

    echo "Configuration and data setup completed."
    # Mark as initialized
    touch "$INIT_FLAG"
else
    echo "evtd already initialized, skipping setup..."
fi

# Start evtd and redirect its logs
/usr/local/bin/evtd start > /var/log/evtd.log 2>&1 &
echo "evtd has been started, and its logs are being written to /var/log/evtd.log"

# Keep the container running
exec tail -f /dev/null
