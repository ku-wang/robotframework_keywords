import random

__all__ = ['scar', 'list_va', 'integer', 'alphabet', 'nagetive_number', 'special_text', 'decimal']
scar = 'hello'
list_va = ['aa', 'bb', 'cc']
integer = random.randint(1, 5)
alphabet = ['aa', 'bb', 'ccc', 'test', 't1', 'ddd'][random.randint(0, 5)]
nagetive_number = str(-random.randint(2, 100))
special_text = ['!@', '$$', '^%$', '*&'][random.randint(0, 3)]
decimal = ['0.1', '0.4', '0.8', '0.55'][random.randint(0, 3)]

print(nagetive_number)
