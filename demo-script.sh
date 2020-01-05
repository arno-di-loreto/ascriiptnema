ls *-openapi.json
# The \e[0mdemo-api-openapi.json\e[93m file is an OpenAPI file. Let's see what's inside with a good old \e[0mcat\e[93m command
cat demo-api-openapi.json
# 
# 😱 That's unreadable!
# Let's try to pipe this into jq
cat demo-api-openapi.json | jq '.'
# 😍 That's better! 
# The \e[0mcat demo-api-openapi.json | jq '.'\e[93m command beautified and colored the JSON content 🎉
# But that's ...
cat demo-api-openapi.json | jq '.' | wc -l
# ... lines long. That's still not easy to read in a terminal
# What if we want to just get the info section?
cat demo-api-openapi.json | jq '.info'
# 😎 Cool!
# And you probaly already guessed how to get only the API name (title in info)
cat demo-api-openapi.json | jq '.info.title'
# 🤯 Dead simple isn't it?
