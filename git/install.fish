#!/usr/bin/env fish

# Don't ask ssh password all the time
switch (uname)
case Darwin
	git config --global credential.helper osxkeychain
case '*'
	git config --global credential.helper cache
end

if not command -qs delta
	switch (uname)
	case Darwin
		brew install delta
	case '*'
		curl -L -o /tmp/git-delta.deb https://github.com/dandavison/delta/releases/download/0.16.5/git-delta_0.16.5_amd64.deb
    	sudo dpkg -i /tmp/git-delta.deb
    	rm /tmp/git-delta.deb
	end
end

# better diffs
if command -qs delta
	git config --global core.pager delta
	git config --global interactive.diffFilter 'delta --color-only'
	git config --global delta.line-numbers true
	git config --global delta.decorations true
end
