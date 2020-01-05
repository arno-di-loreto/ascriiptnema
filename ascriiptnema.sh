script=$1
prompt=$2
# Reads the script file line by line
while IFS= read -r line
do
  # Dummy prompt
  printf "$prompt"
  # Simulates command typing
  echo "$line" | pv -qL $[10+(-2 + RANDOM%5)]
  # Actually executes it
  eval $line
done < "$script"