require "./pos"

def fix_words()
	double = ["d", "l", "m", "n", "t"]
	for i in 0..(@transitive_verb.length - 1)
		@transitive_verb[i] = @transitive_verb[i][0]
		verb = @transitive_verb[i].each_char.to_a
		if(double.include?(verb.last))
			@transitive_verb[i] = @transitive_verb[i] + ";" + @transitive_verb[i] + "s;" + "is " + @transitive_verb[i] + verb.last + "ing"
		else
			@transitive_verb[i] = @transitive_verb[i] + ";" + @transitive_verb[i] + "s;" + "is " + @transitive_verb[i] + "ing"
		end
	end
	add_e = ["z", "s", "t", "c"]
	for i in 0..(@noun.length - 1)
		noun = @noun[i].each_char.to_a
		if(add_e.include?(noun.last) or (add_e.include?(noun[noun.length-2]) and noun.last == "h"))
			@noun[i] = @noun[i] + ";" + @noun[i] + "es"
		elsif(noun.last == "y" and noun[noun.length-2] != "e")
			@noun[i] = @noun[i] + ";" + @noun[i].chop + "ies"
		else
			@noun[i] = @noun[i] + ";" + @noun[i] + "s"
		end
	end
end

def put_words_back(filename)
	File.open(filename, "w") do |file|
		@noun.each do |word|
			file.puts word + ":n"
		end
		@proper_noun.each do |word|
			file.puts word + ":N"
		end
		#@plural.each do |word|
		#	file.puts word + ":p"
		#end
		@noun_phrase.each do |word|
			file.puts word + ":h"
		end
		@verb.each do |word|
			file.puts word.join(";") + ":V"
		end
		@transitive_verb.each do |word|
			file.puts word + ":t"
		end
		@intransitive_verb.each do |word|
			file.puts word.join(";") + ":i"
		end
		@adjective.each do |word|
			file.puts word + ":A"
		end
		@adverb.each do |word|
			file.puts word + ":v"
		end
		@conjunction.each do |word|
			file.puts word + ":C"
		end
		@preposition.each do |word|
			file.puts word + ":P"
		end
		@interjection.each do |word|
			file.puts word + ":!"
		end
		@pronoun.each do |word|
			file.puts word + ":R"
		end
		@singular_article.each do |word|
			file.puts word + ":s"
		end
		@plural_article.each do |word|
			file.puts word + ":u"
		end
		#@nominitive.each do |word|
		#	file.puts word + ":o"
		#end
	end
end

fix_words()
put_words_back("words.txt")
