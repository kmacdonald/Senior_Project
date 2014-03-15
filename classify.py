from textblob import TextBlob
import sys

text = str(sys.argv)
print text
blob = TextBlob(text)
print blob.tags

