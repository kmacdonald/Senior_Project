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
