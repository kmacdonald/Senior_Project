require "./pos.rb"

#checks if the clause matches with the last word of the sentence
def single_hook?(sentence, clause)
	arr1 = sentence.split(" ")
	arr2 = clause.split(" ")
	return (arr1.last == arr2.first)
end

#checks if the clause matches with the last two words of the sentence
def double_hook?(sentence, clause)
	arr1 = sentence.split(" ")
	arr2 = sentence.split(" ")
	arr2.delete_at(arr2.length - 1)
	arr3 = clause.split(" ")
	return (arr1.last == arr3[1] and arr2.last == arr3[0])
end

#takes in a sentence (that presumably starts with three parts of speech)
#links hooks on another cause from "arr" until ending puncuation is added
def pos_sentence(sentence, arr)
	while(!sentence.include?(".") and !sentence.include?("?") and !sentence.include?("!"))
		next_clauses = []
		arr.each do |pos|
			if(single_hook?(sentence, pos) or double_hook?(sentence, pos))
				next_clauses << pos
			end
		end
		next_pos = next_clauses.shuffle[0]
		if(single_hook?(sentence, next_pos))
			sentence << " " + next_pos.split(" ")[1] + " " + next_pos.split(" ")[2]
		elsif(double_hook?(sentence, next_pos))
			sentence << " " + next_pos.split(" ")[2]
		else
			puts "error"
		end
		pos_sentence(sentence, arr)
	end
	return sentence
end

clauses = []
corpus = File.new("structures.txt", "r")
while(line = corpus.gets)
	clauses << line.chomp
end

pos = pos_sentence("definite_article noun verb", clauses)
puts pos.inspect

sentence = ""
pos.split(" ").each do |p|
	sentence << pos_to_word(p) + " "
end
puts sentence
