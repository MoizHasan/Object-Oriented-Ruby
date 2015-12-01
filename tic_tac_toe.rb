#Build a tic-tac-toe game on the command line 
#where two human players can play against each other and the board is displayed in between turns.

class TicTacToe
 
	def initialize
		@turns = 0
		@end_message = "It's a draw!"
		@player = 1
		@position = 0
		@board = []
		9.times {@board << " "}
		@winning_combinations = [[1,2,3],[1,4,7],[1,5,9],[2,5,8],[3,6,9],[3,5,7],[4,5,6],[7,8,9]]
	end
	
 
	def is_over
	#returns the state of the game.
		return true if @turns == 9
		false
		#impossible for there to be a winner before this point.
		if @turns > 4
			@winning_combinations.each do |i|
			#elements that contain all the same token denote a winner.
				if (i.all? {|x| x== "X"})
					@end_message = "Player 1 wins."
					return true
				elsif (i.all? {|x| x== "O"})
					@end_message = "Player 2 wins."
					return true
				end
			end
		end
		false
	end
	
	def player_prompt
		@player == 1 ? token = "X" : token = "O"
		puts "Player " + @player.to_s + " it is your turn."
		puts " Choose a position(1-9)."
		position = (gets.chomp).to_i
		#check for valid range and not already filled position.
		while position < 1 || position > 9 || @board[position-1] != " "
			if position > 0 && position < 9
				puts " Oops!, This spot is already taken."
			end
			puts " please enter a valid position(1-9)."
			position = (gets.chomp).to_i
		end
		@board[position-1] = token
		#winning combinations array is changed to token value where applicable.
		@winning_combinations.each do |i|
			if i.include?(position)
				i[i.index(position)] = token
			end
		end
		@turns += 1
		#switch to the next player's turn.
		@player == 1 ? @player = 2 : @player = 1 
		board_printer
	end
	
	def board_printer
		#this method will output the current board state.
		puts  "#{@board[0]} | #{@board[1]} | #{@board[2]}"
		puts "--+---+--"
		puts  "#{@board[3]} | #{@board[4]} | #{@board[5]}"
		puts "--+---+--"
		puts  "#{@board[6]} | #{@board[7]} | #{@board[8]}"
		end
		
	def game
		puts "Welcome to Tic-Tac-Toe! Player 1 will be X and Player 2 will be O."
		board_printer
		while is_over() == false
			player_prompt
		end
		puts @end_message
		puts "play again?(Y/N)"
		ans = gets.chomp
		if ans.downcase == "y" || ans.downcase == "yes"
			initialize
			self.game
		end
		puts "Thanks for playing."
	end
		
		a = TicTacToe.new
		a.game
end
		