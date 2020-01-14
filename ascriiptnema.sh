#!/usr/bin/env bash
# Example: # ascriiptnema.sh demo-script.sh 
# Example: # ascriiptnema.sh demo-script.sh 10

clear
resize -s 24 80 &>/dev/null

# echo -e not working in asciinema?

# Trap CTRL+C to be able to exit before the actual end of the script
trap ctrl_c INT
function ctrl_c() {
  exit
}

# Print a dummy prompt [root in blue][section in pink] $ (in blue)
print_prompt() {
  printf "\e[36m[$1]\e[0m\e[95m[$2]\e[0m \e[36m$\e[0m"
}

# Print session's title in green
print_title() {
  printf "\\e[92m$1\\e[0m";echo
}

# Break comment line betwen words if longer than terminal width
# Note fold do not like escape sequence at all
print_comment () {
  pc_prompt_root="$1"
  pc_prompt_section="$2"
  pc_prompt="[$pc_prompt_root][$pc_prompt_section] $"
  pc_comment="# $3"
  full_message="$pc_prompt$pc_comment"
  full_message_length=${#full_message}
  terminal_width=`tput cols`
  print_prompt "$pc_prompt_root" "$pc_prompt_section"
  if [[ $full_message_length -gt $terminal_width ]];
  then
    pc_prompt_length=${#pc_prompt}
    first_line="${full_message:0:$terminal_width}"
    first_line=`echo "$first_line" | sed -e 's/[[:space:]]*[[:graph:]]*$//'`
    first_line="${first_line:$pc_prompt_length}"
    first_line_length=${#first_line}
    next_line="${pc_comment:$first_line_length}"
    printf "\e[93m"
    printf "$first_line" | $PV_COMMAND
    echo
    printf "$next_line" | fold -s -w$terminal_width | $PV_COMMAND
    printf "\e[0m"
    echo
  else
    printf "\e[93m$pc_comment\e[0m" | $PV_COMMAND
    echo
  fi
}

script=$1
startlinenumber=$2
if [[ -z $startlinenumber ]];
then
  startlinenumber=1
fi
linenumber=0

# Reads the script file line by line
REGEX_TITLE="^\#[[:blank:]]*TITLE:[[:blank:]]*"
REGEX_ROOT="^\#[[:blank:]]*ROOT:[[:blank:]]*"
REGEX_SECTION="^\#[[:blank:]]*SECTION:[[:blank:]]*"
REGEX_BLANK="^\#[[:blank:]]*BLANK"
REGEX_INVISIBLE="^\#[[:blank:]]*INVISIBLE:[[:blank:]]*"
REGEX_COMMENT="^\#[[:blank:]]*"
PV_COMMAND="pv -qL $[10+(-2 + RANDOM%5)]"
while IFS= read -r line
do
  linenumber=$((linenumber + 1))
  # Prints a title
  if [[ $line =~ $REGEX_TITLE ]];
  then
    title=`echo "$line" | sed -e 's/^\#[[:blank:]]*TITLE:[[:blank:]]*//'`
    print_title "$title"
  # Change root in prompt
  elif [[ $line =~ $REGEX_ROOT ]];
  then
    prompt_root=`echo "$line" | sed -e 's/^\#[[:blank:]]*ROOT:[[:blank:]]*//'`
  # Changes section in prompt
  elif [[ $line =~ $REGEX_SECTION ]];
  then
    prompt_section=`echo "$line" | sed -e 's/^\#[[:blank:]]*SECTION:[[:blank:]]*//'`
  # A blank line without prompt
  elif [[ $line =~ $REGEX_BLANK ]];
  then
    if [[ $linenumber -ge $startlinenumber ]];
    then
      echo
    fi
  # An invisible command
  elif [[ $line =~ $REGEX_INVISIBLE ]];
  then
    command=`echo "$line" | sed -e 's/^\#[[:blank:]]*INVISIBLE:[[:blank:]]*//'`
    eval $command
  # A comment
  elif [[ $line =~ $REGEX_COMMENT ]];
  then
    if [[ $linenumber -ge $startlinenumber ]];
    then
      # Did not succeed yet to use the regex var 🤔
      comment=`echo "$line" | sed -e 's/^\#[[:blank:]]*//'`
      print_comment "$prompt_root" "$prompt_section" "$comment"
    fi
  # A command line
  else
    REGEX_SLEEP="[[:blank:]]*\#[[:blank:]]*SLEEP:.*$"
    # Managing sleep before actually executing command
    # in order to let user actually see the full command
    unset sleep_time
    if [[ $line =~ $REGEX_SLEEP ]]
    then
      command=`echo "$line" | sed -e s/[[:blank:]]*\#[[:blank:]]*SLEEP:.*$//`
      sleep_time=`echo "$line" | sed -e s/^.*[[:blank:]]*\#[[:blank:]]*SLEEP:[[:blank:]]*//`
    else
      command=$line
    fi
    if [[ $linenumber -ge $startlinenumber ]];
    then
      print_prompt "$prompt_root" "$prompt_section" 
      # Simulates command typing
      printf "\e[2m"
      echo "$command" | $PV_COMMAND
      printf "\e[0m"
      # Sleep before execution if requested
      # Can be used to let viewers the time to actually read the command line
      if [[ $sleep_time ]]
      then
        sleep $sleep_time
      fi
      # Actually executes it
      eval $command
    else
      command="$command &>/dev/null"
      eval $command
    fi;
  fi
done < "$script"
