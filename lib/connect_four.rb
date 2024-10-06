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
end
