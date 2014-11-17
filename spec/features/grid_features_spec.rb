describe Grid, type: :feature  do

	let (:grid) { Grid.new }

	subject { page }

	before { visit '/' }

	context 'on page upload' do

		it 'should have the title \'Sudoku-Web\'' do
			should have_title 'Sudoku-Web'
		end

		it 'should show the page title \'Sudoku\'' do
			should have_content 'Sudoku'
		end

		it 'should show the controls pane title' do
			should have_content 'Controls'
		end

		it 'should show the controls pane open button' do
			should have_button 'controls-open-pane-button'
		end

		it 'should not show the controls close button' do
			should have_button 'controls-close-pane-button', visible: false
		end

		it 'should not show the game control buttons' do
			control_buttons = %w(new-puzzle reset-puzzle check-solution)
			click_button 'controls-open-pane-button'
			control_buttons.each { |button| should have_button "controls-#{button}", visible: false }
		end

		it 'should not show the solution control buttons' do
			solution_buttons = %w(hide-button show-button)
			solution_buttons.each { |button| should have_selector :xpath, "//input[@id=\"solution-#{button}\"]", count: 1, visible: false }
		end

		it 'should not show the level of difficulty controls' do
			should have_selector :xpath, '//div[@id="difficulty-level-container"]', count: 1, visible: false
		end

		it 'should show the grid' do
			should have_selector :xpath, '//div[@id="grid-outer-container"]', count: 1, visible: true
		end
	end

	context 'controls pane' do
		
		before (:each) { click_button 'controls-open-pane-button' }

		context 'open button' do

			it 'should show the game control buttons' do
				control_buttons = %w(new-puzzle reset-puzzle check-solution)		
				control_buttons.each { |button| should have_button "controls-#{button}" }
			end

			it 'should show the solution control buttons' do
				solution_buttons = %w(hide-button show-button)
				solution_buttons.each { |button| should have_selector :xpath, "//input[@id=\"solution-#{button}\"]", count: 1 }
			end

			it 'should show the level of difficulty controls' do
				should have_selector :xpath, '//div[@id="difficulty-level-container"]', count: 1
			end

		end

		context 'close button' do

			before (:each) { click_button 'controls-close-pane-button' }

			it 'should hide the game control buttons' do
				control_buttons = %w(new-puzzle reset-puzzle check-solution)
				control_buttons.each { |button| should have_button "controls-#{button}", visible: false }
			end

			it 'should hide the solution control buttons' do
				solution_buttons = %w(hide-button show-button)
				solution_buttons.each { |button| should have_selector :xpath, "//input[@id=\"solution-#{button}\"]", count: 1, visible: false }
			end
		
			it 'should hide the level of difficulty controls' do
				should have_selector :xpath, '//div[@id="difficulty-level-container"]', count: 1, visible: false
			end
		end
	end

	context 'grid' do

		it 'should have 81 squares' do
			should have_selector :xpath, '//div[@class="square"]', count: 81
		end
	end
end
