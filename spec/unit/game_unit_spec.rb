describe Game do

  let (:game) { Game.new }
  let (:game_with_puzzle) { Game.new(1) }

  context 'Initialization' do

    it 'can be done with the default difficulty level' do
      expect{ game }.not_to raise_error
    end

    it 'can be doen with a very easy pusszle' do
      expect{ Game.new(1) }.not_to raise_error
    end

    it 'can be doen with a very hard pusszle' do
      expect{ Game.new(5) }.not_to raise_error
    end

    it 'can only be done with a single difficulty level' do
      expect{ Game.new(1, 2) }.to raise_error(ArgumentError)
    end

    it 'can only be done with a premitted difficulty level' do
      arg_err_msg = 'Argument must be Fixnum between 1-5'
      invalid_args = [ 0, 6, '1', :a, [1], {'a' => 1} ]
      invalid_args.each do |arg|
        expect{ Game.new(arg) }.to raise_error(ArgumentError, arg_err_msg)
      end
    end

    it 'is done with a puzzle by default' do
      expect(game.puzzle.class).to eq Puzzle
    end

    it 'is done with an empty puzzle by defualt' do
      expect(game.current_state).to eq ('0' * 81)
    end
  end

  context 'After Initialization' do

    context 'Puzzle' do

      context 'Current State' do

        it "knoes the current state of it's puzzle" do
          expect(game.current_state).to eq ('0' * 81)
        end
      end

      context 'Upload' do

        it 'can upload a new puzzle string' do
          current_puzzle = game_with_puzzle.current_state
          game_with_puzzle.upload_puzzle(EASY_PUZZLE)
          expect(game_with_puzzle.current_state).not_to eq current_puzzle
          expect(game_with_puzzle.puzzle.current_state.class).to eq String
          expect(game_with_puzzle.puzzle.current_state.chars.count).to eq 81
        end
      end

      context 'Solution' do

        it "knows if it's puzzle is not solved" do
          expect(game_with_puzzle.puzzle_solved?).to eq false
        end

        it "knows if it's puzzle is solved" do
          game_with_puzzle.puzzle.solve
          expect(game_with_puzzle.puzzle_solved?).to eq true
        end

        it "knows the solution to it's current puzzle" do
          game_clone = game_with_puzzle.clone
          game_clone.puzzle.solve
          expected_solution = game_clone.current_state
          expect(game_with_puzzle.solution_str).to eq expected_solution
        end
      end
    end
  end
end
