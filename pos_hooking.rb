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

#takes in a sentence (that presumably has three parts of speech)
#links hooks on another cause from "arr" until ending puncuation is added
def pos_trigram(sentence, arr)
	while(!sentence.include?(".") or !sentence.include?("?") or !sentence.include?("!"))
		next_clauses = []
		arr.each do |pos|
			if(single_hook?(sentence, pos) or double_hook?(sentence, pos))
				puts pos
				next_clauses << pos
			end
		end
		next_pos = next_clauses.shuffle[0]
		if(single_hook?(sentence, next_pos))
			sentence << " " + next_pos.split(" ")[1] + " " + next_pos.split(" ")[2]
		elsif(double_hook?(sentence, next_pos))
			sentence << " " + next_pos.split(" ")[2]
		else
			cout << "error"
		end
		pos_trigram(sentence, arr)
	end
	return sentence
end

#testing it out
clauses = ["noun verb noun", "verb noun adjective", "adjective adverb verb", "nound adverb verb", "article noun verb", "adverb verb ."]
puts pos_trigram("noun verb noun", clauses)
