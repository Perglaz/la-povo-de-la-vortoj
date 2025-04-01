extends Node2D
# TODO reread this text 
# the purpose is to add or remove text, and swipe between pages
# it might randomly sort the words each time we open it
# it will use words in bold, italic and others 
# it needs another file to find the learned words (vs the all the existing words in the game)
# the left page should be in esperanto 
# the right page should be in french, but not the translation of the left page
# we can write to search for a word (through the whole book?)
# should I sort according to the type of words ? 
# not all words should be available, or at least not easily, except if it's a typing search 
# should i slightly delay the display of the french page ? 
# In the future the french part might be more sophisticated (being definitions instead of translations, and maybe images and gifs)

# don't forget to separate recent learned words to aquired words 

@onready var text_right : RichTextLabel = $PageRight/TextRight # the esperanto text on the left page
@onready var text_left : RichTextLabel = $PageLeft/TextLeft # the french text on the right page

# variables to order the words randomly on the page
var text_ordered_right: Array[String]
var text_ordered_left : Array[String]

# Variables for tests 

var action_verbs: Array[String] = ["krei", "pusxi","kuri", "marsxi", "flugxi", "destrui", "kuiri", "mangxi","trinki","dormi","levi","frapi" ] # there's a -n in the sentence
var action_verbs_fr: Array[String] = ["créer","pousser","courir","marcher","voler (ciel)", "détruire", "cuisiner", "manger", "boire","dormir","lever","dormir","frapper"]

# intrasitive verbs 
var state_verbs: Array[String] = [ "esti","farti","okazi"] # there's no -n in the sentence 
var state_verbs_fr : Array[String]= ["être","aller bien", "se passer"]
# finding the nouns (they end with -o(n) ; add them the attribute accordingly (color, size, beauty etc..
var floor_objects: Array[String] = ["akvo", "vojo", ]
var floor_objects_fr : Array[String]= ["eau","chemin"]

var other_objects: Array[String] = ["pomo","botelo", "homo", "besto"]
var other_objects_fr: Array[String] = ["pomme","bouteille","humain", "animal"]
# finding the adjectives -a(n)
var colors: Array[String] = ["verda","grisa", "negra"] # etc.. 
var colors_fr: Array[String] = ["vert","gris","noir"]
var sizes : Array[String]= ["granda", "longa", "larga"]
var sizes_fr: Array[String] = ["grand", "long", "large"]
var other_adjectives : Array[String]= ["rapida", "stulta"]
var other_adjectives_fr: Array[String] = ["rapide","bête"] 
# finding the adverbs -e
var adverbs: Array[String] = ["rapide","dulce","tute","afable"]
var adverbs_fr : Array[String] = ["rapidement","doux", "totalement", "gentillement"]

var pronouns : Array[String] = ["mi","vi","li","sxi","ri", "gxi","ni","ili"]
var pronouns_fr : Array[String] = ["je","tu/vous","il", "elle", "iel","il/elle", "nous","ils/elles" ]

func _ready() -> void:
	# displays randomly recents words on both pages 
	# TODO?  later, there might be a classification 

	change_displayed_text()	
	# TODO ? create a file which contains the words ? 
	pass

func _process(delta: float) -> void:
	# check for typing ? Swap pages 
	# illuminates words ? 
	pass 

func change_displayed_text() -> void:
	# chooses the words to display 
	# here we display 2 verbs 2 nouns 3 adjectives  1 adverb, 1 subject
	
	# we erase the texts of the 2 previous pages
	text_left.text ="" 
	text_right.text ="" 
	
	# 2 verbs 
	choose_word(action_verbs,action_verbs_fr)
	choose_word(state_verbs,state_verbs_fr)
	# 2 nouns
	choose_word(floor_objects,floor_objects_fr)
	choose_word(other_objects,other_objects_fr)
	# 3 adjectives 
	choose_word(colors,colors_fr)
	choose_word(sizes,sizes_fr)
	choose_word(other_adjectives,other_adjectives_fr)
	# 1 adverb 
	choose_word(adverbs,adverbs_fr)
	# 1 subject
	choose_word(pronouns,pronouns_fr) # TODO ?? I'll need a more sophisticated way to translate them

	# we shuffle the words so that they're not displayed in the same order each time we open the book	
	text_ordered_left.shuffle()
	text_ordered_right.shuffle()
	
	# we add the randomly organized words to both pages
	for k in range(len(text_ordered_left)):
		text_left.append_text(text_ordered_left[k]+"\n")
		text_right.append_text(text_ordered_right[k]+"\n")

	
	
func choose_word (list:Array[String],list_fr:Array[String]) -> void : 
	# this function randomly chooses a word and its translation and appends it to text_ordered_left and text_ordered_right 

	var rand = randi_range(0,len(list)-1)
	text_ordered_left.append(list[rand])
	text_ordered_right.append(list_fr[rand])
	
func classify(word : String) -> void: 
	# changes the state of a word  : aquired, learning in process ; maybe with a grade scale if needed ? 
	pass
	
	
