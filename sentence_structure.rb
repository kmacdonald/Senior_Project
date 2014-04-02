require "./pos.rb"
require "./sort_content.rb"
require "./knowledge.rb"

def independent_clause(content)
	type = 1
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
		sentence = exclamatory(content, subj, [[],[]])
		sentence << "! "
		return sentence
	elsif(type == 1)
		sentence = imperative(content, subj, [[],[]])
		sentence << "! "
		return sentence
	elsif(type == 2)
		sentence = interrogative(content, subj, [[],[]])
		sentence << "? "
		return sentence
	else
		sentence = declarative(content, subj, [[],[]])
		sentence << ". "
		return sentence
	end
end

def dependent_clause(content, subj, output)
	type = rand(2)
	if(type == 0)
		output[0] << @relative_pronoun.shuffle[0]
		p = predicate("declarative", content, @knowledge.shuffle[0][0], output)
		output[0] << p[0]
		output[1] << ["relative_pronoun", p[1]]
	else
		output[0] << @relative_adverb.shuffle[0]
		s = subject(content, @knowledge.shuffle[0][0], output)
		p = predicate("declarative", content, @knowledge.shuffle[0][0], output)
		output[0] << s[0]
		output[0] << p[0]
		output[1] << ["relative_adverb", s[1], p[1]]
	end
	return output
end

def declarative(content, subj, output)
	chance = [rand(4), rand(8), rand(16)].shuffle
	dependent1 = chance[0]
	dependent2 = chance[1]
	coord = chance[2]
	if(dependent1 == 0)
		d = dependent_clause(content, subj, output)
		output[0] << d[0]
		output[0] << ","
		output[1] << [d[1], ","]
	end
	s = subject(content, subj, output)
	p = predicate("declarative", content, subj, output)
	output[0] << s[0]
	output[0] << p[0]
	output[1] << [s[1], p[1]]
	if(dependent2 == 0)
		d = dependent_clause(content, subj, output)
		output[0] << ","
		output[0] << d[0]
		output[1] << [",", d[1]]
	end
	if(coord == 0)
		c = coordinate_clause(content, subj, output)
		output[0] << c[0]
		output[0] << [c[1]]
	end
	return output
end

def imperative(content, subj, output)
	chance = [rand(2), rand(4)].shuffle
	dependent = chance[0]
	coord = chance[1]
	p = predicate("imperative", content, subj, output)
	output[0] << p[0]
	output[1] << [p[1]]
	if(dependent == 0)
		d = dependent_clause(content, subj, output)
		output[0] << d[0]
		output[1] << [d[1]]
	end
	if(coord == 0)
		c = coordinate_clause(content, subj, output)	
		output[0] << c[0]
		output[1] << [c[1]]
	end
	return output
end

def interrogative(content, subj, output)
	type = rand(3)
	if(type == 0)
		d = declarative(content, subj, output)
		output[0] << d[0]
		output[1] << [d[1]]
	else
		chance = [rand(2), rand(4), rand(8)].shuffle
		dependent1 = chance[0]
		pronoun_adverb = rand(4)
		dependent2 = chance[1]
		coord = chance[2]
		punctuation = rand(2)
		if(dependent1 == 0)
			d = dependent_clause(content, subj, output)
			output[0] << d[0]
			output[0] << ","
			output[0] << [d[1], ","]
		end
		if(pronoun_adverb == 0)
			output[0] << @relative_pronoun.shuffle[0]
			output[1] << ["relative_pronoun"]
		elsif(pronoun_adverb == 1)
			output[0] << @relative_adverb.shuffle[0]
			output[0] << @helping_verb.shuffle[0][0]
			output[1] << ["relative_adverb", "helping_verb"]
		else
		end
		p = predicate("interrogative", content, subj, output)
		s = subject(content, subj, output)
		output[0] << p[0]
		output[0] << s[0]
		output[1] << [p[1], s[1]]
		if(dependent2 == 0)
			d = dependent_clause(content, subj, output)
			output[0] << ","
			output[0] << d[0]
			output[1] << [",", d[1]]
		end
		if(coord == 0)
			c = coordinate_clause(content, subj, output)
			output[0] << c[0]
			output[1] << [c[1]]
		end
	end
	return output
end

def exclamatory(content, subj, output)
	type = rand(3)
	if(type == 0)
		output[0] << @interjection.shuffle[0]
		output[1] << ["interjection"]
	elsif(type == 1)
		d = declarative(content, subj, output)
		output[0] << d[0]
		output[1] << [d[1]]
	else
		i = imperative(content, subj, output)
		output[0] << i[0]
		output[1] << [i[1]]
	end
	return output
end

def subject(content, subj, output)
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
		preposition = prepositional_clause([], @knowledge.shuffle[0][0], output)
	end
	if(chance[1] == 0)
		quantifier = @quantifier.shuffle[0]
	end
	parts = [[quantifier, "quantifier"], [article, "article"], [adjective, "adjective"], [preposition[0], preposition[1]], [noun, "noun"]]
	for i in 0..4
		if(!parts[i].empty?)
			output[0] << parts[i][0]
			output[1] << parts[i][1]
		end
	end
	return output
end

def predicate(type, content, subj, output)
	helping_verb = rand(4)
	adverb = rand(4)
	before_after = rand(2)
	if(helping_verb == 0 and type != "imperative")
		output[0] << @helping_verb.shuffle[0][0]
		output[1] << ["helping_verb"]
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
				verb = [@transitive_verb.shuffle[0][0], subject([[new_noun, "noun"]], new_noun, output)]
			else
				verb = [verb_form(verb, 0), subject([[new_noun, "noun"]], new_noun, output)]
			end
		else
			if(verb == "")
				verb = [@transitive_verb.shuffle[0][1], subject([[new_noun, "noun"]], new_noun, output)]
			else
				verb = [verb_form(verb, 1), subject([[new_noun, "noun"]], new_noun, output)]
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
			output[0] << @adverb.shuffle[0]
			output[0] << verb
			output[1] << ["adverb", "verb"]
		else
			output[0] << verb
			output[0] << @adverb.shuffle[0]
			output[1] << ["verb", "adverb"]
		end
	else
		output[0] << verb
		output[1] << ["verb"]
	end
	return output
end

def coordinate_clause(content, subj, output)
	new_noun = @knowledge.shuffle[0][0]
	d = declarative([[new_noun, "noun"]], new_noun, output)
	output[0] << ","
	output[0] << @coordinating_conjunction.shuffle[0]
	output[0] << d[0]
	puts "declarative = " + d[0].inspect
	output[1] << [",", "coordinating_conjunction", d[1]]
	return output
end

def prepositional_clause(content, subj, output)
	new_noun = @knowledge.shuffle[0][0]
	s = subject([[new_noun, "noun"]], new_noun, output)
	output[0] << @preposition.shuffle[0]
	output[0] << s[0]
	output[1] << ["preposition", s[1]]
	return output
end

def adjectival_clause(content, subj, output)
    new_noun = @knowledge.shuffle[0][0]
	d = dependent_clause([[new_noun, "noun"]], new_noun)
	output[0] << d[0]
	output[1] << [d[1]]
	return output
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
	sentence[0].delete_if {|w| w == "" }
	sentence[0][0] = sentence[0][0].capitalize
	puts sentence[0].inspect
	sentence[0] = sentence[0].join(" ")
	return [proper_spacing(sentence[0]), sentence[1]]
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
sentence = assemble_sentence(content)
puts sentence.inspect
