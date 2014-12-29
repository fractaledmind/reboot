# dots

.......................................
.                                     .
.         :            :              .
.         :            :              .
.         :            :    ......    .
.    ......  ......  .....  :         .
.    :    :  :    :    :    ......    .
.    :    :  :    :    :         :    .
.    ......  ......    :    ......    .
.                                     .
.......................................


WIP bootstrapping library for osx

This is my personal fork of [Matthew Mueller's base repo](https://github.com/MatthewMueller/dots).

## Installation

One-liner:

```
(mkdir -p /tmp/dots && cd /tmp/dots && curl -L https://github.com/smargh/dots/archive/master.tar.gz | tar zx --strip 1 && sh ./install.sh)
```

## Design

The goal of dots is to automate the process of getting your operating system from a stock build to a fully functional machine. 

Dots should be the first thing you download and run to get your computer set up.

This library tries to be organized like a node application, while working within the constraints of bash.

### Mac OS X

The OSX build does the following:

- install homebrew
- installs binaries (graphicsmagick, python, sshfs, ack, git, etc.)
- sets OSX defaults
- installs applications via `homebrew-cask` (one-password, sublime-text, virtualbox, nv-alt, iterm2, etc.)
- sets up the ~/.bash_profile


# Credits

* Original project by [Matthew Mueller](https://github.com/MatthewMueller/)

# License

MIT
