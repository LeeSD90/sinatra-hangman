class Hangman

	def initialize

	end

	private

	def get_random_word()
		dictionary = File.readlines("5desk.txt")
		word = ""

		until(word.length > 5 && word.length < 12)
			random_line = rand(0..dictionary.size)
			word = dictionary[random_line]
		end
		return word
	end

	def check_input(input)
		return input == "1" || (is_letter(input) && !@chosen_letters.include?(input))
	end

	def is_letter(l)
		return l =~ /^[a-zA-Z]{1}$/
	end

	def instructions()
		puts "\n"
	    puts "|***** Hangman! *****|".colorize(:green)
	    puts "\nA random English word has been chosen from a dictionary. You have eight incorrect guesses before you fail!\n\n"
	end

end
