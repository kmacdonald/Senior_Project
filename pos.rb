#these arrays can be accessed by other files
@noun = []
@proper_noun = []
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
		if(word[1] == "Noun")
			@noun << word[0].split(";")
		end
		if(word[1] == "Proper_Noun")
			@proper_noun << word[0]
		end
		if(word[1] == "Noun_Phrase")
			@noun_phrase << word[0]
		end
		if(word[1] == "Verb")
			@verb << word[0].split(";")
		end
		if(word[1] == "Transitive_Verb")
			@transitive_verb << word[0].split(";")
		end
		if(word[1] == "Intransitive_Verb")
			@intransitive_verb << word[0].split(";")
		end
		if(word[1] == "Adjective")
			@adjective << word[0]
		end
		if(word[1] == "Adverb")
			@adverb << word[0]
		end
		if(word[1] == "Conjunction")
			@conjunction << word[0]
		end
		if(word[1] == "Preposition")
			@preposition << word[0]
		end
		if(word[1] == "Interjection")
			@interjection << word[0]
		end
		if(word[1] == "Pronoun")
			@pronoun << word[0]
		end
		if(word[1] == "Article")
			@article << word[0]
		end
		if(word[1] == "Singular_Article")
			@singular_article << word[0]
		end
		if(word[1] == "Plural_Article")
			@plural_article << word[0]
		end
		if(word[1] == "Number")
			@number << word[0]
		end
		if(word[1] == "Helping_Verb")
			@helping_verb << word[0].split(";")
		end
		if(word[1] == "Relative_Adverb")
			@relative_adverb << word[0]
		end
		if(word[1] == "Relative_Pronoun")
			@relative_pronoun << word[0]
		end
		if(word[1] == "Singular_Demonstrative")
			@singular_demonstrative << word[0]
		end
		if(word[1] == "Plural_Demonstrative")
			@plural_demonstrative << word[0]
		end
		if(word[1] == "Quantifier")
			@quantifier << word[0]
		end
		if(word[1] == "Coordinating_Conjunction")
			@coordinating_conjunction << word[0]
		end
		if(word[1] == "Possessive")
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

def noun_form(word, num)
	@noun.each do |n|
		if(n.include?(word))
			word = n[num]
		end
	end
	return word
end

def digits_to_words(digits)
  zero = "zero."
  return zero unless digits.is_a? Integer
  return zero unless digits > 0
  chunks = []
  while digits/1000 > 0
    chunks.unshift(digits % 1000)
    digits /= 1000
  end
  chunks.unshift(digits) if digits > 0
  ones    = %w(one two three four five six seven eight nine)
  teens   = %w(eleven twelve thirteen fourteen fifteen sixteen seventeen 
               eighteen nineteen)
  tens    = %w(ten twenty thirty forty fifty sixty seventy eighty ninety)
  rest = %w(thousand million billion trillion quadrillion quintillion)
  words = []
  while chunks.length > 0
    trio = chunks.first
    while trio > 0
      if trio/100 > 0
        words << "#{ ones[trio/100 - 1] } hundred"
        trio -= (trio/100) * 100
      elsif trio/10 > 0
        if trio/10 == 1
            words << "#{ teens[trio % 10 - 1] }"
            trio = 0
        else
            words << "#{ tens[trio/10 - 1] }"
            trio -= (trio/10) * 10
        end
      else
        words << "#{ ones[trio - 1 ] }"
        trio = 0
      end
    end
    if chunks.length > 1
      words << "#{ rest[chunks.length - 2] },"
    end
    chunks.shift
  end
  words.join(" ")
end

def verb_form(word, num)
	@verb.each do |v|
		if(v.include?(word))
			word = v[num]
		end
	end
	@transitive_verb.each do |v|
		if(v.include?(word))
			word = v[num]
		end
	end
	@intransitive_verb.each do |v|
		if(v.include?(word))
			word = v[num]
		end
	end
	return word
end

#and now they are filled up:
words_to_pos_array("words.txt")
