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
    @available_spaces = ROWS * COLUMNS
  end

  def play_game
    introduction
    loop do
      choice = play
      pretty_print
      return if last_message?(choice)

      @turn = (@turn + 1) % 2
    end
  end

  def last_message?(choice)
    if game_over?(@buckets[choice].length - 1, choice)
      puts "Congratulations! Player #{@turn + 1}, You are the winner!"
      return True
    end
    return False unless @available_spaces.zero?

    puts "It's a draw!"
    True
  end

  def play
    puts "It's player #{@turn + 1} turn."
    choice = player_input until player_input
    @buckets[choice] << @turn
    @available_spaces -= 1
    choice
  end

  def introduction
    puts 'Welcome to connect four! Here is the board'
    pretty_print
    puts 'You can choose one of the columns'
  end

  def player_input
    print 'Choose the place you want to put your tag: '
    choice = gets.chomp.to_i
    choice - 1 if choice.between(1, COLUMNS) && buckets[choice - 1].length < ROWS
  end

  def pretty_print
    (ROWS - 1).downto(0) do |row|
      COLUMNS.times do |col|
        val = buckets[col][row]
        print pretty(val)
      end
      puts
    end
    COLUMNS.times { |ind| print "#{ind + 1}  " }
    puts
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
