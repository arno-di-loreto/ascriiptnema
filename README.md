# AscriiptnemA

Types and executes command like a human being.

## Example

The following script is totally usable in your terminal.
But all commands are done at once.
```
demo-script.sh
```

With AscriiptenamA, you can simulate it's execution as it was typed by a human being (comments included!)

```
ascriiptnema.sh demo-script.sh
```

Starting at a given line (all previous line are executed silently)
```
ascriiptnema.sh demo-script.sh
```

## Asciiname
This script aims to ease Asciinema sessions recording:
```
asciinema rec -c "ascriiptnema.sh demo-script.sh" demo.cast
```