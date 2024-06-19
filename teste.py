#%%
def reverse_words_order_and_swap_cases(sentence):
    new_sentence = []

    for i in sentence:
        if i.isupper():
            i.lower()
            new_sentence.append(i)
        elif i.islower:
            i.upper()
            new_sentence.append(i)
    return new_sentence      

if __name__ == '__main__' :
    sentence = 'Coding IS Awesome'
    print(reverse_words_order_and_swap_cases(sentence))



# %%

def reverse_words_order_and_swap_cases(sentence):
sentence = 'Coding IS Awesome'
sentence_list = sentence.split(' ')
new_sentence = []

new_sentence.append(''.join([char.lower() if char.isupper() else char.upper() for char in i]))

# Join the new_sentence list into a single string with spaces
result_sentence = ' '.join(new_sentence)
print(result_sentence)



# %%
