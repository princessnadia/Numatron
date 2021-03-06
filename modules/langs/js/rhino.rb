# Add an js interpreter
# Made by vifino
if @jruby then
	require 'rhino' # No comment.
	Rhino::Context.open({:sealed=>true,:restrictable=>true}) do |jsvm|
		jsvm.timeout_limit = 1
		jsvm["print"] = lambda {|this, word| @jsout << word.to_s + " "; return word.to_s}
		jsvm["log"] = lambda {|this, word| @jsout << word.to_s + " "; return word.to_s}
		jsvm["write"] = lambda {|this, word| @jsout << word.to_s; return word.to_s}
		jsvm["Math"]["random"] = lambda {|this| return rand}
		@jsvm=jsvm
	end
	@jsout = ""
	def js(args="",nick="",chan="",rawargs="",pipeargs="") # Considered safe? I hope so.
		@jsout = ""
		begin
			returnval = @jsvm.eval(args.to_s)
			if returnval!=nil then
				if returnval.class == "Array" then
					return "[object Object]"
				end
				if @jsout.empty? then
					return returnval.inspect
				else
					txt = ""
					if returnval then
						txt = "\n> "+returnval.inspect
					end
					return @jsout.strip+txt
				end
			end
		rescue => detail
			return detail.message
		end
	end
	addCommand("js",:js,"Execute javascript code!")
end
