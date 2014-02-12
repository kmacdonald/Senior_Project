def remove_punctuation(word, punct)
	for i in 0..(punct.length - 1)
		word.gsub!(punct[i], "")
	end
end

def words_to_array(filename, arr, punct)
	corpus = File.new(filename, "r")
	while(line = corpus.gets)
		line.split.each do |word|
			punctuation = ""
			punct.each do |char|
				if(word.include?(char))
					punctuation = char
				end
			end
			remove_punctuation(word, punct)
			arr << word
			if(!punctuation.empty?)
				arr << punctuation
			end
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

def trigram(sentence, word1, word2, arr, punct)
	while !sentence.include?(".") && !sentence.include?("?") && !sentence.include?("!")
		if(!punct.include?(word1))
			sentence << word1 + " "
		elsif(punct.include?(word1) and !sentence.empty?)
			sentence.chop!
			sentence << word1 + " "
		else
		end
		next_words = []
		for i in 0..(arr.length - 2)
			if(arr[i] == word1 and arr[i+1] == word2)
				next_words << arr[i+2]
			end
		end
		trigram(sentence, word2, next_words.shuffle[0], arr, punct)
	end
end

def n_gram(num)
	sentence = ""
	arr = []
	punctuation = [";", "!", ",", ":", ".", "(", ")", "?"]
	words_to_array("kjBibleNoVrs.txt", arr, punctuation)
	if(num == 1)
		unigram(sentence, arr)
	elsif(num == 2)
		bigram(sentence, arr.shuffle[0], arr)
	elsif(num == 3)
		word_ind = rand(arr.length-1)
		trigram(sentence, arr[word_ind], arr[word_ind + 1], arr, punctuation)
	else
		puts "error"
	end
	puts sentence
end

puts n_gram(3)
