# TITLE: Demo script played by ascriiptnema and recorded with asciinema
# ROOT: ascriiptnema
# SECTION: comments
# Comments are done like regular comments in bash with #
# ROOT: first level prompt
# You can change first level of prompt with ROOT
# SECTION: second level prompt
# You can change second level of prompt with SECTION
# ROOT: ascriiptnema
# TITLE: You can show a title with TITLE
# SECTION: commands
ls -l
# The ls -l command has been executed
# SECTION: sleep before command
echo "will wait 5 seconds before showing output" # SLEEP: 5
# SECTION: blank lines
# There will be a blank line after this comment
# BLANK
# SECTION: invisble commands
# There's an invisible command defining a dummy_variable right after that
dummy_variable="dummy" # INVISIBLE
echo "dummy_variable=$dummy_variable"
# There's an invisible unset dummy_variable right after that
unset dummy_variable # INVISIBLE
echo "dummy_variable=$dummy_variable"
# SECTION: start at line X
# You can start at line 29 if you want want by calling "ascriiptnema demo-ascriiptname.sh 29", every previous line will be played silently
# SECTION: ascriiptname files
# Here's the file used to make this recording
bat demo-ascriiptnema.sh
# It can be executed like a regular file
# Have fun! 
