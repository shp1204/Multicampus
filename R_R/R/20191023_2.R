############################################################################
# 문자열 처리에 대해서 알아보자
# 빅데이터 : 많은 양의 데이터( 3v : 3가지 속성을 만족해야 빅데이터라고 부른다)
# volume : 많은 양의 데이터 (TB이상)
# velocity : 데이터 생성 속도
# variety : 다양성 (정형적x, 소리,이미지 등)

#일반적으로 빅데이터 처리는 문자열 처리를 동반하는 경우가 많다
#문자열 처리는 stringr package를 이용하면 쉽고 편하게 할 수 있다

install.packages("stringr")
library(stringr)

var1 = "Honggd1234Leess9032YOU25최길동2009"

# 1. 문자열의 길이 구하기
str_length(var1)
# 결과 : 31
# R은 한글 한글자을 1개로 인식한다 

# 2. 찾는 문자열의 시작과 끝을 알려준다
str_locate(var1,"9032")
#     start end
#[1,]    16  19
class(str_locate(var1,"9032"))                  # data structure를 확인할 때 : class (data type : mode)
#"matrix"

# 3. 부분문자열을 구해보자
str_sub(var1,3,8)                               # 둘 다 inclusive , 시작인 3과 8 모두 포함한다

# 4. 대소문자 변경
str_to_lower(var1)                              # 모두 소문자로
str_to_upper(var1)                              # 모두 대문자로

# 5. 문자열 교체
str_replace(var1, "Hong", "Kim")                # 처음에 찾은 하나만 변경
var1 = "Honggd1234Hongss9032YOU25최길동2009"    # 문자열에서 전부 찾아서 변경
str_replace_all(var1, "Hong", "Kim")

# 6. 문자열 결합
var2 = "홍"
var3 = "길동"

str_c(var2,var3)                                #문자열 결합

# 7. 문자열 분할
var1 = "Honggd1234,Leess9032,YOU25,최길동2009"
str_split(var1,",")
# [[1]]
# [1] "Honggd1234" "Leess9032"  "YOU25"      "최길동2009"
# list 형태로 return된다

# 8. separator를 이용한 문자열 결합
#각 원소에 대한 문자열을 결합하고 싶을 때는 paste사용
var1 = c("홍길동","김길동","최길동")
str_c(var1)
# 결과 : "홍길동" "김길동" "최길동"
paste(var1,collapse = "-")
# 결과 : 홍길동-김길동-최길동"
paste(var1,collapse = "")
# 결과 : "홍길동김길동최길동"

##############################################################################

# 문자열 처리를 쉽고 편하게 하기 위해서는 정규표현식 (regular expression) 사용

var1 = "Honggd1234,Leess9032,YOU25,최길동2009"


# 조건에 부합되는 문자열을 추출 : str_extract_all #결과는 list형태
# [] 대문자 
str_extract_all(var1, "[a-z]")                 #a에서 z 모두 추출
# 결과 : [[1]]
# [1] "o" "n" "g" "g" "d" "e" "e" "s" "s"
str_extract_all(var1, "[a-z]{4}")              #a에서 z중 4개의 연속된 글자찾기          
# 결과 : [[1]]
# [1] "ongg" "eess"                            
str_extract_all(var1, "[a-z]{2,}")             #2개 이상
# 결과: [[1]]
# [1] "onggd" "eess" 
str_extract_all(var1, "[a-z]{2,3}")            #2개 이상 3개 이하
# 결과 : [[1]]
# [1] "ong" "gd"  "ees"

# 한글만 추출해보자
str_extract_all(var1, "[가-힣]")               #유니코드에서 한글은 가-힣
# 결과 : [[1]]
# [1] "최" "길" "동"
str_extract_all(var1, "[가-힣]{2,}") 
# 결과 : [[1]]
# [1] "최길동"

#숫자문자를 추출해보자
str_extract_all(var1, "[0-9]{2,}") 
# 결과 : [[1]]
#[1] "1234" "9032" "25"   "2009"

#한글을 제외한 나머지 문자들 추출해보자
str_extract_all(var1, "[^가-힣]{5,}")           # ^의 의미는 not의 의미 # 한글아닌거찾기
# 결과 : [[1]]
# [1] "Honggd1234,Leess9032,YOU25,"


#주민등록 검사 해보기
myId = "801112-1210419"

str_extract_all(myId,"[0-9]{6}-[1234][0-9]{6}")
# 결과 : [[1]]
# [1] "801112-1210419"




















