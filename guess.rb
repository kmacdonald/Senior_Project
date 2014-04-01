require "./pos.rb"

@twos = []
@threes = []

def read_structures(filename)
	corpus = File.new(filename, "r")
	while(line = corpus.gets)
		structure = line.split(" ")
		if(structure.length == 2)
			@twos << structure
		else
			@threes << structure
		end
	end
end

def determine_one(phrase)
	pos_arr = []
	pos = find_pos(phrase[0])
	if(pos.length == 1)
		pos_arr << pos[0]
	elsif(pos.include?("noun") or pos.include?("plural") or pos.include?("proper_noun"))
		pos_arr << noun_type(phrase[0])
	elsif(pos.include?("verb") or pos.include?("transitive_verb") or pos.include?("intransitive_verb"))
		pos_arr << verb_type(phrase[0])
	else
		pos_arr << pos.shuffle[0]
	end
	return pos_arr
end

def determine_two(phrase)
	pos_arr = []
	phrase.each do |w|
		pos_arr << find_pos(w)
	end
	temp1 = []
	for i in 0..(pos_arr[0].length - 1)
		for j in 0..(pos_arr[1].length - 1)
			temp2 = [pos_arr[0][i], pos_arr[1][j]]
			if(@twos.include?(temp2))
				temp1 << temp2
			end
		end
	end
	if(temp1.length == 1)
		pos_arr = temp1[0]
	else
		pos_arr = temp1.shuffle[0]
	end
	return pos_arr
end

def determine_three(word1, word2, word3)
	pos_arr = []
	temp1 = []
	for i in 0..(word1.length - 1)
		for j in 0..(word2.length - 1)
			for k in 0..(word3.length - 1) 
				temp2 = [word1[i], word2[j], word3[k]]
				if(@threes.include?(temp2))
					temp1 << temp2
				end
			end
		end
	end
	first_word = []
	second_word = []
	third_word = []
	temp1.each do |w|
		first_word << w[0]
		second_word << w[1]
		third_word << w[2]
	end
	for i in 0..(word1.length - 1)
		if(!first_word.include?(word1[i]))
			word1[i] == ""
		end
	end
	for i in 0..(word2.length - 1)
		if(!second_word.include?(word2[i]))
			word2[i] == ""
		end
	end
	for i in 0..(word3.length - 1)
		if(!third_word.include?(word3[i]))
			word3[i] == ""
		end
	end
	word1.delete_if{|w| w == ""}
	word2.delete_if{|w| w == ""}
	word3.delete_if{|w| w == ""}
	puts [word1, word2, word3]
	return [word1, word2, word3, temp1]
end

def determine_pos(phrase)
	pos_arr = []
	if(phrase.length == 1)
		pos_arr = determine_one(phrase)
	elsif(phrase.length == 2)
		pos_arr = determine_two(phrase)
	else
		phrase.each do |w|
			pos_arr << find_pos(w)
		end
		for i in 0..1
			for i in 0..(pos_arr.length - 3)
				temp = determine_three(pos_arr[i], pos_arr[i+1], pos_arr[i+2])
				pos_arr[i] = temp[0]
				pos_arr[i+1] = temp[1]
				pos_arr[i+2] = temp[2]
			end
		end
		for i in 0..(pos_arr.length - 1)
			if(pos_arr[i].length > 1)
				pos_arr[i] = pos_arr[i].shuffle[0]
			end
		end
		pos_arr.flatten!
	end
	return pos_arr
end


def subject_from_content(content)
	noun_phrase = [[], []]
	for i in 0..(content.length - 1)
		if(@singular_article.include?(content[i]) and !noun_phrase[0].include?(content[i]))
			noun_phrase[0] << content[i]
			noun_phrase[1] << "singular_article"
		end
		if(@plural_article.include?(content[i]) and !noun_phrase[0].include?(content[i]))
			noun_phrase[0] << content[i]
			noun_phrase[1] << "plural_article"
		end
		if(@adjective.include?(content[i]) and !noun_phrase[0].include?(content[i]))
			noun_phrase[0] << content[i]
			noun_phrase[1] << "adjective"
		end
		if(noun_type(content[i]) != "not a noun" and !noun_phrase[0].include?(content[i]))
			noun_phrase[0] << content[i]
			noun_phrase[1] << noun_type(content[i])
		end
		if((verb_type(content[i]) != "not a verb") and !(@article.include?(content[i]) or @article.include?(content[i]) or noun_type(content[i]) != "not a noun"))
			break
		end
	end
	return noun_phrase
end

def predicate_from_content(content)
	verb_phrase = [[], []]
	for i in 0..(content.length - 1)
		if(@adverb.include?(content[i]))
			if(i != 0 and verb_type(content[i-1]) != "not a verb" and !verb_phrase.include?(content[i-1]))
				verb_phrase[0] << content[i-1]
				verb_phrase[1] << verb_type(content[i-1])
				verb_phrase[0] << content[i]
				verb_phrase[1] << "adverb"
			elsif(i != (content.length - 1) and verb_type(content[i+1]) != "not a verb" and !verb_phrase.include?(content[i-1]))
				verb_phrase[0] << content[i]
				verb_phrase[1] << "adverb"	
				verb_phrase[0] << content[i+1]
				verb_phrase[1] << verb_type(content[i+1])			
			else
				verb_phrase[0] << content[i]
				verb_phrase[1] << "adverb"
			end
		end
		if(verb_type(content[i]) != "not a verb" and !verb_phrase.include?(content[i]))
			verb_phrase[0] << content[i]
			verb_phrase[1] << verb_type(content[i])	
		end
		if((i > 0 and verb_type(content[i-1]) == "transitive") or (i > 1 and verb_type(content[i-2]) == "transitive"))
			object = subject_from_content(content.drop(i))
			for j in 0..(object[0].length - 1)
				verb_phrase[0] << object[0][j]
				verb_phrase[1] << object[1][j]
			end			
		end
	end
	puts verb_phrase.inspect
	return verb_phrase
end

def sort_content(content)
	content = content.split(" ")
	arr = []
	arr << subject_from_content(content)
	arr << predicate_from_content(content)
	puts arr.inspect
	return arr
end

