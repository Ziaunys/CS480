#!/usr/local/bin/ruby -w
require 'ms2_scanner.rb'
# Program: Parser for Milestone 3 in CS480
# This program will define the parser and include the lexical analyzer as a sub-routine.

class PARSE_TREE
#Contains object methods for a standard binary tree.
attr_accessor :root
def initialize(root=nil)
    @root = root
end
    class Node
    attr_accessor :val, :left_child, :right_child
    #Defines the node object for PARSE_TREE
        def initialize(val , left_child = nil, right_child = nil)
	    @val = val
	    @left_child, @right_child = left_child, right_child
	end
	def insert_left(val)
            puts 'inserting_left ' + val
	    (@left_child = Node.new(val)) if @left_child.nil?
        end
	def insert_right(val)
	    puts 'inserting_left ' + val
	    (@right_child = Node.new(val)) if @right_child.nil?
	end
	def to_s
	puts @val + ' in to_s'
	end 
     end


	
def add_left(val)
    if(@root.nil?)
	puts 'inserting root' + val
    end
    @root.nil? ?  @root = Node.new(val): @root.insert_left(val) 
end

def add_left(val)
    if(@root.nil?)
	puts 'inserting root' + val
    end
    @root.nil? ?  @root = Node.new(val): @root.insert_right(val) 
end

    

def traverse(node=@root)
node.to_s
node.left_child.nil? ? traverse(node.right_child): traverse(node.left_child)
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
t_stream << '$'
if(t_stream[0] == 'T_LPAR')
p_tree = PARSE_TREE::Node.new('S')
expr(t_stream,0,p_tree)
PARSE_TREE.traverse(p_tree)
end
end
#t_stream.each { |i| puts i.id }
#parser(ARGV[0].to_s)

p_tree = PARSE_TREE.new()
p_tree.add_left('+')
p_tree.add_left('-')
p_tree.add_left('2')
p_tree.add_right('5')
p_tree.add_right('3')
p_tree.traverse(p_tree.root)
