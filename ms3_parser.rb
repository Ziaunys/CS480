#!/usr/local/bin/ruby -w
require 'ms2_scanner.rb'
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
when 'T_LT'
return true
when 'T_OR'
return true
when 'T_AND'
return true
when 'T_NOT'
return true
when 'T_NEG'
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
when 'T_FDIG'
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


def F()
#puts 'before compare in F'
#puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR') 
#puts 'in F'
#puts $p_stream[$p_index]
T()
F()
return
elsif($p_stream[$p_index].id == 'T_EOF')
return true
else
return false
end
end
def T()
#puts 'in T'
#puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
	$p_index+=1
	S()
	if($p_stream[$p_index].id == 'T_RPAR')
	$p_index+=1
	#puts 'returning to F'
	return
	else
        puts "ERROR"
	Process.exit
	end
else
#puts "ERROR"
Process.exit
end
end
def S()
#puts 'in S'
#puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
    	$p_index+=1
	S1()
elsif(isAtom($p_stream[$p_index].id) == true)
    #ADD TO STACK HERE. CALL TYPE FUNCTION    
 #   puts $p_stream[$p_index].value
    $p_index+=1
    S2()  
   #puts 'aha!' 
   return
else
#puts 'or here?'
puts "ERROR" 
Process.exit
end
end
def S1()
#puts 'in S1'
#puts $p_stream[$p_index]
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
    #puts 'in here'
    return
elsif(isAtom($p_stream[$p_index].id) == true)   
        puts $p_stream[$p_index].value    
	S() 
    if($p_stream[$p_index].id == 'T_RPAR')
	$p_index+=1
	S2()
	return
    else
    puts "ERROR"
    Process.exit
    end  
else 
puts "ERROR"
Process.exit
end
end
def S2()
#puts 'in S2'
#puts $p_stream[$p_index]
if($p_stream[$p_index].id == 'T_LPAR')
    S()
    return
elsif($p_stream[$p_index].id == 'T_RPAR')
    return 
elsif(isAtom($p_stream[$p_index].id) == true)
#	puts $p_stream[$p_index].value
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

def parse_tree()
   $p_stream.each { |i| $f_flag = 1 if i.id == 'T_FDIG' } 
   $p_stream.length.times do |i|
       if($p_stream[i].id == 'T_EOF')
           return 
       end
       if(isBinOp($p_stream[i].id) == true)
          puts 'is bin op'
	   case $p_stream[i].id
	   when 'T_MOD'
 	       if $f_flag == 1
	           $p_stream[i].value = "fmod"
	           else
	           $p_stream[i].value = "mod"
	       end
	   else
	   if $f_flag == 1
	       $p_stream[i].value = "f" + $p_stream[i].value 
	   end
	   end
	$operator_stack << $p_stream[i].value
	puts $operator_stack.last
	puts ' ^ last '
       elsif( $p_stream[i].id != 'T_LPAR' && $p_stream[i].id != 'T_RPAR')
	#    puts $p_stream[i].value + "hi"
	       case $p_stream[i].id
	       when 'T_FDIG'
	           $p_stream[i].value.gsub(/\..*/,"e")
	       when 'T_IDIG'
	           if $f_flag == 1     
		       $p_stream[i].value = $p_stream[i].value + "e"
		   end
	       when 'T_STR'
	            $p_stream[i].value = "s"+ $p_stream[i].value.sub(/"/,"\"\s")
	            $s_flag += 1
	       else
		   puts $p_stream[i].value + " in here"
	       end
	   $out_expr << $p_stream[i].value
           while($operator_stack.empty? == false && $operator_stack.last == 'done')
               $operator_stack.pop
	       puts 'in here'
		if $s_flag > 0
		    $operator_stack[$operator_stack.length-1] = "s+"
                end
	       $out_expr << $operator_stack.pop
           end
               $operator_stack << 'done'
       end
    end
end
def parser(s_file)
    t_stream = lexer(s_file.to_s)
    eof = Tokens.new('T_EOF','$')
    t_stream << eof
    $p_stream = t_stream
    $p_stream.delete_at(0)
    $p_stream.each { |i| puts i.id} 
    $p_index = 0
    $operand_stack = []
    $operator_stack = []
    $out_expr = []
    errors = F()
    if errors == false
        puts 'ERROR'
	Process.exit
    end
    $f_flag = 0
    $s_flag = 0
    puts "code generation: "
    parse_tree()
    puts "output: "
    $out_expr << "." 
    puts $out_expr.compact
    out_file = File.new("out.fs", "w")
end

parser(ARGV[0].to_s)


