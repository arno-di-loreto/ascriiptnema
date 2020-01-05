# Example: # ascriiptnema.sh demo-script.sh "\e[36m[default prompt] $\e[0m"

# Trap CTRL+C to be able to exit before the actual end of the script
trap ctrl_c INT
function ctrl_c() 
{
  exit
}

script=$1
defaultprompt=$2
prompt=$2
# Reads the script file line by line
REGEX_PROMPT="^\#[[:blank:]]*PROMPT:[[:blank:]]*"
REGEX_DEFAULT_PROMPT="^\#[[:blank:]]*DEFAULT_PROMPT"
while IFS= read -r line
do
  # Changes prompt
  if [[ $line =~ $REGEX_PROMPT ]];
  then
    prompt=`echo $line | sed -e 's/^\#[[:blank:]]*PROMPT:[[:blank:]]*//'`
    #prompt=`echo $line | sed -e 's/$REGEX_PROMPT//'`
  # Get back to default prompt
  elif [[ $line =~ $REGEX_DEFAULT_PROMPT ]];
  then
    prompt=$defaultprompt
  elif [[ $line =~ ^\# ]];
  then
    # Dummy prompt
    printf "$prompt"
    # Lazy cleaning, a comment is supposed do be "# blah blah blah"
    # So, just removing the first two characters
    comment=${line:2}
    # Printing in yellow without prompt
    # Got (unsolved) problem with coloring when using echo -e, that's why printf is used
    printf "\e[93m$comment\e[0m" | pv -qL $[10+(-2 + RANDOM%5)]
    echo
  # A command line
  else
    # Dummy prompt
    printf "$prompt"
    # Simulates command typing
    echo "$line" | pv -qL $[10+(-2 + RANDOM%5)]
    # Actually executes it
    eval $line
  fi
done < "$script"