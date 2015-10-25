class Sudoku
  def initialize(board_string)
  	@board = board_string.scan(/.{9}/)
  	p @board
  end

  def missing_nos_row
  	found_nos = {'-'=>0, '1'=>0, '2'=>0, '3'=>0, '4'=>0, '5'=>0, '6'=>0, '7'=>0, '8'=>0, '9'=>0}

  	missing_nos_each_row = {}

  	row_index = 0

  	@board.each do |row|

  		row.each_char do |cell|
  			found_nos[cell] += 1
  		end

  		missing_nos_one_row = found_nos.select{|num, occurrance| occurrance==0}.keys

  		missing_nos_each_row[row_index] = missing_nos_one_row

  		found_nos.each{|k, v| found_nos[k]=0}
  		row_index += 1
  	end

  	p missing_nos_each_row
  end

  def missing_nos_col

  end

  def possibilities_each_cell

  end

  def solve
  end

  def board
  end

  # Returns a string representing the current state of the board
  def to_s
  end
end

board = Sudoku.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--
')

board.missing_nos_row