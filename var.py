import random

__all__ = ['user_info', 'ip', 'integer', 'alphabet', 'nagetive_number', 'special_text', 'decimal']
user_info = ['admin', 'P@ssw0rd']
ip = 'https://10.180.131.6'
integer = random.randint(1, 5)
alphabet = ['aa', 'bb', 'ccc', 'test', 't1', 'ddd'][random.randint(0, 5)]
nagetive_number = str(-random.randint(2, 100))
special_text = ['!@', '$$', '^%$', '*&'][random.randint(0, 3)]
decimal = ['0.1', '0.4', '0.8', '0.55'][random.randint(0, 3)]

# print(nagetive_number)
