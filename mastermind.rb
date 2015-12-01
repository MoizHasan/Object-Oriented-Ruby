class Mastermind

#Build a Mastermind game from the command line 
#where you have 12 turns to guess the secret code
#starting with you guessing the computer's random code.
#Should also have working Ai where human player can set code. 
#sequence is 4 "pegs" chosen from 6 possible colors.
#we can represent this by having a 4 character string consisting of numbers 0-5.

#The Ai works by first creating an array of all possible solutions.
#then removing those that do not have the same "score" as our randomly generated guess.
#score consists of colors correct + position correct.
#Those solutions that don't have the same score when compared to our guess are removed 
#since we know that the score is a commutative value.
#Solution found at http://www.delphiforfun.org/programs/Download/Mastermind%20Algorithm.doc.

	def initialize()
		@turns = 0
		@human_is_guessing = true
		@colors_correct = 0
		@placed_correct = 0
		@numbers_available = []
		0.upto(5) {|x| @numbers_available << x}
		@secret_code = "0000"
		@guess = ""
		@solutions = @numbers_available.repeated_permutation(4).to_a
		@score = 0
	end
	

	def generate_secret_code()
		code = ""
		numbers_available = []
		numbers_available = @numbers_available.to_a
		while code.length < 4
			code = code + numbers_available[rand(numbers_available.length)].to_s
		end
		code
	end
	
	def set_secret_code(code)
		@secret_code = code
	end
	
	def set_guess(guess)
		@guess = guess
	end
	
	#compares the users guess to the given secret_code
	#returns score for ai use.
	def compare_guess(guess, code = @secret_code)
		code_array = code.chars
		guess_chars = guess.to_s.chars
		pos = 0
		#position and color correct.
		guess_chars.each_with_index do |x,i|
			if x === code_array[i]
				pos += 1
			end
		end
		#color correct- includes those that had position correct as well.
		guess_chars.each do |x|
			if code_array.include? x
				code_array.delete_at(code_array.index(x))
			end
		end
		count = 4 - code_array.length
		@colors_correct = count
		@placed_correct = pos
		#only used for ai's internal scoring.
		return count + pos
	end
	
	#simulate one turn of guessing.
	def turn()
	guess = ""
	if @human_is_guessing == true
		puts "Enter your guess for the secret code"
		guess = gets.chomp
		while guess.length != 4 || (guess =~ /[^0-5]/)
			puts " Please enter guess again. Remember it must be 4 numbers and only consist of values 0-5."
			guess = gets.chomp
		end
	else #computer is guessing
		#random guess from array of viable solutions.
		guess = @solutions.delete_at(rand(@solutions.length)).join.to_s
			puts " I guess " + guess
		end
		set_guess(guess)
		@score = compare_guess(guess)
		puts "You have correctly guessed " + @colors_correct.to_s + " out of 4 digits in the code" + " and have " + @placed_correct.to_s + " in the right place."
		@solutions.delete_if {|x| compare_guess(x.join.to_s, @guess) != @score }
		@turns += 1
	end
	
	def game
		puts "Welcome to Mastermind!"
		puts "Enter c if you want to guess the secret code, or s if you want the computer to solve for a code you enter."
		response = gets.chomp
		while response.downcase != "s" && response.downcase != "c"
			puts "Enter c if you want to guess the secret code, or s if you want the computer to solve for a code you enter."
			response = gets.chomp
		end
		@human_is_guessing = false if response.downcase == "s" 
		if @human_is_guessing == true
			set_secret_code(generate_secret_code)
			while @turns < 12 && @secret_code != @guess
				turn
				puts "you have " + (12 - @turns).to_s + " guesses remaining." unless @guess == @secret_code
			end
			if @turns == 12
				puts "Sorry, you did not guess the code in time. The secret code was " + @secret_code.to_s
			else
				puts "Congratulations you have correctly guessed the secret code!"
			end
		elsif @human_is_guessing == false
			puts "Please enter a secret code"
			secret_code = gets.chomp
			while secret_code.length != 4 || (secret_code =~ /[^0-5]/)
				puts " Please enter code again. Remember it must be 4 numbers and only consist of values 0-5."
				secret_code = gets.chomp
			end
			set_secret_code(secret_code)
			puts " Now the computer will try and guess."
			while @turns < 12 && @secret_code != @guess
				turn
				guess = @guess.to_s
			end
			if @turns == 12
				puts " Congratulations, you have stumped me!" + @secret_code.to_s
			else
				puts " I win!"
			end
		end
			puts "play again?(Y/N)"
			ans = gets.chomp
			if ans.downcase == "y" || ans.downcase == "yes"
				initialize
				self.game
			end
		end
	
	
	a = Mastermind.new
	a.game
	
	
end