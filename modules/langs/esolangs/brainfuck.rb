# Brainfuck interpreter, ported to ruby
# Made by vifino
require 'timeout'
def bf(insts,input="") # This one works! (TM)
	str="o='';a=Array.new(256,0);p=0;"
	insts.gsub(/./){|inst|
		#str = str+"if a[p]>=256 then;a[p]=0; end;if a[p]<0 then; a[p]=255; end;"
		case inst
			when "+"
				str+="if a[p]<=256 then; a[p]+=1;else;a[p]=0;end;"
			when "-"
				#str+="if a[p]<=0 then;a[p]-=1;end;"
				str+="if a[p]<0 then; a[p]=255;else; a[p]-=1;end;"
			when ">"
				str+="p+=1;a[p]=a[p]||0;"
			when "<"
				str+="p-=1;a[p]=a[p]||0;"
			when "."
				str+="o+=a[p].chr;"
			when "["
				str+="while a[p]>0 do;"
				#str+="w=p;while true do;if a[w]==0 then; break; end;"
			when "]"
				str+="end;"
			when ","
				str+="if c=input[0] then;a[p]=c.ord;else;a[p]=0;end;input=input[1..-1];"
		end
	}
	str+="return o;"
	#puts str
	begin
		eval str
	rescue => e
		puts e
		return "Error."
	end
end
def bfOld(insts="",input="") # not working correctly.
	#if insts=nil then return "Can't execute nothing!" end
	if not insts.empty? then
		code = "o='';p=0;w=p;a=[];"
		insts.strip.split("").each {|inst|
			code +="if p<=0 then p=0; end;if a[p]==nil then a[p]=0; end;if a[p]==-1 then a[p]=0; end;"
			if inst==">" then
				code += "p+=1;"
			elsif inst=="<" then
				code += "p-=1;"
			elsif inst=="+" then
				code += "a[p]=(a[p] or 0)+1;"
			elsif inst=="-" then
				code += "a[p]=(a[p] or 1)-1;"
			elsif inst=="." then
				code += "o+=(a[p] or 0).chr;"
			elsif inst=="["
				#code += "w=p;while a[w]!=0 do;p=0;"
				code += "while (a[p] or 0)!=0 do;"
				#code += "w=p;while true do;if a[w]==0 then; break; end;"
			elsif inst=="]" then
				code += "end;"
			elsif inst==";" then
				code+="p a;puts p;"
			end
		}
		code +="if p<=0 then p=0; end;if a[p]==nil then a[p]=0; end;if a[p]==-1 then a[p]=0; end;"
		code +="return o;"
		begin
			out=eval(code)
			return out
		rescue => e
			puts e
			return "Error"
		end
	end
end
def bf_cmd(args="",nick="",chan="",rawargs="",pipeargs="")
		begin
  		Timeout::timeout(2) do
    		ret=bf(args.to_s,pipeargs)
				return (ret or "").delete("\r\n")
			end
		 if ret.class == String
		else
			"Error: Took too long."
		end
	rescue SyntaxError => e
		puts e.to_s
  	return "Error: Took too long."
	end
end
addCommand("bf",:bf_cmd,"Run Brainfuck code.")
addCommand("brf",:bf_cmd,"Run Brainfuck code.")
addCommand("brainfuck",:bf_cmd,"Run Brainfuck code.")
def bfopt(code) # Should be useful someday.
	optimised = ""
	optimised = code.gsub(/[^\+\-<>\[\]\.,]/i, '')
	# tbd
	return optimised.strip
end
def blf2brf(code="",nick="",chan="",rawargs="",pipeargs="") # Boolfuck to brainfuck, doesnt work
	code=code.to_s
	code=code.gsub('>>>>>>>>>+<<<<<<<<+[>+]<[<]>>>>>>>>>[+<<<<<<<<[>]+<[+<]','[')
	code=code.gsub('>>>>>>>>>+<<<<<<<<+[>+]<[<]>>>>>>>>>]<[+<]',']') # [ and ]
	code=code.gsub('>[>]+<[+<]>>>>>>>>>[+]<<<<<<<<<','+')
	code=code.gsub('>>>>>>>>>+<<<<<<<<+[>+]<[<]>>>>>>>>>[+]<<<<<<<<<','-') # + and -
	code=code.gsub('>,>,>,>,>,>,>,>,<<<<<<<<',',')
	code=code.gsub('>;>;>;>;>;>;>;>;<<<<<<<<','.') # Input and output
	code=code.gsub('<<<<<<<<<','>')
	code=code.gsub('>>>>>>>>>','<') # > and <
	return code
end
def brf2blf(code="",nick="",chan="",rawargs="",pipeargs="") # Brainfuck to Boolfuck. 101% useful
	str=""
	code.to_s.split("").each {|c|
		str+=case c
			when "+"
				'>[>]+<[+<]>>>>>>>>>[+]<<<<<<<<<'
			when "-"
				'>>>>>>>>>+<<<<<<<<+[>+]<[<]>>>>>>>>>[+]<<<<<<<<<'
			when "<"
				'<<<<<<<<<'
			when ">"
				'>>>>>>>>>'
			when ","
				'>,>,>,>,>,>,>,>,<<<<<<<<'
			when "."
				'>;>;>;>;>;>;>;>;<<<<<<<<'
			when "["
				'>>>>>>>>>+<<<<<<<<+[>+]<[<]>>>>>>>>>[+<<<<<<<<[>]+<[+<]'
			when "]"
				'>>>>>>>>>+<<<<<<<<+[>+]<[<]>>>>>>>>>]<[+<]'
		end
	}
	return str
end
addCommand("brf2blf",:brf2blf)
addCommand("brainfuck2boolfuck",:brf2blf)
addCommand("blf2brf",:blf2brf)
addCommand("boolfuck2brainfuck",:blf2brf)
def blf_cmd(args="",nick="",chan="",rawargs="",pipeargs="")# Would not use.
	begin
		Timeout::timeout(2) do
			return bf(blf2brf(args.to_s)).delete("\r\n")
		end
	rescue => e
		puts e
		return "Error: Took too long."
	end
end
addCommand("blf",:blf_cmd)
addCommand("boolfuck",:blf_cmd)
def bfenc(str="")
	if !str.empty? then
		enc = ""
		str.to_s.split("").each{|c|

		}
		return enc
	end
end
