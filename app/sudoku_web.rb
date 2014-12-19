require './lib/game.rb'
require 'sinatra'

set :views, proc { File.join(root, '..', 'views') }
set :public_dir, proc { File.join(root, '..', 'public') }

enable :sessions

set :session_secret, ENV['SUDOKU_SECRET']

set :logging, false

get '/' do
  erb :index
end

post '/new_puzzle' do
  game = Game.new(params[:difficulty_level].to_i)
  session[:current_puzzle] = game.current_state
  session[:puzzle_solution] = game.solution_str
  session[:current_puzzle_state] = session[:current_puzzle]
end

post '/reset_puzzle' do
  puzzle_empty? ? session[:current_puzzle] = '' : session[:current_puzzle]
end

post '/show_solution' do
  session[:current_puzzle_state] = params[:puzzle_current_state]
  puzzle_empty? ? '' : session[:puzzle_solution]
end

post '/hide_solution' do
  puzzle_empty? ? '' : session[:current_puzzle_state]
end

post '/check_solution' do
  unless puzzle_empty?
    game_clone = Game.new
    game_clone.upload_puzzle(params[:puzzle_current_state])
    game_clone.puzzle_solved? ? solved_msg : unsolved_msg
  end
end

private

def puzzle_empty?
  params[:puzzle_current_state] == '0' * 81
end

def solved_msg
  'Well done, puzzle solved!'
end

def unsolved_msg
  'Puzzle not solved yet'
end
