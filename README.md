# sein
A minimal CLI productivity tracker, inspired by [that one productivity tip from Seinfeld](https://lifehacker.com/jerry-seinfelds-productivity-secret-281626).
It's unfinished, and barely usable - oh, and it's also my first "proper" ruby project, so don't expect the code to be any good either. I recommend backing up the `~/.sein` file from time to time.

## Installation
after cloning, go into the dir and

    $ rake install

also this requires bundler, i don't remember why. `gem install bundler`

## Usage
    # adds a habit for tracking
    $ sein new habit1

    # marks a habit for today
    $ sein mark habit1
    
    # meant to be used as the shell greeting
    $ sein compact
    *habit1 13	habit2 12
