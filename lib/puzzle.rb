require_relative 'puzzle_generator'

class Puzzle

  include PuzzleGenerator

  attr_reader :puzzle_arr

  def initialize(puzzle_str = '0' * 81)  
    valid?(puzzle_str) ? upload(puzzle_str) : fail(ArgumentError, str_err_msg)
  end

  def upload(puzzle_str)
    @puzzle_arr = puzzle_str.chars.map(&:to_i)
  end

  def rows
    puzzle_arr.each_slice(9).to_a
  end

  def columns
    rows.transpose
  end

  def peers_of(index)
    peers = [rows[index/9], columns[index%9], boxes[box_of(index)]]
    peers.flatten.uniq.reject { |value| value == (0 || value_of(index)) }
  end

  def boxes(values = rows)
    (0..2).inject([]) do |boxes, index|
      boxes + values.slice(3 * index, 3).transpose.each_slice(3).map(&:flatten)
    end
  end

  def box_of(index)
    boxes(indexed).map { |boxes| boxes & [index] }.index([index])
  end

  def indexed
    puzzle_arr.map.with_index { |_, index| index }.each_slice(9).to_a
  end

  def current_state
    puzzle_arr.join
  end

  def valid?(puzzle_str)
    (/^\d{81}$/) === puzzle_str ? true : false
  end

  def str_err_msg
    'Argument must be String of 81 digits'
  end
end
