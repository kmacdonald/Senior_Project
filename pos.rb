#these sentenceays can be accessed by other files
@noun = []
@proper_noun = []
@plural = []
@noun_phrase = []
@verb = []
@transitive_verb = []
@intransitive_verb = []
@adjective = []
@adverb = []
@conjunction = []
@preposition = []
@interjection = []
@pronoun = []
@definite_article = []
@indefinite_article = []
@singular_article = []
@plural_article = []
@number = []
@nominative = []
@punctuation = [";", "!", ",", ":", ".", "(", ")", "?"]

#sorts the words based on their part of speech; some go in multiple arrays
def words_to_pos_array(filename)
	corpus = File.new(filename, "r")
	while(line = corpus.gets)
		word = line.chomp.split(":")
		if(word[1].include?("n"))
			@noun << word[0].split(";")[0]
			@plural << word[0].split(";")[1]
		end
		if(word[1].include?("N"))
			@proper_noun << word[0]
		end
		#if(word[1].include?("p"))
		#	@plural << word[0]
		#end
		if(word[1].include?("h"))
			@noun_phrase << word[0]
		end
		if(word[1].include?("V"))
			@verb << word[0].split(";")
		end
		if(word[1].include?("t"))
			@transitive_verb << word[0].split(";")
		end
		if(word[1].include?("i"))
			@intransitive_verb << word[0].split(";")
		end
		if(word[1].include?("A"))
			@adjective << word[0]
		end
		if(word[1].include?("v"))
			@adverb << word[0]
		end
		if(word[1].include?("C"))
			@conjunction << word[0]
		end
		if(word[1].include?("P"))
			@preposition << word[0]
		end
		if(word[1].include?("!"))
			@interjection << word[0]
		end
		if(word[1].include?("r"))
			@pronoun << word[0]
		end
		if(word[1].include?("D"))
			@definite_article << word[0]
		end
		if(word[1].include?("I"))
			@indefinite_article << word[0]
		end
		if(word[1].include?("o"))
			@nominative << word[0]
		end
		if(word[1].include?("s"))
			@singular_article << word[0]
		end
		if(word[1].include?("u"))
			@plural_article << word[0]
		end
		if(word[1].include?("#"))
			@number << word[0]
		end
	end
end

def pos_to_word(sentence)
	sentence = sentence.split(" ")
	for i in 0..(sentence.length - 1)
		if(sentence[i] == "noun")
			sentence[i] = @noun.shuffle[0]
		elsif(sentence[i] == "proper_noun")
			sentence[i] = @proper_noun.shuffle[0]
		elsif(sentence[i] == "plural")
			sentence[i] = @plural.shuffle[0]
		elsif(sentence[i] == "noun_phrase")
			sentence[i] = @noun_phrase.shuffle[0]
		elsif(sentence[i] == "verb")
			subject = []
			for j in 0..(i-1)
				if(@noun.include?(sentence[j]) or @proper_noun.include?(sentence[j]) or @noun_phrase.include?(sentence[j]) or @plural.include?(sentence[j]))
					subject << sentence[j]
				end
			end
			if((i != 0 and subject.length != 0 and @plural.include?(subject.last)) or (subject.length == 0))
				sentence[i] = @verb.shuffle[0][0]
			else
				sentence[i] = @verb.shuffle[0][1]
			end
		elsif(sentence[i] == "transitive_verb")
			subject = []
			for j in 0..(i-1)
				if(@noun.include?(sentence[j]) or @proper_noun.include?(sentence[j]) or @noun_phrase.include?(sentence[j]) or @plural.include?(sentence[j]))
					subject << sentence[j]
				end
			end
			if((i != 0 and subject.length != 0 and @plural.include?(subject.last)) or (subject.length == 0))
				sentence[i] = @transitive_verb.shuffle[0][0]
			else
				sentence[i] = @transitive_verb.shuffle[0][1]
			end
		elsif(sentence[i] == "intransitive_verb")
			subject = []
			for j in 0..(i-1)
				if(@noun.include?(sentence[j]) or @proper_noun.include?(sentence[j]) or @noun_phrase.include?(sentence[j]) or @plural.include?(sentence[j]))
					subject << sentence[j]
				end
			end
			if((i != 0 and subject.length != 0 and @plural.include?(subject.last)) or (subject.length == 0))
				sentence[i] = @intransitive_verb.shuffle[0][0]
			else
				sentence[i] = @intransitive_verb.shuffle[0][1]
			end
		elsif(sentence[i] == "adjective")
			sentence[i] = @adjective.shuffle[0]
		elsif(sentence[i] == "adverb")
			sentence[i] = @adverb.shuffle[0]
		elsif(sentence[i] == "conjunction")
			sentence[i] = @conjunction.shuffle[0]
		elsif(sentence[i] == "preposition")
			sentence[i] = @preposition.shuffle[0]
		elsif(sentence[i] == "interjection")
			sentence[i] = @interjection.shuffle[0]
		elsif(sentence[i] == "pronoun")
			sentence[i] = @pronoun.shuffle[0]
		elsif(sentence[i] == "singular_article")
			sentence[i] = @singular_article.shuffle[0]
		elsif(sentence[i] == "plural_article")
			sentence[i] = @plural_article.shuffle[0]
		elsif(sentence[i] == "nominative")
			sentence[i] = @nominative.shuffle[0]
		elsif(@punctuation.include?(sentence[i]))
			sentence[i] = sentence[i]
		else
			puts "error in pos_to_word"
		end
	end
	sentence = sentence.join(" ")
	return sentence
end

def change_verb_tense(verb, ind)
	new_verb = ""
	@verb.each do |v|
		if(v.include?(verb))
			new_verb = v[ind]
		end
	end
	@transitive_verb.each do |v|
		if(v.include?(verb))
			new_verb = v[ind]
		end
	end
	@intransitive_verb.each do |v|
		if(v.include?(verb))
			new_verb = v[ind]
		end
	end
	return new_verb
end

def sentence_about(subject, pos)
	sentence = ""
	sentence = pos_to_word(pos).split(" ")
	puts sentence.inspect
	nouns = []
	verbs = []
	articles = []
	for i in 0..(sentence.length-1)
		if(@noun.include?(sentence[i]) or @proper_noun.include?(sentence[i]) or @noun_phrase.include?(sentence[i]) or @plural.include?(sentence[i]))
			nouns << i
		end
		if(@verb.include?(sentence[i]) or @transitive_verb.include?(sentence[i]) or @intransitive_verb.include?(sentence[i]))
			verbs << i
		end
		if(@singular_article.include?(sentence[i]) or @plural_article.include?(sentence[i]))
			puts sentence
			articles << i
		end
	end
	puts articles.inspect
	sentence[nouns[0]] = subject
	if(@plural.include?(subject))
		for i in 0..(verbs.length-1)
			sentence[verbs[i]] = change_verb_tense(sentence[verbs[i]], 0)
		end
		for i in 0..(articles.length-1)
			sentence[articles[i]] = @plural_article.shuffle[0]
		end
	else
		for i in 0..(verbs.length-1)
			sentence[verbs[i]] = change_verb_tense(sentence[verbs[i]], 1)
		end
		for i in 0..(articles.length-1)
			if(sentence[articles[i]] != "horse" and sentence[articles[i]] != "Horse")
				sentence[articles[i]] = @singular_article.shuffle[0]
			end
		end
	end
	return sentence.join(" ")
end

#and now they are filled up:
words_to_pos_array("words.txt")
