###
# Path definitions
###

# Scala Home
SCALA_HOME=$HOME/bin/scala-2.11.7

# Bin dir
PATH=$HOME/bin:$PATH

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

# Go
[ -d "/usr/local/go/bin" ] && PATH=/usr/local/go/bin:$PATH 
[ -d "${PROJECTS/go/bin}" ] && PATH=${PROJECTS}/go/bin:$PATH 

export PATH

# Python Path
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
