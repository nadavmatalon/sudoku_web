#Sudoku: Web Version

[![Code Climate](https://codeclimate.com/github/nadavmatalon/sudoku_web/badges/gpa.svg)](https://codeclimate.com/github/nadavmatalon/sudoku_web)

## Table of Contents

* [Screenshot](#screenshot)
* [General Description](#general-description)
* [Functional Description](#functional-description)
* [How to Install and Run](#how-to-install-and-run)
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

This app implements the game of __Sudoku__ which was written 
following the course at [Makers Academy](http://www.makersacademy.com/).

* The back-end logic of the app is written in 
[Ruby](https://www.ruby-lang.org/en/) (2.1.1).
* The front-end interface
is written in [JavaScript](http://en.wikipedia.org/wiki/JavaScript) &amp; 
[jQuery](http://jquery.com).
* Code created according to [TDD](http://en.wikipedia.org/wiki/Test-driven_development) 
(testing with [Rspec](http://rspec.info/) &amp; 
[Capybara](https://github.com/jnicklas/capybara)).
* The app uses the [Sinatra](http://www.sinatrarb.com/) framework 
and [Thin Webserver](https://github.com/macournoyer/thin/).

__Update (17.11.14)__ : I've re-written the entire app from scratch 
to generate a more cohesive and cleaner code.


##Functional Description

For those who aren't familiar with the game, here's a brief description:

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

As for playing the game:

* The app contains a single class called 'Grid' that can generate and solve random 
  puzzles at 5 different levels of difficulty, ranging from 
  __Very Easy__ to __Very Hard__.

* Players can upload a new puzzle at a difficulty level of their choice.
  While generating the puzzle, the app will show a small dynamic 'loader' image 
  inside the Controls Panel to indicate that the background operation is currently 
  running.

* After the puzzle has been uploaded, players can fill-in the missing blanks, 
  check the status of their solution, and even 'cheat' a little by switching 
  between the show and hide solution options.

* To start the game, click on the arrow to open the Control Panel, 
  select the level of difficulty you like on the slider and click on `New Puzzle`.

* At this point, you can close the Control Panel and start filling-in the blank 
  spaces on the grid with numbers according to the rules of the game
  (the app will only let you fill the empty squares with numbers from 1 to 9).

* If you get stuck, you can toggle between the `Show Solution` &amp; 
  `Hide Solution` views in the Control Panel (the app will remeber your current 
  grid settings and will not delete any of the numbers you've added up to that 
  point).

* If you want, you can use the `Reset Puzzle` button to re-load the original 
  puzzle and start again.

* When you're done filling-in the all the numbers, click on the `Check Solution` 
  button and find out if your solution is correct.


##How to Install and Run

To install the app, __clone the repo__ to a local folder and then run the 
following commands in terminal:

```
$> cd sudoku_web
$> bundle install
```

Then you'll need to create an __enviromental variable__
in your machine for [Sinatra](http://www.sinatrarb.com/)'s `session secret key`.

The name of this env variable should be: SUDOKU_SECRET, and you 
can give it any value you like.

If you want a random string for this variable's value, you can 
use the following commands in terminal to generate it:

```
$> irb
#> SecureRandom.hex(20)
$> exit
```

Finally, run the local server:

```
$> thin start
```

After running these setup commands, open the browser of your 
choice and go to this address:

```
http://localhost:3000/
```


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

Unit and feature tests for the back-end logic and front-end interface 
were written with [Rspec](http://rspec.info/) (3.1.7) &amp;  
[Capybara](https://github.com/jnicklas/capybara) (2.4.1)).

To run the tests, clone the repo to a local folder and then run:

```bash
$> cd sudoku_web
$> bundle install
$> rspec
```

##License

<p>Released under the <a href="http://www.opensource.org/licenses/MIT">MIT license</a>.</p>

