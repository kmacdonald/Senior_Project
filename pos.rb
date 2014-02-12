# regular expression?
def remove_punctuation(word)
	punct = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ";", "!", ",", ":", ".", "(", ")", "?", "[", "]", "{", "}", "_"]
	for i in 0..(punct.length - 2)
		word.gsub!(punct[i], "")
	end
	word.gsub!(punct[punct.length - 1], " ")
end

def words_to_array(filename, arr)
	corpus = File.new(filename, "r")
	while(line = corpus.gets)
		arr << line.chomp
	end
end

def find_unknown(infile, outfile, arr)
	words = []
	corpus = File.new(infile, "r")
	while(line = corpus.gets)
		line.split.each do |word|
			words << word
		end
	end
	File.open(outfile, "w") do |file|
		words.each do |word|
			w = word
			remove_punctuation(w)
			w.downcase!
			if(!arr.include?(word))
				file.puts w
			end
		end
	end
end

words = []
words_to_array("nouns.txt", words)
words_to_array("verbs.txt", words)
words_to_array("adjectives.txt", words)
words_to_array("adverbs.txt", words)
words_to_array("prepositions.txt", words)
words_to_array("conjunctions.txt", words)
find_unknown("corpus.txt", "unknown.txt", words)
