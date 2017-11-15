require "./ANSI/*"

# The holy grail for terminal escaping is here: http://invisible-island.net/xterm/ctlseqs/ctlseqs.html
# Modern virtual terminals such as xterm support a *lot* of escape sequences. These are just some of the most useful.
module ANSI
  # These are called capnames (capability names), and they refer to entries in the terminfo database for a given terminal.
  CUP = self.move

  # Clear the screen.
  def self.clear
    print "\e[2J"
  end

  # Move to position row, col.
  def self.move(row, col)
    print "\e[#{row + 1};#{col + 1}H"
  end

  # Move up by n cells.
  def self.move_up(n)
    print "\e[#{n}A"
  end

  # Move down by n cells.
  def self.move_down(n)
    print "\e[#{n}B"
  end

  # Move forward by n cells.
  def self.move_forward(n)
    print "\e[#{n}C"
  end

  # Move backward by n cells.
  def self.move_backward(n)
    print "\e[#{n}D"
  end

  # Resets all line attributes.
  def self.reset
    "\e[0m"
  end

  # Save the state of the screen.
  def self.save
    print "\e[?1049h"
  end

  # Restore the state of the screen.
  def self.restore
    print "\e[?1049l"
  end

  def self.show_cursor
    print "\e[?12l\e[?25h"
  end

  def self.hide_cursor
    print "\e[?25l"
  end

  # Return the screen size.
  def self.size
    {
      height: `tput lines`,
      width:  `tput cols`,
    }
  end
end
