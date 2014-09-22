require_relative 'puzzle_generator'

require 'sinatra'

set :views, Proc.new {File.join(root, '..', "views")}
set :public_dir, Proc.new {File.join(root, '..', "public")}

enable :sessions

set :session_secret, ENV['SUDOKU_SECRET']

set :logging, false

get '/' do
	session[:current_puzzle]
	session[:current_solution]
	session[:current_state]
	session[:message] = ''
	erb :index
end

post '/new_puzzle' do
	grid = Grid.new PuzzleGenerator.generate_puzzle params[:radio].to_i
   	session[:current_puzzle] = grid.current_state
   	grid.solve
   	session[:current_solution] = grid.current_state
   	session[:current_state] = session[:current_puzzle]
end

post '/reset_puzzle' do
	if params[:mode] != '0' * 81
		session[:current_puzzle]
	else
		session[:current_puzzle] = ''
	end
end

post '/show_solution' do
	if params[:mode] != '0' * 81
		session[:current_state] = params[:mode]
		session[:current_solution]
	else
		session[:current_solution] = ''
	end
end

post '/hide_solution' do
	if params[:mode] != '0' * 81
		session[:current_state]
	end
end

post '/check_solution' do
	if params[:mode] != '0' * 81
		grid = Grid.new params[:mode]
		grid.fully_solved? && Grid.check_solution(grid.current_state) ? "Well done, puzzle solved!" : "Puzzle not solved yet"
	end
end

