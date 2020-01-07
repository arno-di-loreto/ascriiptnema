# Example: # ascriiptnema.sh demo-script.sh "\e[36m[default prompt] $\e[0m" 
# Example: # ascriiptnema.sh demo-script.sh "\e[36m[default prompt] $\e[0m" 10

# Trap CTRL+C to be able to exit before the actual end of the script
trap ctrl_c INT
function ctrl_c() 
{
  exit
}

script=$1
defaultprompt=$2
prompt=$2
linenumber=$3
if [[ -z "$linenumber" ]]
then
  readcommand="cat $script"
else
  readcommand="tail -n+$linenumber $script"
fi
# Reads the script file line by line
REGEX_PROMPT="^\#[[:blank:]]*PROMPT:[[:blank:]]*"
REGEX_DEFAULT_PROMPT="^\#[[:blank:]]*DEFAULT_PROMPT"
REGEX_BLANK="^\#[[:blank:]]*BLANK"
REGEX_INVISIBLE="^\#[[:blank:]]*INVISIBLE:[[:blank:]]*"
REGEX_COMMENT="^\#[[:blank:]]*"
PV_COMMAND="pv -qL $[10+(-2 + RANDOM%5)]"
while IFS= read -r line
do
  # Changes prompt
  if [[ $line =~ $REGEX_PROMPT ]];
  then
    prompt=`echo $line | sed -e 's/^\#[[:blank:]]*PROMPT:[[:blank:]]*//'`
  # Get back to default prompt
  elif [[ $line =~ $REGEX_DEFAULT_PROMPT ]];
  then
    prompt=$defaultprompt
  # A blank line without prompt
  elif [[ $line =~ $REGEX_BLANK ]];
  then
    echo
  # An invisible command
  elif [[ $line =~ $REGEX_INVISIBLE ]];
  then
    command=`echo $line | sed -e 's/^\#[[:blank:]]*INVISIBLE:[[:blank:]]*//'`
    eval $command
  # A comment
  elif [[ $line =~ $REGEX_COMMENT ]];
  then
    # Dummy prompt
    printf "$prompt"
    # Better cleaning, a comment is supposed do be "# blah blah blah"
    # Did not succeed yet to use the regex var 🤔
    comment=`echo $line | sed -e 's/^\#[[:blank:]]*//'`
    # Evaluating comment (there may be some variables)
    comment=`eval "echo \"$comment\""`
    # Printing in yellow
    # Got (unsolved) problem with coloring when using echo -e, that's why printf is used
    printf "\e[93m$comment\e[0m" | $PV_COMMAND
    echo
  # A command line
  else
    # Dummy prompt
    printf "$prompt"
    REGEX_SLEEP="[[:blank:]]*\#[[:blank:]]*SLEEP:.*$"
    # Managing sleep before actually executing command
    # in order to let user actually see the full command
    unset sleep_time
    if [[ $line =~ $REGEX_SLEEP ]]
    then
      command=`echo $line | sed -e s/[[:blank:]]*\#[[:blank:]]*SLEEP:.*$//`
      sleep_time=`echo $line | sed -e s/^.*[[:blank:]]*\#[[:blank:]]*SLEEP:[[:blank:]]*//`
    else
      command=$line
    fi
    # Simulates command typing
    echo "$command" | $PV_COMMAND
    # Sleep before execution if requested
    if [[ $sleep_time ]]
    then
      sleep $sleep_time
    fi
    # Actually executes it
    command=`echo $line | sed -e s/\\\\t/\\t/`
    eval $command
  fi
done < <($readcommand)