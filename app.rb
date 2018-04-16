require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/hangman.rb'

enable :sessions

get '/' do

	unless session["game"]
    	session["game"] = Hangman.new
	end

	erb :index
end

post '/guess' do
  @game = session["game"]

  if @game.game_over?
    session.clear
    redirect "/"
  else
    guess = params[:guess]
    message = ""
    guesses = ""
    score = "" unless !score.nil?

    if @game.check_input(guess)
      score = @game.check_guess(guess)
      score = "<strong>#{score}</strong>"
      guesses = @game.guesses
    else
      message = "Input invalid!"
    end
    erb :guess, :locals => {:message => message,
                            :guesses => guesses,
                            :score => score
                            }
  end
end

post '/reset' do
  session.clear
  redirect '/'
end