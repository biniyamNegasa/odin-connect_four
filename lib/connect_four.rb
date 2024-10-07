# frozen_string_literal: true

# The popular game where you have to have four consecutive dots to win
class ConnectFour
  COLUMNS = 7
  ROWS = 6

  attr_reader :buckets

  def initialize
    @turn = 0
    @buckets = []
    COLUMNS.times { @buckets << [] }
  end

  def player_input
    print 'Choose the place you want to put your tag: '
    choice = gets.chomp.to_i
    choice - 1 if choice.between(1, COLUMNS)
  end

  def pretty_print
    (ROWS - 1).downto(0) do |row|
      COLUMNS.times do |col|
        val = buckets[col][row]
        print pretty(val)
      end
      puts
    end
  end

  def inbound?(row, col)
    row.between?(0, ROWS - 1) && col.between?(0, COLUMNS - 1)
  end

  def game_over?(row, col)
    drx = [[[0, 1], [0, -1]], [[1, 0], [-1, 0]], [[1, 1], [-1, -1]], [[-1, 1], [1, -1]]]

    drx.each do |path|
      first, second = path
      consecutives = count(row, col, first) + count(row, col, second) - 1
      return true if consecutives >= 4
    end
    false
  end

  private

  def pretty(val)
    if val.nil?
      '__ '
    else
      (val == 1 ? "\033[93m\u262f " : "\033[92m\u262f ")
    end
  end

  def count(row, col, path)
    val = buckets[col][row]
    count = 0
    r, c = path
    while inbound?(row, col) && buckets[col][row] == val
      row += r
      col += c
      count += 1
    end
    count
  end
end
