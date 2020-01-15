# AscriiptnemA

Experimental tool that aims to ease Asciinema session recording by executing scripts as if they were typed by a human being.

## Example

The demo-ascriiptnema.sh script is totally usable in your terminal. But all commands are done at once.
Thank to ascriiptname, you can get this:

![AscriiptnemA in action](demo.gif?raw=true)

With AscriiptenamA, you can simulate it's execution as it was typed by a human being (comments included!)

```
ascriiptnema.sh demo-script.sh
```

Starting at a given line (all previous line are executed silently)
```
ascriiptnema.sh demo-script.sh 17
```

## Options

AscriiptnemA can play any regular sh file. The comments are printed in yellow and commands in light grey.
There are special comments that can be used:

- TITLE
- ROOT
- SECTION
- BLANK
- INVISIBLE
- SLEEP

### TITLE

TITLE prints a green title without prompt

```
# TITLE Some title
```

### ROOT

ROOT changes the [first value] in the prompt
```
# ROOT Something
```

### SECTION

SECTION changes the [second value] in the prompt
```
# SECTION Else
```

### BLANK

BLANK prints a blank line without prompt
```
# SECTION Else
```

### INVISIBLE

INVISIBLE play a comment without typing it. It's up to you to make the command totally silent
```
# INVISIBLE: git checkout tags/some-tag some-file.jq &>/dev/null
```
### SLEEP

SLEEP sleeps a number of second after typing a command and before executing it

```
ls -l # SLEEP 5
```

## Recording with Asciinema
This script aims to ease Asciinema sessions recording:
```
asciinema rec -c "ascriiptnema.sh demo-script.sh" demo.cast
```

## Recording multiple ascriiptnema

The following command will play and record all *-ascriiptname.sh in /some/path and save the *.cast files in the same folder. 
```
rec-ascriiptnemas.sh /some/path
```
