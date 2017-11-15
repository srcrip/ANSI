# A demonstration
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
