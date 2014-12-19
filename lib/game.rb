require_relative 'puzzle'

class Game

  attr_reader :puzzle

  def initialize(level = nil)
    @puzzle = Puzzle.new
    puzzle.generate_puzzle(level) if level
  end

  def upload_puzzle(puzzle_str)
    @puzzle.upload(puzzle_str)
  end

  def current_state
    puzzle.current_state
  end

  def solution_str
    puzzle.solution_str
  end

  def puzzle_solved?
    puzzle.solved?
  end
end
