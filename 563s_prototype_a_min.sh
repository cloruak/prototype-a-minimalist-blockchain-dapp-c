#!/bin/bash

# Define a minimalist data model for the blockchain dApp controller

# Block structure
declare -A BLOCK=(
  [index]=0
  [timestamp]=$(date +%s)
  [data]=""
  [hash]=""
  [previous_hash]=""
)

# Transaction structure
declare -A TRANSACTION=(
  [id]=""
  [from]=""
  [to]=""
  [amount]=""
  [timestamp]=$(date +%s)
)

# Blockchain structure
declare -A BLOCKCHAIN=(
  [chain]=""
  [pending_transactions]=""
)

# Function to add a new block to the blockchain
add_block() {
  BLOCK[index]=$((BLOCK[index]+1))
  BLOCK[timestamp]=$(date +%s)
  BLOCK[data]=$1
  BLOCK[hash]=$(sha256sum <<< "$BLOCK[previous_hash]$BLOCK[data]")
  BLOCKCHAIN[chain]+=$BLOCK
  BLOCKCHAIN[pending_transactions]=""
}

# Function to add a new transaction to the pending transactions
add_transaction() {
  TRANSACTION[id]=$1
  TRANSACTION[from]=$2
  TRANSACTION[to]=$3
  TRANSACTION[amount]=$4
  TRANSACTION[timestamp]=$(date +%s)
  BLOCKCHAIN[pending_transactions]+=$TRANSACTION
}

# Initialize the blockchain
BLOCKCHAIN[chain]=""
BLOCKCHAIN[pending_transactions]=""

# Example usage:
add_transaction "TX01" "Alice" "Bob" 1.0
add_transaction "TX02" "Bob" "Charlie" 2.0
add_block "Block 1"
add_block "Block 2"
echo "Blockchain: ${BLOCKCHAIN[chain]}"