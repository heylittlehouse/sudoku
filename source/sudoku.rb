require 'pry'

class Sudoku
  attr_reader :board

  def initialize(board_string)
    @board = board_string.split("").each_slice(9).to_a
    to_s
  end

  def to_s
    board.each do |line|
      puts line.join("")
    end
    puts "\n"
  end

  def solve

  end
end