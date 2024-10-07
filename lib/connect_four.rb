# frozen_string_literal: true

# The popular game where you have to have four consecutive dots to win
class ConnectFour
  COLUMNS = 7
  ROWS = 6

  attr_reader :buckets

  def initialize
    @buckets = []
    COLUMNS.times { @buckets << [] }
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
