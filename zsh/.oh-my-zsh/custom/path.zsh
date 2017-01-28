#######################################
## Path
##
## Sebastian Ruml, <sebastian@sebastianruml.name>
## Last Edit: Mi 25. Jan 23:18:54 CET 2017
#######################################

# Bin dir
PATH=$HOME/bin:$PATH

# additional apps dir
PATH=$HOME/Apps:$PATH

# Scala
PATH=$SCALA_HOME/bin:$PATH

# Dotfiles
PATH=$HOME/.dotfiles/bin:$PATH

# Anaconda
PATH=$HOME/anaconda/bin:$PATH

# Activator
PATH=$HOME/bin/activator/:$PATH

# Gradle
PATH=$HOME/bin/gradle-2.4/bin:$PATH

# Pipsi
PATH=$HOME/.local/venvs/pipsi/bin:$PATH

# Python3 executables
PATH=$HOME/.local/bin:$PATH

# pyenv
PATH=$HOME/.pyenv/bin:$PATH

# Add path to our custom bins
export PATH=/usr/local/bin:$PATH

# Go
[ -d "/usr/local/go/bin" ] && PATH=/usr/local/go/bin:$PATH 
[ -d "${PROJECTS/go/bin}" ] && PATH=${PROJECTS}/go/bin:$PATH 

export PATH

# Python Path
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH

# Scala Home
SCALA_HOME=$HOME/bin/scala-2.11.7
