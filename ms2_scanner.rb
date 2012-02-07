#!/usr/local/bin/ruby -w

class Tokens
	def initialize(id,value)
	@id = id
	@value = value
	end
	def to_s
	puts "["+@value + " " +@id+"]"
	
	end
end


def tokenize(new_t)

new_t.gsub!(/\d+\.\d+/,'T_FDIG')
if new_t == 'T_FDIG'
return new_t
end
new_t.sub!(/\bfloat\b/,'T_FLOAT')
if new_t == 'T_FLOAT'
return new_t
end
new_t.sub!(/\b\d+\b/,'T_IDIG')
if new_t == 'T_IDIG'
return new_t
end
new_t.sub!(/\bif\b/,'T_IF')
if new_t == 'T_IF'
return new_t
end
new_t.sub!(/\bwhile\b/,'T_WHL')
if new_t == 'T_WHL'
return new_t
end
new_t.sub!('<','T_LT')
if new_t == 'T_LT'
return new_t
end
new_t.sub!('>','T_GT')
if new_t == 'T_GT'
return new_t
end
new_t.sub!('<=','T_LTEQ')
if new_t == 'T_LTEQ'
return new_t
end
new_t.sub!('>=','T_GTEQ')
if new_t == 'T_GTEQ'
return new_t
end
new_t.sub!('==','T_EQ')
if new_t == 'T_EQ'
return new_t
end
new_t.sub!('=','T_ASS')
if new_t == 'T_ASS'
return new_t
end
new_t.sub!('!=','T_NEQ')
if new_t == 'T_NEQ'
return new_t
end
new_t.sub!('&&','T_AND')
if new_t == 'T_AND'
return new_t
end
new_t.sub!('||','T_OR')
if new_t == 'T_OR'
return new_t
end
new_t.sub!('(','T_LPAR')
if new_t == 'T_LPAR'
return new_t
end
new_t.sub!(')','T_RPAR')
if new_t == 'T_RPAR'
return new_t
end
new_t.sub!('+','T_ADD')
if new_t == 'T_ADD'
return new_t
end
new_t.sub!('-','T_SUB')
if new_t == 'T_SUB'
return new_t
end
new_t.sub!('*','T_MUL')
if new_t == 'T_MUL'
return new_t
end
new_t.sub!('/','T_DIV')
if new_t == 'T_DIV'
return new_t
end
new_t.sub!('%','T_MOD')
if new_t == 'T_MOD'
return new_t
end
new_t.sub!(/\bsin\b/,'T_TRIG')
if new_t == 'T_TRIG'
return new_t
end
new_t.sub!(/\bcos\b/,'T_TRIG')
if new_t == 'T_TRIG'
return new_t
end
new_t.sub!(/\btan\b/,'T_TRIG')
if new_t == 'T_TRIG'
return new_t
end
new_t.sub!(/\bTRUE\b/,'T_BOOL')
if new_t == 'T_BOOL'
return new_t
end
new_t.sub!(/\bFALSE\b/,'T_BOOL')
if new_t == 'T_BOOL'
return new_t
end
new_t.sub!(/\bint\b/,'T_INT')
if new_t == 'T_INT'
return new_t
end
new_t.sub!(/\b[a-zA-Z]\w*\b/,'T_ID')
if new_t == 'T_ID'
return new_t
end
return nil
end
def lexer(s_file)
	text = File.open(s_file.to_s, "r").read
	puts text.split
	output = ((text.split(/(>=|<=|==|[\+\-\/\*%\(\)=]|!=)/).join(' ')).split(/\s+/))
	puts output
	output.each { |i| tokenize(i) }
	
end
txt_out = lexer(ARGV[0].to_s)
puts txt_out
