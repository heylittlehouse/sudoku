require 'pry'

class Sudoku
  attr_reader :board
  attr_accessor :solved_board

  def initialize(board_string)
    @board = board_string.split("").each_slice(9).to_a
    @solved_board = @board
    to_s(board)
  end

  def to_s(some_board)
    some_board.each do |line|
      puts line.join("")
    end
    puts "\n"
  end

  def solved?
    solved_board.flatten.include?("-")
  end

  def solve
    return false if !legal_board?
    return to_s(solved_board) if solved?

  end
end