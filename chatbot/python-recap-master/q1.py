'''
# 문제 1.
문자열을 입력받아 문자열의 첫 글자와 마지막 글자를 출력하는 프로그램을 작성하시오.
'''

str = input('문자를 입력하세요: ')

# 아래에 코드를 작성해 주세요.

str_list = list(str)
str_len = len(str_list)-1
print(str_list[0],str_list[str_len])
#########################################################
print('첫번째 글자는 : {}  입니다.'.format(str[0]))
print('두번째 글자는 : {}  입니다.'.format(str[-1]))