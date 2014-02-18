def words_to_array(filename, noun, proper_noun, plural, noun_phrase, verb, transitive_verb, intransitive_verb, adjective, adverb, conjunction, preposition, interjection, pronoun, definite_article, indefinite_article, nominative)
	corpus = File.new(filename, "r")
	while(line = corpus.gets)
		word = line.chomp.split(":")
		if(word[1].include?("N"))
			if(word[0] == word[0].downcase)
				noun << word[0]
			else
				proper_noun << word[0]
			end
		end
		if(word[1].include?("p"))
			plural << word[0]
		end
		if(word[1].include?("h"))
			noun_phrase << word[0]
		end
		if(word[1].include?("V"))
			verb << word[0]
		end
		if(word[1].include?("t"))
			transitive_verb << word[0]
		end
		if(word[1].include?("i"))
			intransitive_verb << word[0]
		end
		if(word[1].include?("A"))
			adjective << word[0]
		end
		if(word[1].include?("v"))
			adverb << word[0]
		end
		if(word[1].include?("C"))
			conjunction << word[0]
		end
		if(word[1].include?("P"))
			preposition << word[0]
		end
		if(word[1].include?("!"))
			interjection << word[0]
		end
		if(word[1].include?("r"))
			pronoun << word[0]
		end
		if(word[1].include?("D"))
			definite_article << word[0]
		end
		if(word[1].include?("I"))
			indefinite_article << word[0]
		end
		if(word[1].include?("o"))
			nominative << word[0]
		end
	end
end

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
@nominative = []
words_to_array("words.txt", @noun, @proper_noun, @plural, @noun_phrase, @verb, @transitive_verb, @intransitive_verb, @adjective, @adverb, @conjunction, @preposition, @interjection, @pronoun, @definite_article, @indefinite_article, @nominative)
