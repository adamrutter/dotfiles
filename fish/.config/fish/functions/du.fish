function du
	command du --max-depth=1 --human-readable --all $argv | sort -h
end
