def words_to_array(filename, arr)
	corpus = File.new(filename, "r")
	while(line = corpus.gets)
		line.split.each do |word|
			arr << word
		end
	end
end

def unigrams_to_file(infile, outfile, arr)
	words = []
	words_to_array(infile, words)
	unigrams = []
	words.uniq.each do |word|
		unigrams << [word, 0]
		puts word
	end
	unigrams.map{|word| word[1] += words.count(word[0])}
	print unigrams[1]

	File.open(outfile, "w") do |file|
		unigrams.each do |word|
			file.puts word[0] + " " + word[1].to_s
		end
	end
end

def unigrams_from_file(filename, arr)
	unigrams = File.new(filename, "r")
	while(line = unigrams.gets)
			arr << line.split
	end
end

def loaded_die(arr)
	temp = []
	count = arr.length - 1
	while(count != 0)
		arr.each do |word|
			
		end
	end	
end

def unigrams(infile, outfile, arr)
	if FileTest.exists?(outfile)
		unigrams_from_file(outfile, arr)
	else
		unigrams_to_file(infile, arr)
	end
end

def random_sentence(arr)
	sentence = ""
	while !sentence.include?(".") && !sentence.include?("?") && !sentence.include?("!")
		sentence << arr[rand(arr.length - 1)] + " "
	end
	puts sentence
end

unigram_array = []
#unigrams("kjBibleNoVrs.txt", "unigrams.txt", unigram_array)
words_to_array("kjBibleNoVrs.txt", unigram_array)
random_sentence(unigram_array)