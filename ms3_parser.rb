#!/usr/local/bin/ruby -w
require 'ms2_scanner.rb'
# Program: Parser for Milestone 3 in CS480
# This program will define the parser and include the lexical analyzer as a sub-routine.

class PARSE_TREE
#Contains object methods for a standard binary tree.
    class Node
    attr_reader :val, :left_child, :right_child
    #Defines the node object for PARSE_TREE
        def initialize(val, left_child = nil, right_child = nil)
	    @val = val
	    @left_child, @right_child = left_child, right_child
	end
	def insert(val)
	    @left_child.nil? ? @left_child = Node.new(val): @right_child.nil? ? @righ_child = Node.new(val): @left_child.insert(val)
        end

	
    end

    def traverse(root)
	puts root.val
	root.left_child.nil? ? traverse(root.right_child): traverse(root.left_child)
    end
end
	
def expr(t_stream,index,p_tree)
case t_stream[index]
when 'T_LPAR'
if(statem(t_stream,index+1,p_tree) == 'T_RPAR')
return 'T_RPAR'
else 
return puts "ERROR"
end
when 'T_RPAR'
return "ERROR" 
when '$'
return 'done'
end
end

def statem(t_stream,index,p_tree)
case t_stream[index]
when 'T_RPAR'
return 'T_RPAR'
when 'T_LPAR'
if(expr(t_stream, index, p_tree) == 'T_RPAR')
return 'T_RPAR'
end
when 'T_ADD'
p_tree.insert('T_ADD')
statem(t_stream,index+1,p_tree)
statem(t_stream,index+2,p_tree)
when 'T_SUB'
p_tree.insert('T_SUB')
statem(t_stream,index+1,p_tree)
statem(t_stream,index+2,p_tree)
when 'T_MUL'
p_tree.insert('T_MUL')
statem(t_stream,index+1,p_tree)
statem(t_stream,index+2,p_tree)
when 'T_DIV'
p_tree.insert('T_DIV')
statem(t_stream,index+1,p_tree)
statem(t_stream,index+2,p_tree)
when 'T_MOD'
p_tree.insert('T_ADD')
statem(t_stream,index+1,p_tree)
statem(t_stream,index+2,p_tree)
when 'T_POW'
p_tree.insert('T_POW')
statem(t_stream,index+1,p_tree)
statem(t_stream,index+2,p_tree)
when 'T_EQ'
p_tree.insert('T_EQ')
statem(t_stream,index+1,p_tree)
statem(t_stream,index+2,p_tree)
when 'T_GT'
p_tree.insert('T_GT')
statem(t_stream,index+1,p_tree)
statem(t_stream,index+2,p_tree)
when 'T_LT'
p_tree.insert('T_LT')
statem(t_stream,index+1,p_tree)
statem(t_stream,index+2,p_tree)
when 'T_ID'
p_tree.insert('T_ID')
return 'T_ID'
when 'T_IDIG'
p_tree.insert('T_IDIG')
when 'T_DIG'
p_tree.insert('TDIG')
when 'T_ASS'
p_tree.insert('T_ASS')
statem(t_stream,index+1,p_tree)
statem(t_stream,index+2,p_tree)

end
end

def parser(s_file)
t_stream = lexer(s_file.to_s)
if(t_stream[0] == 'T_LPAR')
p_tree = PARSE_TREE::Node.new('T_LPAR')
expr(t_stream,0,p_tree)
p_tree.traverse()
end
end
#t_stream.each { |i| puts i.id }
parser(ARGV[0].to_s)

