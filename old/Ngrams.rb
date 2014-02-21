#Need this to make sure sentences are grammatically correct.
require "./grammar_tests.rb"

#Does what it says it does.
def remove_punctuation(word, punct)
	for i in 0..(punct.length - 1)
		word.gsub!(punct[i], "")
	end
end

#Puts all the words in an array in order, and treats punctuation as words.
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

#Not important.
def unigram(sentence, arr)
	while !sentence.include?(".") && !sentence.include?("?") && !sentence.include?("!")
		sentence << arr[rand(arr.length - 1)] + " "
	end
	puts sentence
end

#Not important.
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

#The only important one, does what it says it does.
def trigram(sentence, word1, word2, arr, punct)
	while !pre_tests?(sentence)
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
		if(sentence.include?("(") and !sentence.include?(")") and next_words.include?(")"))
			trigram(sentence, word2, ")", arr, punct)
		else
			trigram(sentence, word2, next_words.shuffle[0], arr, punct)
		end
	end
end

#Takes in a number, produces the appropriate n-gram
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
		post_tests?(sentence)
	else
		puts "error"
	end
	return sentence
end

#I've been writing thme to files so that I can look at them and see what other issues they have.
File.open("abunchofngrams2.txt", "w") do |file|
	for i in 0..10
		file.puts n_gram(3)
	end
end
