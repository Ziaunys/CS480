#!/usr/local/bin/ruby -w

class Tokens
	def new(id,value)
	end
end


def tokenize(new_t)
ibtl_tokens = {
'if'	=> 'T_IF',
'while' => 'T_WHILE',
'<'	=> 'T_LT',
'>'	=> 'T_GT',
'<='	=> 'T_LTEQ',
'>='	=> 'T_GTEQ',
'='	=> 'T_ASS',
'=='	=> 'T_EQ',
'!='	=> 'T_NEQ',
'('	=> 'T_LPAR',
')'	=> 'T_RPAR',
'+'	=> '+',
'/'	=> '/',
'-'	=> '-',
'*'	=> '*',
'%'	=> 'T_MOD',
'sin'	=> 'T_TRIG',
'cos'	=> 'T_TRIG',
'tan'	=> 'T_TRIG',
/(TRUE|FALSE)/	=> 'T_BOOL',
'int'	=> 'T_INT',
'float'	=>	'T_FLOAT',
/\d*/	=> 'T_DIGIT',
/\d*\.\d*/ => 'T_FDIGIT',
/\w+/	=> 'T_ID'
}
result = ibtl_tokens[new_t]
return result
end

def lexer(s_file)
	
	text = File.open(s_file.to_s, "r").read
	output = text.split(/([+\-\/*%\(\)=])/).join(' ')
	tokens = output.map
end
#" "+/(\/|+|-|*|/+" "
#(+ 1 2)
#for i in lexemes.length
#case
txt_out = lexer(ARGV[0].to_s)
puts txt_out
