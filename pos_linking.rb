require "./pos.rb"
require "./grammar_tests.rb"

#checks if the clause matches with the last word of the sentence
#def single_hook?(sentence, clause)
#	arr1 = sentence.split(" ")
#	arr2 = clause.split(" ")
#	return (arr1.last == arr2.first)
#end

#checks if the clause matches with the last two words of the sentence
def hook?(sentence, clause)
	arr1 = sentence.split(" ")
	arr2 = sentence.split(" ")
	arr2.delete_at(arr2.length - 1)
	arr3 = clause.split(" ")
	return (arr1.last == arr3[1] and arr2.last == arr3[0])
end

def random_start(clauses)
	possible_starts = []
	clauses.each do |clause|
		if(clause.split(" ").first == "start")
			possible_starts << clause
		end
	end
	start = possible_starts.shuffle[0]
	return start
end

#takes in a sentence (that presumably starts with three parts of speech)
#links hooks on another cause from "arr" until ending puncuation is added
def pos_sentence(sentence, arr)
	puts sentence
	while(!pre_tests?(sentence) and sentence.split(" ").length > 2)
		next_clauses = []
		arr.each do |pos|
			if(hook?(sentence, pos))
				next_clauses << pos
			end
		end
		next_pos = next_clauses.shuffle[0]
		if(!pre_tests?(sentence))
			if(hook?(sentence, next_pos))
				sentence << " " + next_pos.split(" ")[2]
			else
				puts "error in pos_sentence"
			end
			pos_sentence(sentence, arr)
		end
	end
	return sentence
end

clauses = []
corpus = File.new("structures.txt", "r")
while(line = corpus.gets)
	clauses << line.chomp
end

start = random_start(clauses).split(" ").drop(1).join(" ")
puts start
pos = pos_sentence(start, clauses)
puts pos.inspect

#sentence = pos_to_word(pos)
#sentence = post_tests(sentence)
#puts sentence

sentence = sentence_about("computer science", pos)
sentence = post_tests(sentence)
puts sentence
