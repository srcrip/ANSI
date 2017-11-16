# The holy grail for terminal escaping is here: http://invisible-island.net/xterm/ctlseqs/ctlseqs.html
# Modern virtual terminals such as xterm support a *lot* of escape sequences. These are just some of the most useful.
module ANSI
  # These are called capnames (capability names), and they refer to entries in the terminfo database for a given terminal.
  CUP = self.move

  def self.print_at(str, x, y)
    self.move(x, y)
    print str
  end

  # Clear the screen.
  def self.clear
    print "\e[2J"
  end

  # Call Clear, Home, and Reset
  def self.clear!
    self.clear
    self.home
    print self.reset
  end

  # Move cursor to home position (should be at the upper left of the screen).
  def self.home
    print "\e[H"
  end

  # Move to position row, col.
  def self.move(col, row)
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

  # Save the state of the cursor.
  def self.save_cursor
    print "\e[s"
  end

  # Restore the state of the cursor.
  def self.restore_cursor
    print "\e[u"
  end

  # Save the state of the screen.
  def self.save_screen
    print "\e[?1049h"
  end

  # Restore the state of the screen.
  def self.restore_screen
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
      height: `tput lines`.to_i,
      width:  `tput cols`.to_i,
    }
  end
end
