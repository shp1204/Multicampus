# 1.
# R은 통계계산을 위한 프로그래밍 언어이자 데이터분석 소프트웨어이다

# R로 할 수 있는 일 : 기초 통계분석, 머신러닝 모델링, 텍스트 마이닝
# 일반적인 프로그램(웹프로그램, APP 등)

# 2. R의 장점
# 무료(open source)
# 생태계가 잘 구성되어있다(굉장히 많은 패키지)
# 프로그래밍 방식으로 데이터 분석이 가능하다

# 3. R을 이용해서 빅테이터 분석
# 빅데이터 정의(3V)
# volume : 데이터의 크기가 굉장히 크다
# velocity : 데이터의 발생 속도가 굉장히 빠르다
# variety : 데이터의 종류가 굉장히 다양하다

# 4. Rstudio를 설치해서 실습 진행

# 5. 기본적으로 알아둘 것
# 주석은 #, 문장의 끝은 ;
# R은 대소문자 구별한다

# 6. Operator(연산자)
# 대부분의 연산자는 다른 프로그래밍 언어와 동일하게 사용되는데
# 몫을 구하는 연산자 : %/%
# 나머지를 구하는 연산자 : %%
# 논리 연산 기호는 다른 언어와 동일하지만 논리값은 다르게 표현된다(TRUE,FALSE)
# 할당 연산자 : -> , <- , = ( 100 -> var1 가능하다 )
# &,\,&&,\\
# &,&& 는 scalar 연산에서는 차이가 없지만 vector연산에서 차이가 있다
# 두개짜리는 vector의 맨 처음 1개만 & 연산을 한다

# 7. Data Type : numeric, character, logical, complex
# NA(결측치), NaN(수학적으로 불가능한 수치), NULL(값이 존재하지 않음), Inf(무한대)
# 데이터 타입을 변경할때(casting) 상위 데이터 타입으로 변경됨
# logical > numeric > complex > character

# 8. R에는 package가 존재한다
# 외부 코드모듈을 이용하면 더 쉽게 더 많은 기능 이용 가능
# 설치 : install.packages
# 로딩 : library, require

# 9. R의 작업공간(workspace)
# 어떻게 설정하고 사용하는지만 알아두자

# 10. Data Structure
# 자료구조 : 변수에 저장된 데이터의 메모리 구조를 지칭하는 용어
# class : 변수의 자료구조를 알아내기 위해 사용하는 함수
# 같은 데이터 타입 사용 : vector, matrix, array
# 다른 데이터 타입 사용 : list, data frame, factor

# 1) vector
# 선형자료구조, 같은 데이터 타입
# 첨자방식 이용 [], 1부터 시작
# c() : 개별요소를 이용해서 vector를 생성
# ":" : 수치형에만 적용가능, 1씩 증가 또는 감소
# seq() : ":"의 일반형
# rep() : vector를 반복해서 만들 수 있다
# length() : 길이를 알 수 있다
# names() : 이름을 설정하거나 알아낼 수 있다
# vector 연산방식 : recycling rule
# 집합연산 : union, intersect, setdiff

# 2) matrix
# 2차원형태의 자료구조, 같은 데이터 타입 이용
# 열 기준, ( 행이 증가하면서 matrix가 생성)
# 생성하는 방법, indexing하는 방식

# 3) array

# 4) list(1차원)
# 중첩자료구조를 만들 수 있다
# key와 value 쌍으로 이루어져 있다
# dict와 같은 구조, 순서 개념을 갖고 있다
# [[]] key, []value 형태로 사용된다
# list에서 key를 표현할 때 "$"를 사용한다

# 5) data frame
# list와 vector를 혼합한 자료구조
# 특정 column 명시 : $ 이용
# str() : data frame의 기본구조를 알 수 있다
# summary : data frame에 대한 기본 통계자료
# apply : data frame에 대해 특정 함수 호출
# subset : data frame의 부분집합을 구할 때 사용

# 11. 문자열처리
# stringr package를 이용해서 처리
# 정규표현식에 대한 내용도 있었다

# 12. 데이터 입출력
# 파일로부터 데이터를 읽어들이자
# txt(csv), xlsx, open api를 이용한 json
# open api사용하기 위한 여러가지 selector
# ajax처리에 대한 내용
# selenium을 이용한 crawling 처리

# 13. Crawling&Scraping
# web crawling(web spidering) : 규칙에 따라 특정 웹 페이지를 반복적으로 browsing하는 행위
# web scraping : 원하는 부분을 selector나 xpath를 이용해 데이터를 얻어올 수 있다

# 14. 데이터 조작
# class : 자료구조를 파악하기 위한 함수
# head : 데이터의 앞부분을 보기 위한 함수
# tail : 데이터의 뒷부분을 보기 위한 함수
# view : view창으로 데이터를 확인
# dim : data frame의 행과 열을 구하는 함수, 선형자료구조x
# nrow,ncol : 행의 개수, 열의 개수, 선형자료구조 사용x
# str
# summary
# ls : dataframe의 column을 vector로 출력

# 15. 시각화
#ggplot2 package를 이용해서 시각화를 많이 한다. 기본적인 그래프에 대해 알아보자
# 데이터를 x축과 y축에 점으로 표현하는 방식
# 연속데이터를 이용해서 두 변수의 관계를 표현하기 적합한 형태의 그래프는 => 산점도
# 일반적으로 집단간의 차이를 그래프로 표현하기에 적합한 형태의 그래프는 => 막대그래프
# 일반적으로 시계열데이터를 표현하기에 적합한 형태의 그래프는 => lineplot
# 데이터의 분포를 표현하기에 적합한 형태, 이상치를 쉽게 파악할 수 있다 => boxplot

## ggplot2를 이용해서 실제 그래프를 그려보자
# ggplot을 이용해서 x축과 y축 설정
# aes를 이용해서 축 설정
# 축을 설정한 후 실제 그래프를 그리는데 다른 함수를 이용해서 처리
# "+"기호를 이용해서 chaining처럼 사용

# 16. 기본통계함수
# 평균, 최대, 최소, 분산(var), 표준편차(sd), 사분위, median

# 17. NLP(Natural Language Process : 자연어처리)
# KoNLP를 이용해서 한글 형태소 분석처리를 해보았다
# KoNLP : R에서 한글 형태소를 분석할수 있는 유일한 pacakge
# 3가지 사전을 갖고있고 외부 package이므로 설치 후 사용해야한다
# JAVA기능을 이용하기 때문에 JDK설치

# 18. 결측치와 이상치 처리
# is.na() : NA를 파악하기 위해서 사용하는 함수
# 이상치 중에 극단치 : 존재할 수 있는 값이기는 하지만 정상 범주에서 많이 벗어나있는 데이터 
# boxplot을 이용하면 극단치를 쉽게 찾아낼 수 있다

###############################################################
# 수행평가 제출 방법
# 로튼 토마토, mpg data set EDA, 한국복지패널데이터
# 각 문제에 대한 결과화면 capture가 필요하다
# 코드도 포함

# capture+코드 => 하나의 파일 안에 세 개의 문제 전부 작성
# comment도 포함하자


