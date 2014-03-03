require "./pos.rb"
require "./grammar_tests.rb"

def independent_clause
	type = rand(4)
	number = rand(2)
	if(number == 0)
		if(type == 0)
			return [[declarative.flatten], "declarative", "singular"]
		elsif(type == 1)‮
			return [[imperative.flatten], "imperative", "singular"]
		elsif(type == 2)
			return [[interrogative.flatten], "interrogative", "singular"]
		else
			return [[exclamatory.flatten], "exclamatory", "none"]
		end
	else
		if(type == 0)
			return [[declarative.flatten], "declarative", "plural"]
		elsif(type == 1)‮
			return [[imperative.flatten], "imperative", "plural"]
		elsif(type == 2)
			return [[interrogative.flatten], "interrogative", "plural"]
		else
			return [[exclamatory.flatten], "exclamatory", "none"]
		end
	end
end

def dependent_clause
	type = rand(2)
	if(type == 0)
		return ["relative pronoun", predicate]
	else
		return ["relative_adverb", noun_phrase, predicate]
	end
end

def declarative
	phrase = []
	dependent1 = rand(2)
	dependent2 = rand(2)
	coordinate = rand(2)
	punctuation = rand(2)
	if(dependent1 == 0)
		phrase << dependent_clause
		phrase << ","
	end
	phrase << subject
	phrase << predicate
	if(dependent2 == 0)
		phrase << ","
		phrase << dependent_clause
	end
	if(coordinate == 0)
		phrase << coordinate
	end
	if(punctuation == 0)
		phrase << "."
	else
		phrase << "!"
	end
	return phrase
end

def imperative
	phrase = []
	dependent = rand(2)
	coordinate = rand(2)
	punctuation = rand(2)
	phrase << predicate
	if(dependent == 0)
		phrase << dependent_clause
	end
	if(coordinate == 0)
		phrase << coordinate
	end
	if(punctuation == 0)
		phrase << "."
	else
		phrase << "!"
	end
	return phrase
end

def interrogative
	phrase = []
	dependent1 = rand(2)
	pronoun_adverb = rand(3)
	dependent2 = rand(2)
	coordinate = rand(2)
	punctuation = rand(2)
	if(dependent1 == 0)
		phrase << dependent_clause
		phrase << ","
	end
	if(pronoun_adverb == 0)
		phrase << "relative_pronoun"
	elsif(pronoun_adverb == 1)
		phrase << "relative_adverb"
	else
	end
	phrase << predicate
	phrase << subject
	if(dependent2 == 0)
		phrase << ","
		phrase << dependent_clause
	end
	if(coordinate == 0)
		phrase << coordinate
	end
	phrase << "?"
	return phrase
end

def exclamatory
	return ["interjection", !]
end

def subject
	phrase = []
	adjective = rand(2)
	adj_prep = rand(3)
	noun = rand(3)
	article = rand(4)
	quantifier = rand(3)
	if(noun == 0)
		if(article == 0)
			phrase << "possessive"
		elsif(article == 1)
			phrase << "singular_demonstrative"
		else
			phrase << "singular_article"
		end
		if(adjective == 0)
			phrase << "adjective"
		end
		phrase << "noun"
	elsif(noun == 1)
		if(article == 0)
			phrase << "possessive"
		elsif(article == 1)
			phrase << "plural_demonstrative"
		elsif(article == 2)
			phrase << "plural_article"
		else
		end
		if(quantifier == 0)
			phrase << "quantifier"
		end
		if(adjective == 0)
			phrase << "adjective"
		end
		phrase << "plural"
	else
		if(adjective == 0)
			phrase << "adjective"
		end
		phrase << "proper_noun"
	end
	if(adj_prep == 0)
		phrase << adjectival
	elsif(adj_prep == 1)
		phrase << prepositional
	else
	end
	return phrase
end

def predicate
	phrase == []
	helping_verb = rand(3)
	verb_type = rand(3)
	adverb = rand(3)
	before_after = rand(2)
	if(helping_verb == 0)
		phrase << "helping_verb"
	end
	verb = ""
	if(verb_type == 0)
		verb = "transitive_verb noun_phrase"
	elsif(verb_type == 1)
		verb = "intransitive_verb"
	else
		verb = "verb"
	end
	if(adverb == 0)
		if(before_after == 0)
			phrase << "adverb"
			phrase << verb
		else
			phrase << verb
			phrase << "adverb"
		end
	else
		phrase << "verb"
	end
	return phrase
end

def coordinate
	return [",", "coordinating_conjuction", independent_clause]
end

def prepositional
	return ["preposition", noun_phrase]
end

def adjectival
	return dependent_clause
end
