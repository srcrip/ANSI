# Crystal ANSI

This library helps send escape sequences to Unix terminals. Now you don't need to use bloated dependencies like termbox or curses to position text in the terminal.

## Installation

Include this in your `shard.yml` file:

```yml
dependencies:
  ANSI:
    github: Sevensidedmarble/ANSI
    branch: master
```

Then run `shards install` to update your dependencies.

Require and include the ANSI module in your code:

`require "ANSI"`

And then:

`include ANSI`

## Usage

The escape sequence methods can be used like so:

```crystal
require "ANSI"
include ANSI

ANSI.clear
ANSI.move(0, 1)
print "Print text at different positions."
ANSI.move(20, 20)
print "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
sleep 2

ANSI.save
ANSI.clear
print "Save the state of the screen."
sleep 2

ANSI.clear
ANSI.restore
ANSI.move(0, 2)
print "And restore it later."
sleep 2

ANSI.clear
size = ANSI.size
w = size[:width]
h = size[:height]
ANSI.move(0, 0)
print "Width: " + w.to_s + ", Height: " + h.to_s
sleep 2
```

Most of the escape sequences are pretty self explanatory by name. There's a wonderful guide [here](http://invisible-island.net/xterm/ctlseqs/ctlseqs.html) if you want more details.
