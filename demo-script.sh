# TITLE: This is a demo script to be used with ascriiptnema
# ROOT: apihandyman.io
# SECTION: HTTP methods 1
# It reuses the  filters we have seen in list-paths.jq but now it gets a level deeper and creates an array of all of the paths properties by putting the filters chain inside brackets. Let's decompose it
echo "will wait a second before showing output" # SLEEP: 3
# This is a comment
ls -l
# The \e[0mascriiptnema.sh\e[93m script plays any shell script
cat ascriiptnema.sh
# BLANK
# 😱 It's working?
# Let's try to change prompt for the next command
# PROMPT:  \e[36m[invoking JQ] $\e[0m
# This is line 10
head ascriiptnema.sh
#         😍 That's even better! 
# DEFAULT_PROMPT
# Now we're back to the default prompt
echo "this is so great  🎉"
# Let's try an INVISIBLE command
# Here are the files before
ls -l
# INVISIBLE: touch file_created_by_INVISIBLE_command
# Now you see me (file_created_by_INVISIBLE_command)
ls -l
# INVISIBLE: rm file_created_by_INVISIBLE_command
# Now you don't (file_created_by_INVISIBLE_command)
ls -l
# A variable will be created by next invisible command
# INVISIBLE: VARIABLE="some value"
echo "something with [$VARIABLE]"
# Comment with [$VARIABLE]
# The variable can be used in commands or comments