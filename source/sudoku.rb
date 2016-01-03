require_relative 'board'
require_relative 'possbilities'

class Sudoku
  attr_accessor :solved_board

  def initialize(board_string)
    @solved_board = Board.new(board_string)
    @possbilities = Possibilities.new(solved_board.board_string)
    to_s(board)
    solve
  end

  def to_s(some_board)
    some_board.each do |line|
      puts line.join("")
    end
    puts "\n"
  end

  def to_s_solution(some_board)
    puts "SOLUTION:"
    to_s(some_board)
  end

  def solve

    puts "Sorry, that's impossible"
  end

end