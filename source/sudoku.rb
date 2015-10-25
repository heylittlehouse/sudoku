class Sudoku
  def initialize(board_string)
  	#turns board into array of arrays
  	@board = board_string.scan(/.{9}/).map{|string| string.split("")}
  	to_s
  end

#returns hash of missing numbers for each row.
  def missing_nos_row
  	found_nos = {'-'=>0, '1'=>0, '2'=>0, '3'=>0, '4'=>0, '5'=>0, '6'=>0, '7'=>0, '8'=>0, '9'=>0}
  	missing_nos_each_row = {}
  	row_index = 0

  	@board.each do |row|
  		row.each do |cell|
  			found_nos[cell] += 1
  		end

  		missing_nos_one_row = found_nos.select{|num, occurrance| occurrance==0}.keys
  		missing_nos_each_row[row_index] = missing_nos_one_row

  		found_nos.each{|k, v| found_nos[k]=0}
  		row_index += 1
  	end

  	missing_nos_each_row
  end

  def missing_nos_col
  	@board = @board.transpose
  	missing_nos_row
  end

#create a new hash that associates coordinate cell with possible answers
  def get_possibilities_each_cell
  	possibilities_each_cell = {}
  	missing_rows, missing_col = missing_nos_row, missing_nos_col
  	@board = @board.transpose #puts board back in original position after missing_nos_col call

  	missing_rows.each do |row, missing_in_row|
  		missing_col.each do |col, missing_in_col|
  			coordinate = [row, col]
  			possibilities_each_cell[coordinate] = missing_in_row & missing_in_col if @board[row][col] == '-'
  		end
  	end

  	possibilities_each_cell
  end

  def won?
  	! @board.flatten.include?('-')
  end

  def valid_subsection?(array)
  	#need methods that create a single array for a row, column, and box
  	checker = array.uniq
  	array == checker
  end

  def legal_board?
  	@board.each do |row|
  		valid_subsection?(row)
  	end

  	@board.transpose.each do |col|
  		valid_subsection?(col)
  	end

	organize_board_according_to_3x3_squares.each do |square|
		valid_subsection?(square)
	end  	
  end

#returns array where each element is an array of 3x3 squares.
  def organize_board_according_to_3x3_squares
  	board_in_3_by_3_squares =[]

  	begin_index = 0
  	end_index = 2

  	while board_in_3_by_3_squares.length < 9
	  	@board.each do |row|
	  		three_by_three = []

	  		three_by_three << row[begin_index..end_index]
			board_in_3_by_3_squares<<three_by_three.flatten
	  	end
	  	begin_index +=3
	  	end_index +=3
  	end
  	board_in_3_by_3_squares
  end

  def solve(board = @board)
  	@board = board
  	#base cases
  	return false if !legal_board?
  	return to_s if  won?
  	possibilities_each_cell = get_possibilities_each_cell

  	possibilities_each_cell.each do |coordinate, possible_answers|
  		row_index, col_index = coordinate[0], coordinate[1]

  		possible_answers.each do |possible_answer|
  			@board[row_index][col_index] = possible_answer
  		end
  	end

  	solve(@board)
  end


  # Returns a string representing the current state of the board
  def to_s
  	@board.each{|row| puts row.join("")}
  end
end

board = Sudoku.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--
')

board.solve('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--')