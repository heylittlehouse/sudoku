require_relative 'board'
require_relative 'possibilities'
require 'pry'

class Sudoku
  attr_accessor :solved_board, :possibilities

  def initialize(board_string)
    @solved_board = Board.new(board_string)
    @possibilities = Possibilities.new(solved_board)
    # to_s(solved_board.board)
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
    return false if !solved_board.legal_board?
    return to_s_solution(solved_board.board) if solved_board.solved?
    return false if possibilities.empty?

    possibilities.possibilities.each do |possibility|
      new_string = solved_board.board_string.dup
      new_string[possibilities.next_cell_string_index] = possibility
      Sudoku.new(new_string)
    end

    return false
  end

end