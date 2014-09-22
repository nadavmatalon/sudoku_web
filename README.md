#Sudoku: Web Version

## Table of Contents

* [Screenshot](#screenshot)
* [General Description](#general-description)
* [Functional Description](#functional-description)
* [See it Live on Heroku](#see-it-live-on-heroku)
* [Browsers](#browsers)
* [Testing](#testing)
* [License](#license)


##Screenshot

<div width="400px" >
	<a href="https://raw.githubusercontent.com/nadavmatalon/sudoku_web/master/public/images/sudoku-screenshot.png">
		<img src="/public/images/sudoku-screenshot.png" width="400" height="420px" />
	</a>
</div>


##General Description

The app consists of the game of __Sudoku__ written in 
[Ruby](https://www.ruby-lang.org/en/) &amp; 
[JavaScript](http://en.wikipedia.org/wiki/JavaScript) 
according to [TDD](http://en.wikipedia.org/wiki/Test-driven_development) 
(testing with [Rspec](http://rspec.info/)).

Here's a brief description of the game:

>__Sudoku__ is a logic-based combinatorial number-placement puzzle. 
>
>The puzzle setter provides a partially completed grid, which may have a unique 
>solution or several possible solutions.
>
>The aim of the game is to fill a grid made of 9x9 `squares` (81 in total) 
>with digits so that each `column`, each `row`, and each `box`* contains 
>all of the digits from 1 to 9. 
>
> \* The grid contians 9 so-called 'boxes', that is 3x3 sub-grids within the general grid.

(Source: [Wikipedia on Sudoku](http://en.wikipedia.org/wiki/Sudoku))


##Functional Description

* The app contains a built-in `Puzzle Generator` that can generate random 
  puzzles at 5 different levels of difficulty, ranging from 
  __Very Easy__ to __Very Hard__.

* To start the game, click on the `Down Arrow` to open up the Control Pannel, 
  select the level of difficulty you like and click on `New Puzzle`.

* At this point, you can close the Control Panel and start filling-in the blank 
  spaces on the grid with numbers according to the rules of the game
  (the app will only let you fill the empty squares with numbers from 1 to 9).

* If you get stuck, you can toggle between the `Show Solution` &amp; 
  `Hide Solution` views in the Control Panel (the app will remeber your current 
  grid settings and will not delete any of the numbers you've added up to that 
  point).

* Alternatively, you can use the `Reset Puzzle` button to re-load the original 
  puzzle and start again.

* When you're done filling-in the all the numbers, click on the `Check Solution` 
  button to find out if your solution is correct.


##See it Live on Heroku

A live version of the game can be found (and played!) at:

[Sudoku on Heroku](http://makers-sudoku-web.herokuapp.com/)

As I'm using Heroku's free hosting service, the app may take a bit of time to upload<br/>
(Heroku's giros take time to wake up...), so please be patient.


##Browsers

This app has been tested with and supports the following browsers (though
it should hopefully look decent in other browsers as well):

* __Google Chrome__ (36.0)
* __Apple Safari__ (7.0.5)
* __Mozilla Firefox__ (31.0)


##Testing

Tests were written with [Rspec](http://rspec.info/) (3.0.4).

To run the testing suite in terminal: 

```bash
$> cd sudoku_web
$> rspec
```


##License

<p>Released under the <a href="http://www.opensource.org/licenses/MIT">MIT license</a>.</p>

