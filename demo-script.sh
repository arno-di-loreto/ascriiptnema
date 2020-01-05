ls *-openapi.json
cat demo-api-openapi.json
cat demo-api-openapi.json | jq '.'
cat demo-api-openapi.json | jq '.' | wc -l
cat demo-api-openapi.json | jq '.info'
cat demo-api-openapi.json | jq '.info.title'
