#!/usr/local/bin/ruby -w

class Tokens
	def initialize(id,value)
	@id = id
	@value = value
	end
end


def tokenize(new_t)
new_t.to_s
new_t.sub!(/\d+/, 'T_DIGIT')
new_t.sub!(/\d+\.\d+/, 'T_FDIGIT')
new_t.sub!(/\w+/,'T_ID')
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
}
token = ibtl_tokens[new_t]
if token != nil
return token
else
return new_t
end
end
def lexer(s_file)
	text = File.open(s_file.to_s, "r").read
	output = (text.split(/([+\-\/*%\(\)=])/).join(' ')).split(/\s+/)
	output.length.times do |i|
	output[i] = tokenize(output[i])
	end
	return output
end
#" "+/(\/|+|-|*|/+" "
#(+ 1 2)
#for i in lexemes.length
#case
txt_out = lexer(ARGV[0].to_s)
puts txt_out
