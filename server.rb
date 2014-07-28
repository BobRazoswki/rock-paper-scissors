require 'sinatra/base'
require './lib/player'
require './lib/game'

class RockPaperScissors < Sinatra::Base

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'change_me'

set :public_folder, Proc.new { File.join(root, "public") }

configure :production do
    require 'newrelic_rpm'
  end
  
GAME = Game.new
  
  get '/' do
    GAME.restart
    erb :index
  end

  get '/new-game' do

  	erb :new_player
  end

  post '/player' do
    session[:player] = Player.new(params[:name])
    GAME.add_(session[:player])
    redirect to '/game'
  end

  post '/play' do
    player = GAME.players.select {|player| player.name == session[:player].name }.first
    player.picks = params[:pick]
    player.picked = true
  	redirect to '/game'
  end


  get '/play' do
    erb :play
  end



  get '/waiting_room' do
      erb :waiting_room
  end

  get '/game' do
    puts GAME.inspect
    player1 = GAME.players.select {|player| player.name == session[:player].name }.first
    player2 = GAME.players.reject {|player| player.name == session[:player].name }.first
    
    redirect to '/waiting_room' if !GAME.enough_players?
    redirect to '/play' if GAME.enough_players? && !player1.has_picked?
    redirect to '/waiting_room' if GAME.waiting_for?(GAME.player1) 
    redirect to '/outcome' if GAME.both_picked?
    
    # redirect to '/outcome' if GAME.both_picked?
    # puts GAME.both_picked?
    # redirect to '/waiting_room' if !GAME.both_picked?
    #redirect to '/waiting_room' if !GAME.enough_players?


  end

  post '/game' do
    "Hello World"
  end

  post '/waiting_room' do
    erb :waiting_room
  end

  get '/outcome' do
    erb :outcome
  end

=begin
  def generate_computer
  	choice = ["Rock","Paper","Scissors"].sample
  	comp = Player.new("computer")
  	comp.picks = choice
  	comp
  end

  redirect to '/play' if GAME.enough_players?
    erb :outcome if GAME.both_played?
    redirect to '/waiting_room'

=end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
