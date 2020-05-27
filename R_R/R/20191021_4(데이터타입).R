#######################################################
# R의 Data Type
# 
# R에는 Data Type이 크게 2가지가 존재(기본데이터/ 특수데이터)

# 1.데이터 타입
#  1) 숫자형(numeric) : 숫자로 되어있고 정수형,실수형을 의미
       100 #실수형 
       100L #정수형
#  2) 문자열(character) : 하나 혹은 둘 이상의 문자의 집합
       "홍길동"
       '최길동'
       '흥'
#  3) 논리형(logical) : TRUE(T), FALSE(F)
#  4) 복소수형(complex) : 4-3i

       
# 2.특수 데이터 타입
#  1) NULL : 객체가 존재하지 않음을 지칭하는 객체
       var1 = NULL
#  2) NA : Not Available 결측치 표현시 사용(데이터 전처리 과정에서 이상적인 값, 비어있는 값은 모두 NA처리)
#  3) NaN : Not Available Number, Not A Number
       sqrt(-3)
#  4) Inf : 양의 무한대
#  5) -Inf : 음의 무한대
       

       