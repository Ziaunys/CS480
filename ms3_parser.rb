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
when 'T_ID'
return true
when 'T_IDIG'
return true
when 'T_DIG'
return true
when 'T_ASS'
return true
else
return false
end

end

def F(t_stream,index)
T(t_stream,index)
expect('$')
end

def T(t_stream,index)
case t_stream[index].id
when 'T_LPAR'
S(t_stream,index+1)
expect('T_RPAR')
else
return "ERROR"
end
end
def S(t_stream,index)

case t_stream[index]
when 'T_LPAR'
    case t_stream[index+1].id
    when 'T_LPAR'


if(isBinOp(t_stream[index].id)

end

def parser(s_file)
t_stream = lexer(s_file.to_s)
t_stream << '$'
if(t_stream[0] == 'T_LPAR')
end
end
#t_stream.each { |i| puts i.id }
#parser(ARGV[0].to_s)


