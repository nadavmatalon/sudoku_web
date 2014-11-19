require './lib/grid.rb'
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
  grid = Grid.new
  grid.upload_new_puzzle params[:difficulty_level].to_i
  session[:current_puzzle] = grid.puzzle_to_str
  grid.solve_puzzle
  session[:puzzle_solution] = grid.puzzle_to_str
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
    grid = Grid.new
    grid.upload params[:puzzle_current_state]
    grid.puzzle_solved? ? 'Well done, puzzle solved!' : 'Puzzle not solved yet'
  end
end

def puzzle_empty?
  params[:puzzle_current_state] == '0' * 81
end
