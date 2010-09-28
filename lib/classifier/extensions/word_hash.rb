# Author::    Lucas Carlson  (mailto:lucas@rufy.com)
# Copyright:: Copyright (c) 2005 Lucas Carlson
# License::   LGPL

# These are extensions to the String class to provide convenience 
# methods for the Classifier package.
class String
  
  # Removes common punctuation symbols, returning a new string. 
  # E.g.,
  #   "Hello (greeting's), with {braces} < >...?".without_punctuation
  #   => "Hello  greetings   with  braces         "
  def without_punctuation
    tr( ',?.!;:"@#$%^&*()_=+[]{}\|<>/`~', " " ) .tr( "'\-", "")
  end
  
  # Return a Hash of strings => ints. Each word in the string is stemmed,
  # interned, and indexes to its frequency in the document.  
	def word_hash
		word_hash_for_words(self.split)
	end

	# Return a word hash without extra punctuation or short symbols, just stemmed words
	def clean_word_hash
		word_hash_for_words gsub(/[^\w\s]/,"").split
	end
	
	private
	
  def word_hash_for_words(words)
    d = Hash.new(0)
    words.each do |word|
      word.downcase! #if word =~ /[\w]+/
      if word =~ /\A[a-z]+\z/ && !CORPUS_SKIP_WORDS.include?(word) && word.length > 2
        d[word.stem.intern] += 1
      end
    end
    d
  end

  CORPUS_SKIP_WORDS = [
      "again",
      "all",
      "along",
      "are",
      "also",
      "and",
      "but",
      "came",
      "can",
      "cant",
      "couldnt",
      "did",
      "didn",
      "didnt",
      "doesnt",
      "dont",
      "ever",
      "first",
      "from",
      "have",
      "her",
      "here",
      "him",
      "how",
      "into",
      "isnt",
      "itll",
      "just",
      "last",
      "least",
      "like",
      "most",
      "new",
      "not",
      "now",
      "should",
      "sinc",
      "some",
      "th",
      "than",
      "this",
      "that",
      "the",
      "their",
      "then",
      "those",
      "told",
      "too",
      "true",
      "try",
      "until",
      "url",
      "were",
      "when",
      "whether",
      "while",
      "with",
      "within",
      "yes",
      "you",
      "youll",
      ]
end