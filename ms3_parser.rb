#!/usr/local/bin/ruby -w
require 'ms2_scanner.rb'
# Program: Parser for Milestone 3 in CS480
# This program will define the parser and include the lexical analyzer as a sub-routine.

def expect()


end

def isBinOp(token)
case token
when 'T_ADD'
return true
when 'T_SUB'
return true
when 'T_MUL'
return true
when 'T_DIV'
return true
when 'T_MOD'
return true
when 'T_POW'
return true
when 'T_EQ'
return true
when 'T_GT'
return true
when 'T_LT'
return true
when 'T_ASS'
return true
else
return false
end
end

def isAtom(token)
case token
when 'T_ID'
return true
when 'T_IDIG'
return true
when 'T_DIG'
return true
when 'T_BOOL'
return true
when 'T_ADD'
return true
when 'T_SUB'
return true
when 'T_DIV'
return true
when 'T_MOD'
return true
when 'T_POW'
return true
else
return false
end
end

def F()
if(p_stream[p_index].id == 'L_PAR') 
T()
F()
elsif(p_stream[p_index].id == '$')
return 'Parse complete. .'
end
end
#-------------------------------
def T()
case p_stream[p_index].id
when 'T_LPAR'
	S()
	if(p_stream[p_index+1] == 'R_PAR')
	p_index++
	else
	return puts "ERROR"
	end
else
return puts "ERROR"
end
end
#-------------------------------
def S()
if(p_stream[p_index] == 'T_LPAR')
    	p_index++
	S1()
elsif(isAtom(p_stream[index].id == true)
    S2()   
else
return puts "ERROR" 
end
end
#-------------------------------
def S1()
if(p_stream[p_index] == 'T_LPAR')
    S()
    if(p_stream[p_index] == 'T_RPAR')
	p_index++
	return
    else
    return puts "ERROR"
    end
elsif(p_stream[p_index] == 'T_RPAR')
    p_index++
    S2()
    return
elsif(isAtom(p_stream[p_index].id == true)
    S() 
    if(p_stream[p_index] == 'T_RPAR')
	index++
    else
    return puts "ERROR"
    end  
else
return puts "ERROR"
end
end
#------------------------------
def S2()
if(p_stream[p_index] == 'T_LPAR')
    S()
elsif(p_stream[p_index] == 'T_RPAR')
return
elsif(isAtom(p_stream[p_index].id == true)
    S2() 
elsif(p_stream[p_index] == '$')
return
else
return "ERROR"
end


def parser(s_file)
t_stream = lexer(s_file.to_s)
t_stream << '$'
$p_stream = t_stream
$index = 0
F(p_stream,index)
end
end
#t_stream.each { |i| puts i.id }
#parser(ARGV[0].to_s)


