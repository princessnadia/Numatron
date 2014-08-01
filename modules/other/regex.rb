# Allows regex commands to be used in commands
# Made by vifino
def regex_cmd(args="",nick="",chan="",rawargs="",pipeargs="")
	if not pipeargs.empty? and not rawargs.empty? then
		if match=rawargs.match(/s\/(.*)\/(.*)\/g/)then
			data=pipeargs.gsub(/#{match[1]}/,"#{match[2]}")
		elsif match=rawargs.match(/s\/(.*)\/(.*)\//) or match=rawargs.match(/s\/(.*)\/(.*)/) then
			data=pipeargs.sub(/#{match[1]}/,"#{match[2]}")
		end
		return data
	end
end
$commands["regex"] = :regex_cmd