require "./pos.rb"
require "./sort_content.rb"
require "./knowledge.rb"

def independent_clause(content)
	type = rand(10)
	content = classify_input(content)
	subj = ""
	content.each do |word|
		if(noun_type(word[0]) != "not a noun")
			subj = word[0]
		end
	end
	if(subj.empty?)
		subj = @knowledge.shuffle[0][0]
	end
	if(type == 0)
		sentence = exclamatory(content, subj).flatten
		sentence << "! "
		return sentence
	elsif(type == 1)
		sentence = imperative(content, subj).flatten
		sentence << "! "
		return sentence
	elsif(type == 2)
		sentence = interrogative(content, subj).flatten
		sentence << "? "
		return sentence
	else
		sentence = declarative(content, subj).flatten
		sentence << ". "
		return sentence
	end
end

def dependent_clause(content, subj)
	phrase = []
	type = rand(2)
	if(type == 0)
		phrase = [@relative_pronoun.shuffle[0], predicate("declarative", content, @knowledge.shuffle[0][0])]
	else
		phrase = [@relative_adverb.shuffle[0], subject(content, @knowledge.shuffle[0][0]), predicate("declarative", content, @knowledge.shuffle[0][0])]
	end
	return phrase
end

def declarative(content, subj)
	phrase = []
	chance = [rand(4), rand(8), rand(16)].shuffle
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
	phrase = []
	type = rand(3)
	if(type == 0)
		phrase = [@interjection.shuffle[0]]
	elsif(type == 1)
		phrase = declarative(content, subj)
	else
		phrase = imperative(content, subj)
	end
	puts phrase.inspect
	return phrase
end

def subject(content, subj)
	phrase = []
	chance = [rand(4), rand(8)].shuffle
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
			puts "article = " + article
		end
		if((word[1] == "noun") or (word[1] == "plural_noun") or (word[1] == "proper_noun"))
			noun = word[0]
		end
		if(word[1] == "adjective")
			adjective = word[0]
		end
	end
	if(noun_type(noun) == "noun")
		runoun = @knowledge.shuffle[0][0]
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
			adjective = retrieve_adjective(subj)
		end
		if(chance[0] == 0 and adjective == "")
			adjective = @adjective.shuffle[0]
		end
	else
		preposition = prepositional_clause([], @knowledge.shuffle[0][0])
	end
	if(chance[1] == 0)
		quantifier = @quantifier.shuffle[0]
	end
	phrase = [quantifier, article, adjective, preposition, noun]
	return phrase
end

def predicate(type, content, subj)
	phrase = []
	helping_verb = rand(4)
	adverb = rand(4)
	before_after = rand(2)
	if(helping_verb == 0 and type != "imperative")
		phrase << @helping_verb.shuffle[0][0]
	end
	verb = retrieve_verb(subj)
	if(verb_type(verb) == "transitive_verb")
		verb_type = 0
	elsif(verb_type(verb) == "intransitive_verb")
		verb_type = 1
	elsif(verb_type(verb) == "verb")
		verb_type = 2
	else
		verb_type = rand(3)
	end
	if(verb_type == 0)
		new_noun = @knowledge.shuffle[0][0]
		if((type == "declarative" and noun_type(subj) == "plural") or type == "interrogative" or type == "imperative")
			if(verb == "")
				
				verb = [@transitive_verb.shuffle[0][0], subject([[new_noun, "noun"]], new_noun)]
			else
				verb = [verb_form(verb, 0), subject([[new_noun, "noun"]], new_noun)]
			end
		else
			if(verb == "")
				verb = [@transitive_verb.shuffle[0][1], subject([[new_noun, "noun"]], new_noun)]
			else
				verb = [verb_form(verb, 1), subject([[new_noun, "noun"]], new_noun)]
			end
		end
	elsif(verb_type == 1)
		if((type == "declarative" and noun_type(subj) == "plural_noun") or type == "interrogative" or type == "imperative")
			if(verb == "")
				verb = @intransitive_verb.shuffle[0][0]
			else
				verb = verb_form(verb, 0)
			end
		else
			if(verb == "")
				verb = @intransitive_verb.shuffle[0][1]
			else
				verb_form(verb, 1)
			end
		end
	else
		if((type == "declarative" and noun_type(subj) == "plural_noun") or type == "interrogative" or type == "imperative")
			if(verb == "")
				verb = @verb.shuffle[0][0]
			else
				verb_form(verb, 0)
			end
		else
			if(verb == "")
				verb = @verb.shuffle[0][1]
			else
				verb_form(verb, 1)
			end
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
	new_noun = @knowledge.shuffle[0][0]
	phrase = [",", @coordinating_conjunction.shuffle[0], declarative([[new_noun, "noun"]], new_noun)]
	return phrase
end

def prepositional_clause(content, subj)
	new_noun = @knowledge.shuffle[0][0]
	phrase = [@preposition.shuffle[0], subject([[new_noun, "noun"]], new_noun)]
	return phrase
end

def adjectival_clause(content, subj)
    new_noun = @knowledge.shuffle[0][0]
	phrase = dependent_clause([[new_noun, "noun"]], new_noun)
	return phrase
end

def proper_spacing(sentence)
	@punctuation.each do |punct|
		if(punct != "(")
			sentence.gsub!(" " + punct, punct)
		else
			sentence.gsub!(punct + " ", punct)
		end
	end
	return sentence
end

def assemble_sentence(content)
	sentence = independent_clause(content)
	sentence.delete_if {|w| w == "" }
	sentence[0] = sentence[0].capitalize
	sentence = sentence.join(" ")
	return proper_spacing(sentence)
end

def make_story(content)
	length = 3 + rand(3)
	story = ""
	for i in 0..length
		story += assemble_sentence(content)
	end
	return story
end

puts "Enter a topic: "
content = gets.chomp
sentence = make_story(content)
puts sentence.inspect
