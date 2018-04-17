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
    guesses = 0
    drawing = ""
    #if score.nil? then score = "" end

    if @game.check_input(guess)
      score = @game.check_guess(guess)
      score = "<strong>#{score}</strong>"
      guesses = @game.guesses
      puts drawing
    else
      message = "Input invalid!"
    end
    drawing = @game.draw
    erb :guess, :locals => {:message => message,
                            :guesses => guesses,
                            :score => score,
                            :drawing => drawing
                            }
  end
end

post '/reset' do
  session.clear
  redirect '/'
end