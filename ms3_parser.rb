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
if($p_stream[$p_index].id == 'T_LPAR') 
puts 'in F'
puts $p_stream[$p_index]
T()
F()
elsif($p_stream[$p_index].id == '$')
return 'Parse complete. .'
else
return puts "ERROR"
end
end
#-------------------------------
def T()
puts 'in T'
puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
	S()
	if($p_stream[$p_index].id == 'R_PAR')
	$p_index+=1
	else
        puts "ERROR"
	Process.exit
	end
else
puts "ERROR"
Process.exit
end
end
#-------------------------------
def S()
puts 'in S'
puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
    	$p_index+=1
	S1()
elsif(isAtom($p_stream[$p_index].id) == true)
    $p_index+=1
    S2()   
else
puts "ERROR" 
Process.exit
end
end
#-------------------------------
def S1()
puts 'in S1'
puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
    S()
    if($p_stream[$p_index].id == 'T_RPAR')
	$p_index+=1
	return
    else
    puts "ERROR"
    Process.exit
    end
elsif($p_stream[$p_index].id == 'T_RPAR')
    $p_index+=1
    S2()
    return
elsif(isAtom($p_stream[$p_index].id) == true)
    S() 
    if($p_stream[$p_index].id == 'T_RPAR')
	$p_index+=1
    else
    puts "ERROR"
    Process.exit
    end  
else 
puts "ERROR"
Process.exit
end
end
#------------------------------
def S2()
puts 'in S2'
puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
    S()
    return
elsif($p_stream[$p_index].id == 'T_RPAR')
    return
elsif(isAtom($p_stream[$p_index].id) == true)
    S()
    return 
elsif($p_stream[$p_index].id == '$')
    return
else
pus "ERROR"
Process.exit
end
end

def parser(s_file)
t_stream = lexer(s_file.to_s)
eof = Tokens.new('T_EOF','$')
t_stream << eof
$p_stream = t_stream
$p_stream.each { |i| puts i.id }
$p_index = 1
F()
puts $p_index
end

parser(ARGV[0].to_s)


