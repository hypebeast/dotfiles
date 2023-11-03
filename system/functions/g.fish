function g -d "behaves like git or git status if nor arg is given"
	switch $argv[1]
	case ''
		git status
	case '*'
		git $argv[1]
	end
end