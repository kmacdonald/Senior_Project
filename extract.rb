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
		words = line.split
		if(words[0] == "{" and words[1] == "[")
			remove_punctuation words[2]
			arr << words[2]
		elsif(words[0] == "{")
			remove_punctuation words[1]
			arr << words[1]
		else
		end
	end
end

def words_to_file(filename, arr)
	sorted_arr = arr.uniq.sort
	File.open(filename, "w") do |file|
		sorted_arr.each do |word|
			file.puts word.downcase
		end
	end
end

arr = []
words_to_array("dict/dbfiles/verb.body", arr)
words_to_array("dict/dbfiles/verb.change", arr)
words_to_array("dict/dbfiles/verb.cognition", arr)
words_to_array("dict/dbfiles/verb.communication", arr)
words_to_array("dict/dbfiles/verb.competition", arr)
words_to_array("dict/dbfiles/verb.consumption", arr)
words_to_array("dict/dbfiles/verb.contact", arr)
words_to_array("dict/dbfiles/verb.creation", arr)
words_to_array("dict/dbfiles/verb.emotion", arr)
words_to_array("dict/dbfiles/verb.motion", arr)
words_to_array("dict/dbfiles/verb.perception", arr)
words_to_array("dict/dbfiles/verb.possession", arr)
words_to_array("dict/dbfiles/verb.social", arr)
words_to_array("dict/dbfiles/verb.stative", arr)
words_to_array("dict/dbfiles/verb.weather", arr)
puts arr
words_to_file("verbs.txt", arr)
