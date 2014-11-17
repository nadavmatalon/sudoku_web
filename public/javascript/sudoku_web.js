(function() {

	$.ajaxSetup ({
		cache: false
	});

	var original_square_value;

	$(document).on('click','input[type=text]', function() {
		original_square_value = $(this).val();
		this.select();
	}).on('blur','input[type=text]', function() {
		if (!(($(this).val() > 0) && ($(this).val() < 10))) {
			$(this).val(original_square_value);
		}
	});

	var slider = document.querySelector('#slider');
	var init = new Powerange(slider, {
		callback      : function() {},
		min           : 1,
		max           : 5,
		decimal       : true,
		disable       : false,
		disableOpacity: 0.5,
		hideRange     : true,
		klass         : 'slider',
		start         : 1,
		step          : 1,
		vertical      : false
	});

	slider.onchange = function() {
		var difficultyLevel;
		slider.innerHTML = slider.value;
		switch (slider.value) {
			case '1': difficultyLevel = 'Very Easy'; break;
			case '2': difficultyLevel = 'Easy'; break;
			case '3': difficultyLevel = 'Medium'; break;
			case '4': difficultyLevel = 'Hard'; break;
			case '5': difficultyLevel = 'Very Hard'; break;
		}
		$('#difficulty-level-display').fadeOut(150, function() {
			$(this).text(difficultyLevel).fadeIn(150);
		});
	};

	$('#solution-buttons-container').buttonset();
	$('#controls-button-container').hide();

	$('#controls-open-pane-button').on('click', function() {
		$('#controls-container').removeClass('controls-container-closed').addClass('controls-container-open');
		$.each(['#controls-title', '#controls-open-pane-button'], function(index, element) {
			$(element).fadeOut(300, function() {
				$('#controls-button-container').fadeIn(300);
			});
		});
	});

	$('#controls-close-pane-button').on('click', function() {
		$('#controls-button-container').fadeOut(300, function() {
			$.each(['#controls-title', '#controls-open-pane-button'], function(index, element) {
				$('#controls-container').removeClass('controls-container-open').addClass('controls-container-closed');
				$(element).fadeIn(300);
			});
		});
	});

	$('#controls-new-puzzle').on('click', function() {
		$('#solution-hide-button').attr('disabled', true);
		$('#solution-show-button').attr('disabled', false);
			$('#loader-container').fadeIn(50, function() {
			$.post('/new_puzzle', 
				{
				difficulty_level: document.querySelector('#slider').value
				}, function(data) {
					mapPuzzle(data);
				},'text').success(function() {
					$('#loader-container').fadeOut(100);
			});
		});
	});

	$('#solution-show-button').on('click', function() {
		$('#solution-show-button').attr('disabled', true);
		$('#solution-hide-button').attr('disabled', false);
		sendPuzzleCurrentState('/show_solution');
	});

	$('#solution-hide-button').on('click', function() {
		$('#solution-show-button').attr('disabled', false);
		$('#solution-hide-button').attr('disabled', true);
		sendPuzzleCurrentState('/hide_solution');
	});

	$('#controls-reset-puzzle').on('click', function() {
		$('#solution-hide-button').attr('disabled', true);
		$('#solution-show-button').attr('disabled', false);
		sendPuzzleCurrentState('/reset_puzzle');
	});

	$('#controls-check-solution').on('click', function() {
		if (getPuzzleCurrentState() !== Array(11).join('0')) {
			$.each(['#difficulty-level-container', '#controls-close-pane-button'], function(index, element) {
				$(element).fadeOut(200);
			});
			$('#controls-button-container').fadeOut(200, function() {
				$('#check-solution-pane').fadeIn(200);
				$('#mask').removeClass('hide').addClass('show');	
			});
			$.post('/check_solution',
				{
					puzzle_current_state: getPuzzleCurrentState()
					}, function(data) {
						$('#check-solution-pane-text').html(data);
				},'text'
			);
		}
	});

	$('#check-solution-pane-close').on('click', function() { 
		$('#check-solution-pane').fadeOut(200, function() {
			$.each(['#controls-close-pane-button', '#controls-button-container', '#difficulty-level-container'], function(index, element) {
				$(element).fadeIn(200);
			});
		});
	});

	function getPuzzleCurrentState() {
		var currentStateData = '';
		for (var index = 0; index < 81; index++) {
			if (($('#'+index).val()) !== '') {
				currentStateData = (currentStateData + ($('#'+index).val()));
			} else {
				currentStateData = (currentStateData + '0');
			}
		}
		return currentStateData;
	}

	function sendPuzzleCurrentState(serverMethod) {
		$.post(serverMethod,
			{
				puzzle_current_state: getPuzzleCurrentState()
			}, function (data) {
				mapPuzzle(data);
			},'text'
		);
	}

	function mapPuzzle(data) {
		for (var index = 0; index < data.length; index++) {
			if ((data.charAt(index)) !== '0') {
				$('#'+index).val(data.charAt(index));
			} else {
				$('#'+index).val('');
			}
		}
	}

	$(document).ready(function() {
		$('#main-container').css('opacity', '1');
	});

})();
