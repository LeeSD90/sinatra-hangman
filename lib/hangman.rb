class Hangman
	attr_accessor :word, :guesses, :chosen_letters

	def initialize
		@word = get_random_word()
		@guesses = 8
		@chosen_letters = Array.new
	end

	def check_guess(guess)
		count = 0
		score = ""
		@chosen_letters << guess.downcase
		@word.chomp.split(//).each { |l|
			next if l == ""
			if @chosen_letters.include?(l.downcase) then count += 1; score = score + l + " "
			else score += "_ "
			end
		}
		@guesses -= 1 unless @word.include?(guess)
		if @word.chomp.split("").length == count then return "You won! The word was " + @word; @guesses = 0 end
		if @guesses == 0 then return "You lost! The word was " + @word end
		return score
	end

	def game_over?
		return @guesses == 0
	end

	def check_input(input)
		return input == "1" || (is_letter(input) && !@chosen_letters.include?(input))
	end

	def draw()
		case @guesses
		when 8
				return %q{
	   ____
	  |    |
	  |    
	  |   
	  |    
	  |   
	 _|_
	|   |______
	|          |
	|__________|
	}
		when 7
			return %q{
	   ____
	  |    |
	  |    o
	  |   
	  |    
	  |   
	 _|_
	|   |______
	|          |
	|__________|
	}
		when 6
			return %q{
	   ____
	  |    |
	  |    o
	  |    |
	  |    
	  |   
	 _|_
	|   |______
	|          |
	|__________|
	}
		when 5
			return %q{
	   ____
	  |    |
	  |    o
	  |    |
	  |    |
	  |   
	 _|_
	|   |______
	|          |
	|__________|
	}
		when 4
			return %q{
	   ____
	  |    |
	  |    o
	  |   /|
	  |    |
	  |   
	 _|_
	|   |______
	|          |
	|__________|
	}
		when 3
			return %q{
	   ____
	  |    |
	  |    o
	  |   /|\
	  |    |
	  |   
	 _|_
	|   |______
	|          |
	|__________|
	}
		when 2
			return %q{
	   ____
	  |    |
	  |    o
	  |   /|\
	  |    |
	  |   /
	 _|_
	|   |______
	|          |
	|__________|
	}
		when 1
	return %q{
	   ____
	  |    |
	  |    o
	  |   /|\
	  |    |
	  |   / \
	 _|_
	|   |______
	|          |
	|__________|
	}
		end
	end

	private

	def get_random_word()
		dictionary = File.readlines("./lib/5desk.txt")
		word = ""

		until(word.length > 5 && word.length < 12)
			random_line = rand(0..dictionary.size)
			word = dictionary[random_line]
		end
		return word
	end
	
	def is_letter(l)
		return l =~ /^[a-zA-Z]{1}$/
	end

end
