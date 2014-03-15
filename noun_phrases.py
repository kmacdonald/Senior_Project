from textblob import TextBlob
import sys

text = str(sys.argv)

blob = TextBlob(text)
print blob.noun_phrases
