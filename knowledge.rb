require "./pos.rb"

@knowledge = [["horse", ["brown", "fast"], ["stand", "run"]], ["pig", ["pink", "short"], ["eat", "play"]], ["cow", ["black", "white"], ["chew", "sleep"]]]

def retrieve_subject(subj)
	info = []
	@knowledge.each do |k|
		if(k[0] == noun_form(subj, 0) or k[0] == noun_form(subj, 1))
			info = k
		end
	end
	return info
end

def retrieve_adjective(subj)
	info = retrieve_subject(subj)
	adj = ""
	if(!info.empty?)
		adj = info[1].shuffle[0]
	end
	return adj
end

def retrieve_verb(subj)
	info = retrieve_subject(subj)
	vb = ""
	if(!info.empty?)
		vb = info[2].shuffle[0]
	end
	return vb
end
