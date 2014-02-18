def single_hook?(sentence, clause)
	arr1 = sentence.split(" ")
	arr2 = clause.split(" ")
	return (arr1.last == arr2.first)
end

def double_hook?(sentence, clause)
	arr1 = sentence.split(" ")
	arr2 = sentence.split(" ")
	arr2.delete_at(arr2.length - 1)
	arr3 = clause.split(" ")
	return (arr1.last == arr3[1] and arr2.last == arr3[0])
end

def pos_trigram(sentence, arr)
	while(!sentence.include?("."))
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

clauses = ["noun verb noun", "verb noun adjective", "adjective adverb verb", "nound adverb verb", "article noun verb", "adverb verb ."]
puts pos_trigram("noun verb noun", clauses)
