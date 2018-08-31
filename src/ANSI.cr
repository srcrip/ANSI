require "colorize"

# More information can be found here: http://invisible-island.net/xterm/ctlseqs/ctlseqs.html
# Modern virtual terminals such as xterm support a *lot* of escape sequences. These are just some of the most useful.
module ANSI
  extend self
  class_property? enabled : Bool = true

  # Make `ANSI.enabled` `true` if and only if both of `STDOUT.tty?` and `STDERR.tty?` are `true`.
  def self.on_tty_only!
    self.enabled = STDOUT.tty? && STDERR.tty?
  end

  # TODO add checking against terminfo
  private CODES = [
    ["home", "\e[H", "home"],
    ["bell", "\e[G", "bel"],
    ["reset", "\e[Z"],
    ["clear_to_end", "\e[K"],
    ["save_cursor", "\e[s"],
    ["restore_cursor", "\e[u"],
    ["save_screen", "\e[47h"],
    ["restore_screen", "\e[47l"],
    ["show_cursor", "\e[25l"],
    ["hide_cursor", "\e[25h"],
  ]

  private CODES_WITH_ARGS = [
    ["move_cursor", [
      ->(row : Int32, col : Int32) { "\e[#{row.to_s};#{col.to_s}H" },
      ["row", "col"],
    ], "cup"],
    ["move_cursor_up", [
      ->(n : Int32) { "\e[#{n.to_s}A" },
      ["n"],
    ], "cuu"],
    ["move_cursor_down", [
      ->(n : Int32) { "\e[#{n.to_s}B" },
      ["n"],
    ], "cud"],
    ["move_cursor_right", [
      ->(n : Int32) { "\e[#{n.to_s}C" },
      ["n"],
    ], "cuf"],
    ["move_cursor_down", [
      ->(n : Int32) { "\e[#{n.to_s}D" },
      ["n"],
    ], "cub"],
    ["next_line", [
      ->(n : Int32) { "\e[#{n.to_s}E" },
      ["n"],
    ], "cnl"],
    ["previous_line", [
      ->(n : Int32) { "\e[#{n.to_s}F" },
      ["n"],
    ], "cpl"],
    ["move_to_horizontal", [
      ->(n : Int32) { "\e[#{n.to_s}G" },
      ["n"],
    ], "cha"],
    # Erase display (default: from cursor to end of display).
    # ESC [ 1 J: erase from start to cursor.
    # ESC [ 2 J: erase whole display.
    # ESC [ 3 J: erase whole display including scroll-back.
    ["erase", [
      ->(n : Int32) { "\e[#{n.to_s}J" },
      ["n"],
    ], "ed"],
    # Erase line (default: from cursor to end of line).
    # ESC [ 1 K: erase from start of line to cursor.
    # ESC [ 2 K: erase whole line.
    ["erase_line", [
      ->(n : Int32) { "\e[#{n.to_s}K" },
      ["n"],
    ], "el"],
  ]

  {% for code in CODES %}
    def {{code[0].id}} (io = STDOUT)
      io << {{code[1]}} if enabled?
    end
  {% end %}

  {% for code in CODES_WITH_ARGS %}
    def {{code[0].id}} ({{*code[1][0].args}}, io = STDOUT)
      io << {{code[1][0]}}.call({{*code[1][1].map &.id}}) if enabled?
    end
  {% end %}

  def clear
    erase 2
  end

  def print_at(str, x, y)
    move_cursor(x, y)
    print str
  end

  def clear!
    clear && home && reset
  end

  def save
    save_cursor && save_screen
  end

  def restore
    restore_cursor && restore_screen
  end

  # Return the screen size.
  def size!
    if system "command -v tput"
      {cols: `tput cols`.to_i, rows: `tput lines`.to_i}
    else
      raise UnsupportedTerminal.new "System does not have tput"
    end
  end

  class UnsupportedTerminal < Exception
  end
end

# ANSI.move_cursor(5, 5)
ANSI.clear!
