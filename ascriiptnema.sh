# POC aiming to demonstrate how to simulate commands typing and execution
# Types and execute jq '.info' demo-api-openapi.json"
# Prints a dummy prompt
printf "apihandyman.io \$"
# Simulate human typing using pv
echo "jq '.info' demo-api-openapi.json" | pv -qL $[10+(-2 + RANDOM%5)]
# Actually executes the command
jq '.info' demo-api-openapi.json
# Same thing here
printf "apihandyman.io \$"
echo "jq '.info.title' demo-api-openapi.json" | pv -qL $[10+(-2 + RANDOM%5)]
jq '.info.title' demo-api-openapi.json