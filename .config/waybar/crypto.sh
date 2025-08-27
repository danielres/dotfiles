#!/usr/bin/env bash
data=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum&vs_currencies=eur")
btc=$(echo "$data" | jq -r '.bitcoin.eur')
eth=$(echo "$data" | jq -r '.ethereum.eur')
echo "{\"text\": \"$btc | $eth\", \"tooltip\": \"BTC | ETH\"}"
