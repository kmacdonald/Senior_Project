require "./pos.rb"
require "./grammar_tests.rb"

def build_independent(clause)
	chance = rand(4)
	if(chance == 0)
		clause = [[], "declarative"]
	elsif(chance == 1)
		clause = [[], "imperative"]
	elsif(chance == 2)
		clause = [[], "interrogative"]
	else
		clause = [[], "exclamatory"]
	end
	return clause
end

def build_dependent(clause)
	
end

def build_declarative(clause)
	
end

def build_imperative(clause)
	
end

def build_interrogative(clause)
	
end

def build_exclamatory(clause)
	exclamatory = ["interjection"]
	return exclamatory
end

def build_subject(clause)
	for i in clause[0].length
		if(clause[0][i] == "subject")
			noun_phrase = []
			article_chance = rand(4)
			quantifier_chance = rand(3)
			adjective_chance = rand(2)
			noun_chance = rand(3)
			adj_prep_chance = rand(3)
			article = ""
			if(noun_chance == 0)
				if(article_chance == 0)
					noun_phrase << "possessive"
				elsif(article_chance == 1)
					noun_phrase << "singular_demonstrative"
				else
					noun_phrase << "singular_article"
				end
				if(adjective_chance == 0)
					noun_phrase << "adjective"
				end
				noun_phrase << "noun"
			elsif(noun_chance == 1)
				if(article_chance == 0)
					noun_phrase << "possessive"
				elsif(article_chance == 1)
					noun_phrase << "plural_demonstrative"
				elsif(article_chance == 2)
					noun_phrase << "plural_article"
				else
				end
				if(quantifier_chance == 0)
					noun_phrase << "quantifier"
				end
				if(adjective_chance == 0)
					noun_phrase << "adjective"
				end
				noun_phrase << "plural"
			else
				if(adjective_chance == 0)
					noun_phrase << "adjective"
				end
				noun_phrase << "proper_noun"
			end
			if(adj_prep_chance == 0)
				noun_phrase << "adjectival_phrase"
			elsif(adj_prep_chance == 1)
				noun_phrase << "prepositional_phrase"
			else
			end
		end
	end
end

def build_predicate(clause)
	for i in clause[0].length
		if(clause[0][i] == "predicate")
			verb_phrase == []
			helping_verb_chance = rand(3)
			adverb_chance = rand(3)
			before_after_chance = rand(2)
			if(helping_verb_chance == 0)
				verb_phrase << "helping_verb"
			end
			if(adverb_chance == 0)
				if(before_after_chance == 0)
					verb_phrase << "adverb"
					verb_phrase << "verb"
				else
					verb_phrase << "verb"
					verb_phrase << "adverb"
				end
			else
				verb_phrase << "verb"
			end
		end
		clause[0][i] == verb_phrase
	end
	return clause
end

def build_coordinate(clause)
	
end
