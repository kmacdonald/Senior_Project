require "./Unigrams.rb"

def bigrams_to_file(infile, outfile, arr)
	words = []
	words_to_array(infile, words)
	bigrams = []
	words.uniq.each do |word|
		bigrams << [[word, words.count(word)]]
		puts bigrams.length.to_s + " array added"
	end
	
	for i in 0..(bigrams.length - 2)
		next_words = []
		for j in 0..(words.length - 1)
			if(words[j] == bigrams[i][0][0])
				next_words << words[j+1]
			end
		end
		next_words.uniq.each do |word|
			bigrams[i] << [word, next_words.count(word)]
			puts i.to_s + " bigram done"
		end
	end

	File.open(outfile, "w") do |file|
		bigrams.each do |word_array|
			word_array.each do |word|
				file.puts word[0] + " " + word[1].to_s
			end
			file.puts "break"
		end
	end
end

bigram_array = []
bigrams_to_file("kjBibleNoVrs.txt", "bigrams.txt", bigram_array)