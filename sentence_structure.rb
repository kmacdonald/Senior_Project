require "./pos.rb"
require "./sort_content.rb"

def independent_clause(content)
	puts "independent clause"
	type = rand(10)
	content = classify_input(content)
	puts content.inspect
	subj = ""
	content.each do |word|
		if(noun_type(word[0]) != "not a noun")
			subj = word[0]
		end
	end
	if(subj.empty?)
		subj = @noun.shuffle[0][0]
	end
	if(type == 0)
		return proper_punctuation_spacing(exclamatory(content, subj).flatten.join(" ")).capitalize! + "!"
	elsif(type == 1)
		return proper_punctuation_spacing(imperative(content, subj).flatten.join(" ")).capitalize! + "!"
	elsif(type == 2)
		return proper_punctuation_spacing(interrogative(content, subj).flatten.join(" ")).capitalize! + "?"
	else
		return proper_punctuation_spacing(declarative(content, subj).flatten.join(" ")).capitalize! + "."
	end
end

def dependent_clause(content, subj)
	puts "dependent clause"
	phrase = []
	type = rand(2)
	if(type == 0)
		phrase = [@relative_pronoun.shuffle[0], predicate("declarative", content, @noun.shuffle[0][0])]
	else
		phrase = [@relative_adverb.shuffle[0], subject(content, @noun.shuffle[0][0]), predicate("declarative", content, @noun.shuffle[0][0])]
	end
	return phrase
end

def declarative(content, subj)
	puts "declarative"
	phrase = []
	chance = [rand(2), rand(4), rand(8)].shuffle
	dependent1 = chance[0]
	dependent2 = chance[1]
	coord = chance[2]
	if(dependent1 == 0)
		phrase << dependent_clause(content, subj)
		phrase << ","
	end
	phrase << subject(content, subj)
	phrase << predicate("declarative", content, subj)
	if(dependent2 == 0)
		phrase << ","
		phrase << dependent_clause(content, subj)
	end
	if(coord == 0)
		phrase << coordinate_clause(content, subj)
	end
	return phrase
end

def imperative(content, subj)
	puts "imperative"
	phrase = []
	chance = [rand(2), rand(4)].shuffle
	dependent = chance[0]
	coord = chance[1]
	phrase << predicate("imperative", content, subj)
	if(dependent == 0)
		phrase << dependent_clause(content, subj)
	end
	if(coord == 0)
		phrase << coordinate_clause(content, subj)
	end
	return phrase
end

def interrogative(content, subj)
	puts "interrogative"
	phrase = []
	type = rand(3)
	if(type == 0)
		phrase << declarative(content, subj)
	else
		chance = [rand(2), rand(4), rand(8)].shuffle
		dependent1 = chance[0]
		pronoun_adverb = rand(4)
		dependent2 = chance[1]
		coord = chance[2]
		punctuation = rand(2)
		if(dependent1 == 0)
			phrase << dependent_clause(content, subj)
			phrase << ","
		end
		if(pronoun_adverb == 0)
			phrase << @relative_pronoun.shuffle[0]
		elsif(pronoun_adverb == 1)
			phrase << @relative_adverb.shuffle[0]
			phrase << @helping_verb.shuffle[0][0]
		else
		end
		phrase << predicate("interrogative", content, subj)
		phrase << subject(content, subj)
		if(dependent2 == 0)
			phrase << ","
			phrase << dependent_clause(content, subj)
		end
		if(coord == 0)
			phrase << coordinate_clause(content, subj)
		end
	end
	return phrase
end

def exclamatory(content, subj)
	puts "exclamatory"
	phrase = []
	type = rand(3)
	if(type == 0)
		phrase = [@interjection.shuffle[0]]
	elsif(type == 1)
		phrase = declarative(content, subj)
	else
		phrase = imperative(content, subj)
	end
	return phrase
end

def subject(content, subj)
	puts "subject"
	phrase = []
	chance = [rand(2), rand(4)].shuffle
	noun_chance  = rand(3)
	adj_prep = rand(4)
	article = rand(4)
	article = ""
	quantifier = ""
	adjective = ""
	preposition = ""
	noun = subj
	content.each do |word|
		if((word[1] == "singular_article") or (word[1] == "plural_article") )
			article = word[0]
		end
		if((word[1] == "noun") or (word[1] == "plural_noun") or (word[1] == "proper_noun"))
			noun = word[0]
		end
		if(word[1] == "adjective")
			adjective = word[0]
		end
	end
	if(noun_type(noun) == "noun")
		runoun = @noun.shuffle[0][0]
		if(article == "")
			article = @singular_article.shuffle[0]
		end
	elsif(noun_type(noun) == "plural")
		if(article == "")
			article = @plural_article.shuffle[0]
		end
	end
	if(adj_prep < 3)
		if(chance[0] == 0 and adjective == "")
			adjective = @adjective.shuffle[0]
		end
	else
		preposition = prepositional_clause([], @noun.shuffle[0][0])
	end
	if(chance[1] == 0)
		quantifier = @quantifier.shuffle[0]
	end
	puts noun.inspect
	phrase = [article, quantifier, adjective, preposition, noun]
	return phrase
end

def predicate(type, content, subj)
	puts "predicate"
	phrase = []
	helping_verb = rand(4)
	verb_type = rand(3)
	adverb = rand(4)
	before_after = rand(2)
	if(helping_verb == 0 and type != "imperative")
		phrase << @helping_verb.shuffle[0][0]
	end
	verb = ""
	puts subj
	puts "noun type: "
	puts noun_type(subj)
	if(verb_type == 0)
		if((type == "declarative" and noun_type(subj) == "plural") or type == "interrogative" or type == "imperative")
			verb = [@transitive_verb.shuffle[0][0], subject([], @noun.shuffle[0][0])]
		else
			verb = [@transitive_verb.shuffle[0][1], subject([], @noun.shuffle[0][0])]
		end
	elsif(verb_type == 1)
		if((type == "declarative" and noun_type(subj) == "plural") or type == "interrogative" or type == "imperative")
			verb = @intransitive_verb.shuffle[0][0]
		else
			verb = @intransitive_verb.shuffle[0][1]
		end
	else
		if((type == "declarative" and noun_type(subj) == "plural") or type == "interrogative" or type == "imperative")
			verb = @verb.shuffle[0][0]
		else
			verb = @verb.shuffle[0][1]
		end
	end
	if(adverb == 0)
		if(before_after == 0)
			phrase << @adverb.shuffle[0]
			phrase << verb
		else
			phrase << verb
			phrase << @adverb.shuffle[0]
		end
	else
		phrase << verb
	end
	return phrase
end

def coordinate_clause(content, subj)
	puts "coordinate"
	phrase = [",", @coordinating_conjunction.shuffle[0], declarative([], @noun.shuffle[0][0])]
	return phrase
end

def prepositional_clause(content, subj)
	puts "prepositional"
	phrase = [@preposition.shuffle[0], subject([], @noun.shuffle[0][0])]
	return phrase
end

def adjectival_clause(content, subj)
	puts "adjectival"
	phrase = dependent_clause([], @noun.shuffle[0][0])
	return phrase
end

def proper_punctuation_spacing(sentence)
	@punctuation.each do |punct|
		if(punct != "(")
			sentence.gsub!(" " + punct, punct)
		else
			sentence.gsub!(punct + " ", punct)
		end
	end
	sentence.gsub!("  ", " ")
	sentence.gsub!("  ", " ")
	return sentence
end

content = "a brown horse"
sentence = independent_clause(content)
puts sentence.inspect
