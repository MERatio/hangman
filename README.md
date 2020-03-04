# Hangman

A simple command line Hangman game where one player plays against the computer, more information on [Wikipedia](<https://en.wikipedia.org/wiki/Hangman_(game)>).

## Installation

```bash
git clone git@github.com:MERatio/hangman.git
```

## Usage

```bash
ruby lib/hangman.rb

          Type new to play a new game
          Type load to load a previous save
Your choice: new
                 New game started
        Type save to save the current game
                  Lives left: 10
Correct letters:   ***********
Incorrect letters:
Enter a letter:    a

                  Lives left: 9
Correct letters:   ***********
Incorrect letters: a
Enter a letter:    e

                  Lives left: 9
Correct letters:   ***e*******
Incorrect letters: a
Enter a letter:    i

                  Lives left: 9
Correct letters:   ***e**i****
Incorrect letters: a
Enter a letter:
```
