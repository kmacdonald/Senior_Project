require "./pos.rb"

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

#==============================================================================================#

def noun_type(word)
	type = ""
	@noun.each do |w|
		if(w[0] == word)
			type = "noun"
		elsif(w[1] == word)
			type = "plural_noun"
		end
	end	
	if(@proper_noun.include?(word))
		type = "proper_noun"
	end
	if(type == "")
		type = "not a noun"
	end
	return type
end

def verb_type(word)
	type = ""
	@verb.each do |w|
		if(w.include?(word))
			type = "verb"
		end
	end
	@transitive_verb.each do |w|
		if(w.include?(word))
			type = "transitive"
		end
	end
	@intransitive_verb.each do |w|
		if(w.include?(word))
			type = "intransitive"
		end
	end
	if(type == "")
		type = "not a verb"
	end
	return type
end

def article_type(word)
	type = ""
	if(@singular_article.include?(word))
		type = "singular_article"
	elsif(@plural_article.include?(word))
		type = "plural_article"
	else
		type = "not an article"
	end
	return type
end

def classify_input(phrase)
	pos = ""
	IO.popen("python classify.py " + phrase).each do |line|
		pos = line
	end.close
	pos = pos.gsub("[", "").gsub("]", "").split("'),")
	pos.delete_if{|word| word.include?("POS") or word.include?("classify.py")}
	for i in 0..(pos.length - 1)
		pos[i] = pos[i].gsub("\"", "").gsub(" (u'", "").gsub("u'", "").split("', ")
		pos[i][1] = pos[i][1].gsub("NNS", "plural_noun")
		pos[i][1] = pos[i][1].gsub("NNP", "proper_noun")
		pos[i][1] = pos[i][1].gsub("NN", "noun")
		pos[i][1] = pos[i][1].gsub("JJ", "adjective")
		pos[i][1] = pos[i][1].gsub("RB", "adverb")
		pos[i][1] = pos[i][1].gsub("VBZ", verb_type(pos[i][0]))
		pos[i][1] = pos[i][1].gsub("DT", article_type(pos[i][0]))
	end
	return pos
end

#def find_noun_phrases(phrase)
#	pos = ""
#	IO.popen("python noun_phrases.py " + phrase).each do |line|
#		pos = line
#	end.close
#	return pos
#end
#noun_phrases = find_noun_phrases(phrase)
#puts noun_phrases.inspect
