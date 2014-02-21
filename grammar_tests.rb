#Need this in order to tell what part of speech each word is.
require "./pos.rb"

#I think these are pretty self-explanatory.
#The pre_tests all have to be true for the sentence to be completed.
#The post_tests are run on the completed sentences. They fix any issues and then return true.

def is_complete?(sentence)
	if(sentence.include?(".") or sentence.include?("?") or sentence.include?("!"))
		return true
	else
		return false
	end
end

def contains_verb?(sentence)
	arr = sentence.split(" ")
	if(arr.include?("verb") or arr.include?("transitive_verb") or arr.include?("intransitive_verb") or (arr.length == 2 and @interjection.include?(arr[0])))
		return true
	else
		return false
	end
end

def correct_parentheses?(sentence)
	if(sentence.include?(")") and !sentence.include?("("))
		sentence.gsub!(")", "")
	end
	return true
end

def no_incomplete_parentheses?(sentence)
	if(sentence.include?("(") and !sentence.include?(")"))
		return false
	else
		return true
	end
end

def proper_capitalization(sentence)
	sentence = sentence.capitalize
	sentence = sentence.split(" ")
	for i in 1..(sentence.length-1)
		if(@proper_noun.include?(sentence[i]))
			sentence[i].capitalize!
		else
			sentence[i].downcase!
		end
	end
	sentence = sentence.join(" ")
	return sentence
end

def proper_articles(sentence)
	sentence = sentence.split(" ")
	subject = []
	for i in 0..(sentence.length-1)
		if(@singular_article.include?(sentence[i]) or @plural_article.include?(sentence[i]))
			for j in i..(sentence.length-1)
				if(@noun.include?(sentence[j]) or @plural.include?(sentence[j]) or @noun_phrase.include?(sentence[j]) or @proper_noun.include?(sentence[j]))
					subject << sentence[j]
				end
			end
			subject = subject[0]
			if(@plural.include?(subject))
				sentence[i] = @plural_article.shuffle[0]
			else
				sentence[i] = @singular_article.shuffle[0]
			end
		end
	end
	sentence = sentence.join(" ")
	return sentence
end

def proper_punctuation_spacing(sentence)
	@punctuation.each do |punct|
		if(punct != "(")
			sentence.gsub!(" " + punct, punct)
		else
			sentence.gsub!(punct + " ", punct)
		end
	end
	return sentence
end

def proper_question(sentence)
	if(sentence.include?("?") and sentence.split(" ").length > 2)
		subject = []
		sentence.split(" ").each do |word|
			if(@noun.include?(word) or @plural.include?(word) or @noun_phrase.include?(word) or @proper_noun.include?(word))
				subject << word
			end
		end
		subject = subject[0]
		if(@plural.include?(subject))
			sentence = "Do " + sentence
		else
			sentence = "Does " + sentence
		end
	end
	return sentence
end

def pre_tests?(sentence)
	return (is_complete?(sentence) and contains_verb?(sentence) and correct_parentheses?(sentence))
end

def post_tests(sentence)
	sentence = proper_question(sentence)
	sentence = proper_articles(sentence)
	sentence = proper_punctuation_spacing(sentence)
	sentence = proper_capitalization(sentence)
	return sentence
end
