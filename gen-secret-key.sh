#!/bin/bash

# Function to generate the API key in the OpenAI format `sk-[20 characters]T3BlbkFJ[20 characters]`
generate_api_key() {
  local prefix="secret-"
  local part1=$(openssl rand -hex 10)  # First 20 characters
  local constant="T3BlbkFJ"                # Constant middle part
  local part2=$(openssl rand -hex 10)  # Last 20 characters

  # Combine the parts to form the key
  local api_key="$prefix$part1$constant$part2"
  echo "$api_key"
}

# Generate and print the API key
api_key=$(generate_api_key)
echo "Generated API Key: $api_key"
