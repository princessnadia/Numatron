# Kudasai ne, senpai?
addCommand("please",->(args="",nick="",chan="",rawargs="",pipeargs="") {
	if isPrivileged? nick then
		req = args.split(' ', 2)
		if req.empty? then
			return "Please do what?"
		end
		act = req[0]
		rst = req[1] || ""
		@bot.action(chan,"#{act}s #{rst.strip}".strip.gsub(/me/i,nick).gsub(/my/,"#{nick}'s").gsub(/your/,"her"))
		return nil
	else
		"No."
	end
}, "You might get what you want if you ask nice.")
#addCommand("hug" ->(args="",nick="",chan="",rawargs="",pipeargs="") {
#
#}, "HUGZ!")
