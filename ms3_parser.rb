#!/usr/local/bin/ruby -w
require 'ms2_scanner.rb'
# Program: Parser for Milestone 3 in CS480
# This program will define the parser and include the lexical analyzer as a sub-routine.
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
when 'T_WHILE'
return true
when 'T_IF'
return true
else
return false
end
end

def F()
if($p_stream[$p_index].id == 'L_PAR') 
puts 'in F @index ' + $p_index
puts $p_stream[$p_index]


T()
F()
elsif($p_stream[$p_index].id == '$')
return 'Parse complete. .'
end
end
#-------------------------------
def T()
if($p_stream[$p_index].id == 'T_LPAR')
	S()
	if($p_stream[$p_index].id == 'R_PAR')
	$p_index+=1
	else
	return puts "ERROR"
	end
else
return puts "ERROR"
end
end
#-------------------------------
def S()
if($p_stream[$p_index].id == 'T_LPAR')
    	$p_index+=1
	S1()
elsif(isAtom($p_stream[$p_index].id) == true)
    S2()   
else
return puts "ERROR" 
end
end
#-------------------------------
def S1()
if($p_stream[$p_index].id == 'T_LPAR')
    S()
    if($p_stream[$p_index].id == 'T_RPAR')
	$p_index+=1
	return
    else
    return puts "ERROR"
    end
elsif($p_stream[$p_index].id == 'T_RPAR')
    $p_index+=1
    S2()
    return
elsif(isAtom($p_stream[$p_index].id) == true)
    S() 
    if($p_stream[$p_index].id == 'T_RPAR')
	index+=1
    else
    return puts "ERROR"
    end  
else
return puts "ERROR"
end
end
#------------------------------
def S2()
if($p_stream[$p_index].id == 'T_LPAR')
    S()
elsif($p_stream[$p_index].id == 'T_RPAR')
return
elsif(isAtom($p_stream[$p_index].id) == true)
    S2() 
elsif($p_stream[$p_index].id == '$')
return
else
return "ERROR"
end
end

def parser(s_file)
t_stream = lexer(s_file.to_s)
eof = Tokens.new('T_EOF','$')
t_stream << eof
$p_stream = t_stream

$p_stream.each { |i| puts i.id }
$p_index = 0
F()
end

parser(ARGV[0].to_s)


