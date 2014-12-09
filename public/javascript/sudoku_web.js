"use strict";

(function() {

  $.ajaxSetup ({
    cache: false
  });

  var original_square_value;

  $(document).on('click','input[type=text]', function() {
    original_square_value = $(this).val();
    this.select();
  }).on('blur','input[type=text]', function() {
    if (!(($(this).val() >= 1) && ($(this).val() <= 9))) {
      $(this).val(original_square_value);
    }
  });

  var slider = document.querySelector('#slider');
  slider.init = new Powerange(slider, {
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
    var difficultyLevel = slider.innerHTML = slider.value;
    switch (difficultyLevel) {
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

  $('.controls-pane-button').click(function() {
    var element = $('#controls-title').add('#controls-open-pane-button');
    if ($(this).attr('id') === 'controls-open-pane-button') {
      $('#controls-container').removeClass('controls-container-closed').addClass('controls-container-open');
      $(element).fadeOut(300, function() {
        $('#controls-button-container').fadeIn(300);
      });
    } else {
      $('#controls-button-container').fadeOut(300, function() {
        $('#controls-container').removeClass('controls-container-open').addClass('controls-container-closed');
        $(element).fadeIn(300);
      });
    }
  });

  $('#controls-new-puzzle').click(function() {
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

  $('.reset-show-hide-buttons').click(function() {
    var serverAddress;
    switch ($(this).attr('id')) {
      case 'controls-reset-puzzle': 
        serverAddress = 'reset_puzzle';
        $('#solution-show-button').prop('disabled', false);
        $('#solution-hide-button').prop('disabled', true);
        break;
      case 'solution-show-button': 
        serverAddress = '/show_solution'; 
        $('#solution-show-button').prop('disabled', true);
        $('#solution-hide-button').prop('disabled', false);
        break;
      case 'solution-hide-button': 
        serverAddress = '/hide_solution'; 
        $('#solution-hide-button').prop('disabled', true);
        $('#solution-show-button').prop('disabled', false);
        break;
    }
    sendPuzzleCurrentState(serverAddress);
  });

  $('#controls-check-solution').click(function() {
    var currentState = getPuzzleCurrentState();
    if (currentState !== new Array(82).join('0')) {
      $.each(['#difficulty-level-container', '#controls-close-pane-button'], function(index, element) {
        $(element).fadeOut(200);
      });
      $('#controls-button-container').fadeOut(200, function() {
        $('#check-solution-pane').fadeIn(200);
      });
      $.post('/check_solution',
        {
          puzzle_current_state: currentState
          }, function(data) {
            $('#check-solution-pane-text').html(data);
        },'text'
      );
    }
  });

  $('#check-solution-pane-close').click(function() {
    $('#check-solution-pane').fadeOut(200, function() {
      $('#controls-close-pane-button').add('#controls-button-container').add('#difficulty-level-container').fadeIn(200);
    });
  });

  function getPuzzleCurrentState() {
    var currentStateData = '';
    for (var index = 0; index < 81; index++) {
      (($('#'+index).val()) === '') ? currentStateData += '0' : currentStateData += $('#'+index).val();
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
