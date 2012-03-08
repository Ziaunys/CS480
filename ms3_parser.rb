#!/usr/local/bin/ruby -w
require 'ms2_scanner.rb'
require 'ms4_forthgen.rb'
# Program: Parser for Milestone 3 in CS480
# This program will define the parser and include the lexical analyzer as a sub-routine.

#Make UnaryOp() function
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
#when 'T_GT'
#return true
when 'T_LT'
return true
when 'T_ASS'
return true
else
return false
end
end


def isType(token)
case token
when 'T_FLOAT'
return true
when 'T_INT'
return true
#when 'T_REAL'
#return true
when 'T_STRING'
return true
when 'T_BOOL'
return true
else
return false
end
end

#Currentl does not include types. This WILL cause the parser to break until types are handled.
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
when 'T_MUL'
return true
when 'T_DIV'
return true
when 'T_MOD'
return true
when 'T_POW'
return true
when 'T_WHL'
return true
when 'T_IF'
return true
#when 'T_GT'
#return true
when 'T_EQ'
return true
#when 'T_ASS'
#return true
when 'T_STR'
return true
when 'T_STRING'
return true
else
return false
end
end


#Make function which calls all type checking function to reduce redundancy.

def isType(token)

end

def F(s_index)
#puts 'before compare in F'
#puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR') 
#puts 'in F'
#puts $p_stream[$p_index]
T()
F()
return
elsif($p_stream[$p_index].id == 'T_EOF')
return puts 'Exit without errors. .'
else
return #puts "ERROR"
end
end
def T(s_index)
#puts 'in T'
#puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
	$p_index+=1
	S(s_index)
	if($p_stream[$p_index].id == 'T_RPAR')
	$p_index+=1
	#puts 'returning to F'
	return
	else
        #puts "ERROR"
	Process.exit
	end
else
#puts "ERROR"
Process.exit
end
end
def S(s_index)
#puts 'in S'
#puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
    	$p_index+=1
	S1(s_index)
elsif(isAtom($p_stream[$p_index].id) == true)
    #ADD TO STACK HERE. CALL TYPE FUNCTION
    $p_index+=1
    S2(s_index)  
   #puts 'aha!' 
   return
else
#puts 'or here?'
#puts "ERROR" 
Process.exit
end
end
def S1(s_index)
#puts 'in S1'
#puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
    S(s_index)
    if($p_stream[$p_index].id == 'T_RPAR')
	$p_index+=1
	return
    else
    #puts "ERROR"
    Process.exit
    end
elsif($p_stream[$p_index].id == 'T_RPAR')
    $p_index+=1
    S2(s_index)
    #puts 'in here'
    return
elsif(isAtom($p_stream[$p_index].id) == true)
    $s_tree << $p_stream[$p_index]    
    S(s_index) 
    if($p_stream[$p_index].id == 'T_RPAR')
	$p_index+=1
	S2(s_index)
	return
    else
    #puts "ERROR"
    Process.exit
    end  
else 
#puts "ERROR"
Process.exit
end
end
def S2(s_index)
#puts 'in S2'
#puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
    S(s_index)
    return
elsif($p_stream[$p_index].id == 'T_RPAR')
    #puts 'lol?'
    return 
elsif(isAtom($p_stream[$p_index].id) == true)
	S()
    return 
elsif($p_stream[$p_index].id == '$')
    return
else
#puts 'here?'
#puts "ERROR"
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
$operand_stack = []
$operator_stack = []
F()
$s_tree.each { |i| puts i.value }
traverse($s_tree,0)
#puts $p_index
end

parser(ARGV[0].to_s)


