#!/bin/bash

# Step 1: Prompt for the node name
read -p "Enter the node name: " nodeName

# Check if nodeName is empty
if [ -z "$nodeName" ]; then
    echo "Node name cannot be empty. Please run the script again."
    exit 1
fi

# Step 2: Update the entrypoint.sh script
# Ensure you have a placeholder like NODE_NAME_PLACEHOLDER in your entrypoint.sh script
sed -i "s/NODE_NAME_PLACEHOLDER/$nodeName/g" entrypoint.sh
echo "The node name has been set to '$nodeName'."

# Step 3: Build the Docker image using Docker Compose
echo "Building Docker image..."
docker compose build .

# Step 4: Run the Docker container using Docker Compose
echo "Running Docker container..."
docker compose up -d

echo "Deployment complete."
