#Need this in order to tell what part of speech each word is.
require "./pos.rb"

#I think these are pretty self-explanatory.
#The pre_tests all have to be true for the sentence to be completed.
#The post_tests are run on the completed sentences. They fix any issues and then return true.

def is_complete?(sentence)
	if(sentence.include?(".") or sentence.include?("?") or sentence.include?("!"))
		return true
	else
		return false
	end
end

def contains_verb?(sentence)
	if((sentence.split(" ") == sentence.split(" ") - @verb) and (sentence.split(" ") == sentence.split(" ") - @transitive_verb) and (sentence.split(" ") == sentence.split(" ") - @intransitive_verb))
		return false
	else
		return true
	end
end

def correct_parentheses?(sentence)
	if(sentence.include?(")") and !sentence.include?("("))
		sentence.gsub!(")", "")
	end
	return true
end

def no_incomplete_parentheses?(sentence)
	if(sentence.include?("(") and !sentence.include?(")"))
		return false
	else
		return true
	end
end

def proper_capitalization?(sentence)
	sentence.capitalize!
	arr = sentence.split(" ")
	for i in 1..(arr.length-1)
		if(!@proper_noun.include?(arr[i]))
			arr[i].downcase!
		end
	end
	temp_sentence = ""
	arr.each do |word|
		temp_sentence << word + " "
	end
	sentence = temp_sentence
	return true
end

def no_dangling_clauses?(sentence)
	while(sentence.last != "." and sentence.last != "?" and sentence.last != "!")
		sentence.chop!
	end
	return true
end

def pre_tests?(sentence)
	if(!is_complete?(sentence))
		puts "sentence incomplete"
	end
	if(!contains_verb?(sentence))
		puts "sentence doesn't contain verb"
	end
	if(!correct_parentheses?(sentence))
		puts "sentence has incorrect parentheses"
	end
	return (is_complete?(sentence) and contains_verb?(sentence) and correct_parentheses?(sentence))
end

def post_tests?(sentence)
	no_incomplete_parentheses?(sentence) and proper_capitalization?(sentence)
end
