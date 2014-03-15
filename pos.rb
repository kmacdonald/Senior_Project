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
@article = []
@singular_article = []
@plural_article = []
@number = []
@helping_verb = []
@relative_adverb = []
@relative_pronoun = []
@singular_demonstrative = []
@plural_demonstrative = []
@quantifier = []
@coordinating_conjunction = []
@possessive = []
@punctuation = [";", "!", ",", ":", ".", "(", ")", "?"]

#sorts the words based on their part of speech; some go in multiple arrays
def words_to_pos_array(filename)
	corpus = File.new(filename, "r")
	while(line = corpus.gets)
		word = line.chomp.split(":")
		if(word[1] == "noun")
			@noun << word[0].split(";")
		end
		if(word[1] == "proper_noun")
			@proper_noun << word[0]
		end
		if(word[1] == "noun_phrase")
			@noun_phrase << word[0]
		end
		if(word[1] == "verb")
			@verb << word[0].split(";")
		end
		if(word[1] == "transitive_verb")
			@transitive_verb << word[0].split(";")
		end
		if(word[1] == "intransitive_verb")
			@intransitive_verb << word[0].split(";")
		end
		if(word[1] == "adjective")
			@adjective << word[0]
		end
		if(word[1] == "adverb")
			@adverb << word[0]
		end
		if(word[1] == "conjunction")
			@conjunction << word[0]
		end
		if(word[1] == "preposition")
			@preposition << word[0]
		end
		if(word[1] == "interjection")
			@interjection << word[0]
		end
		if(word[1] == "pronoun")
			@pronoun << word[0]
		end
		if(word[1] == "article")
			@article << word[0]
		end
		if(word[1] == "singular_article")
			@singular_article << word[0]
		end
		if(word[1] == "plural_article")
			@plural_article << word[0]
		end
		if(word[1] == "number")
			@number << word[0]
		end
		if(word[1] == "helping_verb")
			@helping_verb << word[0].split(";")
		end
		if(word[1] == "relative_adverb")
			@relative_adverb << word[0]
		end
		if(word[1] == "relative_pronoun")
			@relative_pronoun << word[0]
		end
		if(word[1] == "singular_demonstrative")
			@singular_demonstrative << word[0]
		end
		if(word[1] == "plural_demonstrative")
			@plural_demonstrative << word[0]
		end
		if(word[1] == "quantifier")
			@quantifier << word[0]
		end
		if(word[1] == "coordinating_conjunction")
			@coordinating_conjunction << word[0]
		end
		if(word[1] == "possessive")
			@possessive << word[0]
		end
	end
end

def find_pos(word)
	pos = []
	@noun.each do |w|
		if(w.include?(word))
			pos << "noun"
		end
	end
	if(@proper_noun.include?(word))
		pos << "proper_noun"
	end
	if(@noun_phrase.include?(word))
		pos << "noun_phrase"
	end
	@verb.each do |w|
		if(w.include?(word))
			pos << "verb"
		end
	end
	@transitive_verb.each do |w|
		if(w.include?(word))
			pos << "transitive_verb"
		end
	end
	@intransitive_verb.each do |w|
		if(w.include?(word))
			pos << "intransitive_verb"
		end
	end
	if(@adjective.include?(word))
		pos << "adjective"
	end
	if(@adverb.include?(word))
		pos << "adverb"
	end
	if(@conjunction.include?(word))
		pos << "conjunction"
	end
	if(@preposition.include?(word))
		pos << "preposition"
	end
	if(@interjection.include?(word))
		pos << "interjection"
	end
	if(@pronoun.include?(word))
		pos << "pronoun"
	end
	if(@article.include?(word))
		pos << "article"
	end
	if(@singular_article.include?(word))
		pos << "singular_article"
	end
	if(@plural_article.include?(word))
		pos << "plural_article"
	end
	if(@number.include?(word))
		pos << "number"
	end
	@helping_verb.each do |w|
		if(w.include?(word))
			pos << "helping_verb"
		end
	end
	if(@relative_adverb.include?(word))
		pos << "relative_adverb"
	end
	if(@relative_pronoun.include?(word))
		pos << "relative_pronoun"
	end
	if(@singular_demonstrative.include?(word))
		pos << "singular_demonstrative"
	end
	if(@plural_demonstrative.include?(word))
		pos << "plural_demonstrative"
	end
	if(@quantifier.include?(word))
		pos << "quantifier"
	end
	if(@coordinating_conjunction.include?(word))
		pos << "coordinating_conjunction"
	end
	if(@possessive.include?(word))
		pos << "possessive"
	end
	return pos
end
#and now they are filled up:
words_to_pos_array("words.txt")
