require "./pos.rb"

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
