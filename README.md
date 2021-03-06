# Stuart Olivera's Dotfiles

My `~/.dotfiles`. Initially based off of [Ryan McGeary's dotfiles](https://github.com/rmm5t/dotfiles).

# Getting Started

Clone this (or a forked version of this) repository.

    $ cd ~
    $ git clone https://github.com/sman591/dotfiles.git .dotfiles

**(Option 1)** If you'd like to symlink everything from this repository to your
home directory, run `install.rb`. This will also sync and update all the git
submodules within.

    $ cd ~/.dotfiles
    $ ./install.rb
    $ ./install-system.sh

Then, restart your terminal session.

    $ cd ~/.dotfiles
    $ ./install-system-finish.sh


This install script is idempotent, meaning you can run it over and over again
without fear of breaking anything. Use it as an installer or to upgrade after
merging from an upstream fork.

**(Option 2)** Just look around and pick and choose what you like for your own
  dotfiles.

# System Dependencies

```
brew install cmake
brew install node
brew install postgres
brew install rbenv ruby-build
```

## Notes

If you'd like to use git and github, be sure to add your own `~/.gitconfig_local` file:

```
[user]
  email = email@example.com
  name = Your Name
[github]
  user = your-github-username
```

## Requirements

* *nix environment (e.g. Mac OS X or Linux)
* Bash version >= 3 (for command line enhancements)
* Ruby (for the install.rb to work)
