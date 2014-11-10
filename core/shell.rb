# Execute shell commands
# Made by vifino
def sh(args="")
	if not args.to_s.empty? then
		#rnd= ('a'..'z').to_a.shuffle[0,8].join
		#tmpfile="/tmp/shout_#{rnd}"
		#`#{args} 2>&1 > #{tmpfile}`
		#o=File.read tmpfile
		#`rm #{tmpfile}`
		#return o
		return `#{args.to_s} 2>&1`
	end
end
def shcmd(args="",nick="",chan="",rawargs="",pipeargs=nil)
	if isPrivileged? nick then
		if pipeargs==nil then
			return sh(args)
		else
			rnd= ('a'..'z').to_a.shuffle[0,8].join
			tmpfile="/tmp/#{rnd}"
			`touch /tmp/sh_#{rnd}`
			f=File.open "/tmp/sh_#{rnd}","w"
			f.write pipeargs.to_s
			f.close
			o=sh("cat /tmp/sh_#{rnd}|#{rawargs.to_s}")
			`rm /tmp/sh_#{rnd}`
			return o
		end
	else
		return "Uh, no?"
	end
end
addCommand("sh",:shcmd,"Execute shell commands, Admin only!")
