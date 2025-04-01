extends Area2D


var text2 = " vi estas belega  homo "
var text3 = "         ne         "
var text4 = "aze aze aze aze aze aze aez" 

var text5= text3.split(" ")

func _ready() -> void:
	print(text5.size())
	print(text5)
	delete_empty_string(text5)
	print(text5.size())
	print(text5)


func analyzeText(text:String) -> int : # not int, but a dictionnary
	# format of output: Subject Adverb Verb Directive-Object 
	# the Subject and directive obect can be a noun, adjectives, or a noun and adjectives. 
	# for intransitive verbs, there's no directive object 
	
	# count the number of words to sort in a smarter way ? 
	# each world is either resolved or not ; they might be associated with another word ; they might have affixes
	# or maybe a structure for each type of words (type of adjectif; movable object or not)
	# for now, compound words aren't considered, because of the space 
	# TODO sort the lists by alpha order 
	# TODO Create a class here too ? I feel limited with dictionnaries 
	
	var noun ={"name":"", "types":[], "number":1} # type : on ground, grabbable,alive(animated) ; number : the number desired of instances of this noun
	var nouns = []
	var adjective = {"name":"","type":""} # type : color, size, others
	var verb = {"name":"", "tense":0, "transitive":true} # -1,0,1  for past present future
	var subject = {"name":"", "type":""} # pronoun, noun, adjective
	var direct_object = {"name":"", "type":""} # type : pronoun, noun, adjective, empty (intranstive verbs)
	var words = {"subject":subject,"adverb":"", "verb":verb,"direct_object":direct_object}
	
	var affix = "" 
	# finding the number 
	if is_instance_of(text, TYPE_INT):
		var number=true # change the structure 
	# finding the pronoun
	var pronouns = ["mi","vi","li","sxi","ri","ni","ili"] # I , you, he, she, they (neutral gender, single), we, they (plural)
	# finding the objects COD (they end with -n) ; give them the attribute "object" 
	
	# finding the verb : it ends with -i (if not a subject) for infinitive,-as,-os,is for present,future and past
	# -u for imperative ; -us for conditionnal 
	
	# TODO copy the code from book , 
	
	# transitive/action verbs 
	var action_verb = ["krei", "pusxi","kuri", "marsxi", "flugxi", "destrui", "kuiri", "mangxi","trinki","dormi","levi","frapi" ] # there's a -n in the sentence
	# intrasitive verbs 
	var state_verb = [ "esti","farti","okazi"] # there's no -n in the sentence  # TODO remove okazi from this list 
	# finding the nouns (they end with -o(n) ; add them the attribute accordingly (color, size, beauty etc..
	var floor_object = ["akvo", "vojo", ]
	# finding the adjectives -a(n)
	var color = ["verda","grisa", "negra"] # etc.. 
	var size = ["granda", "longa", "larga"]
	var other_adjectives = ["rapida", "stulta"]
	
	# finding the adverbs -e
	var adverbs = ["rapide","dulce","tute","afable"] # should i really seperate those from adjectives and nouns ? 
	# don't forget "mal-", like mallonga
	


	# check the interesting verbs to add (minimum verbs for everyday life and/or to speak in general
	# check the affixes , like "levigxi"
	#check the word "affix" in english and COD 
	# check destrui ; frapi 
	
	return 0

func delete_empty_string(text:PackedStringArray) -> void : 
	# delete every "" in a PackedStringArray
	for k in range(text.size()-1,-1,-1) : 
	#we start from the end of the sentence and iterate towards the index 0 ( k stops at the number before -1 )
	#It enables us to directly delete elements of the text without having problems of parsing 
		if text[k]=="":
			text.remove_at(k)
	
