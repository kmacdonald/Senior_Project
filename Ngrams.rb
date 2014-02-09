def words_to_array(filename, arr)
	corpus = File.new(filename, "r")
	while(line = corpus.gets)
		line.split.each do |word|
			arr << word
		end
	end
end

def unigram(sentence, arr)
	while !sentence.include?(".") && !sentence.include?("?") && !sentence.include?("!")
		sentence << arr[rand(arr.length - 1)] + " "
	end
	puts sentence
end

def bigram(sentence, word, arr)
	while !sentence.include?(".") && !sentence.include?("?") && !sentence.include?("!")
		sentence << word + " "
		next_words = []
		for i in 0..(arr.length - 2)
			if(arr[i] == word)
				next_words << arr[i+1]
			end
		end
		bigram(sentence, next_words.shuffle[0], arr)
	end
end

def trigram(sentence, word1, word2, arr)
	while !sentence.include?(".") && !sentence.include?("?") && !sentence.include?("!")
		sentence << word1 + " "
		next_words = []
		for i in 0..(arr.length - 2)
			if(arr[i] == word1 and arr[i+1] == word2)
				next_words << arr[i+2]
			end
		end
		trigram(sentence, word2, next_words.shuffle[0], arr)
	end
end

def n_gram(num)
	sentence = ""
	arr = []
	words_to_array("kjBibleNoVrs.txt", arr)
	if(num == 1)
		unigram(sentence, arr)
	elsif(num == 2)
		bigram(sentence, arr.shuffle[0], arr)
	elsif(num == 3)
		word_ind = rand(arr.length-1)
		trigram(sentence, arr[word_ind], arr[word_ind + 1], arr)
	else
		puts "error"
	end
	puts sentence
end

puts n_gram(3)
