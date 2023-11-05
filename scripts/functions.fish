#!/usr/bin/env fish

function info
    echo [(set_color --bold) ' .. ' (set_color normal)] $argv
end

function user
    echo [(set_color --bold) ' ?? ' (set_color normal)] $argv
end

function success
    echo [(set_color --bold green) ' OK ' (set_color normal)] $argv
end

function abort
    echo [(set_color --bold yellow) ABRT (set_color normal)] $argv
    exit 1
end