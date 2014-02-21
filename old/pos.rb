#these arrays can be accessed by other files
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
@punctuation = [";", "!", ",", ":", ".", "(", ")", "?"]

#sorts the words based on their part of speech; some go in multiple arrays
def words_to_pos_array(filename)
	corpus = File.new(filename, "r")
	while(line = corpus.gets)
		word = line.chomp.split(":")
		if(word[1].include?("N"))
			if(word[0] == word[0].downcase)
				@noun << word[0]
			else
				@proper_noun << word[0]
			end
		end
		if(word[1].include?("p"))
			@plural << word[0]
		end
		if(word[1].include?("h"))
			@noun_phrase << word[0]
		end
		if(word[1].include?("V"))
			@verb << word[0]
		end
		if(word[1].include?("t"))
			@transitive_verb << word[0]
		end
		if(word[1].include?("i"))
			@intransitive_verb << word[0]
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
	end
end

def pos_to_word(pos)
	if(pos == "noun")
		return @noun.shuffle[0]
	elsif(pos == "proper_noun")
		return @proper_noun.shuffle[0]
	elsif(pos == "plural")
		return @plural.shuffle[0]
	elsif(pos == "noun_phrase")
		return @noun_phrase.shuffle[0]
	elsif(pos == "verb")
		return @verb.shuffle[0]
	elsif(pos == "transitive_verb")
		return @transitive_verb.shuffle[0]
	elsif(pos == "intransitive_verb")
		return @intransitive_verb.shuffle[0]
	elsif(pos == "adjective")
		return @adjective.shuffle[0]
	elsif(pos == "adverb")
		return @adverb.shuffle[0]
	elsif(pos == "conjunction")
		return @conjunctino.shuffle[0]
	elsif(pos == "preposition")
		return @preposition.shuffle[0]
	elsif(pos == "interjection")
		return @interjection.shuffle[0]
	elsif(pos == "pronoun")
		return @pronoun.shuffle[0]
	elsif(pos == "definite_article")
		return @definite_article.shuffle[0]
	elsif(pos == "indefinite_article")
		return @indefinite_article.shuffle[0]
	elsif(pos == "nominative")
		return @nominative.shuffle[0]
	elsif(@punctuation.include?(pos))
		return pos
	else
		puts "error"
	end
end

#and now they are filled up:
words_to_pos_array("words.txt")
