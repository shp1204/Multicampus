############################################################################################
# 데이터 조작( plyr, dplyr, reshape2 등)
# 데이터 분석 업무에서 raw data를 얻은 다음 머신러닝 모델링을 위해서 또는 시각화를 위해서
# 이 raw data를 적절한 형태로 변형
# 데이터 변환, 필터링, 전처리 작업이 필요하다

# 이런 작업(데이터 조작)에 특화된 package들이 존재한다.
# plyr => pliers + R (플라이알)
#      : 패키지를 구현한 언어 R, 처리속도가 느리다, 데이터량이 많아지면 속도가 많이 늦어짐 
# dplyr => data frame + Pliers + R (디플라이알)
# vector나 data frame에 적용할 수 있는 기본 함수

# 실습할 데이터가 필요하다
# iris(아이리스)는 내장되어있다

iris
View(iris)
# iris : 붓꽃의 종류와 크기에 대해 측정한 데이터
# 통계학자 피셔라는 사람이 측정해서 제공한 데이터
# 컬럼 설명을 보자
ls(iris)
# Species : 종(3가지)
# Sepal.Length : 꽃받침의 길이
# Sepal.width : 꽃받침의 너비
# Petal.Length : 꽃잎의 길이
# Petal.Width : 꽃잎의 너비

#기본함수
# 1. head() : 데이터 셋의 앞에서부터 6개의 데이터를 추출한다. 
#             데이터 프레임이 아닌경우에도 적용된다.
head(iris,n=1) # head는 n의 기본값이 6으로 설정되어있다.

# 2. tail() :  데이터 셋의 뒤에서부터 6개의 데이터를 추출한다. 
#             데이터 프레임이 아닌경우에도 적용된다.
tail(iris,n=3)

# 3. View() : view창에 데이터를 출력,
# 필터 기능을 이용하면 데이터의 분포를 그래프로 볼 수 있다
View(iris)
# 4. dim() : 몇 차원인가, 각 차원의 개수는 몇개인가
dim(iris)
# 결과 : 150행 5열
# 선형자료구조(vector, list)에서는 결과가 NULL이된다. => 2차원 이상에서만 사용
var1 = c(1,2,3,4,5)
dim(var1)
# 5. nrow() : data frame의 행의 개수( 행, row, 측정치, observation )
nrow(iris)
# 6. ncol() :  data frame의 열의 개수( 열, column, 변수 )
ncol(iris)
# 7. str() : data frame에 대한 일반적인 정보를 추출
str(iris)
# 8. summary() : data frame의 요약 통계량을 보여준다
summary(iris)
# Min, Max, 사분위, 평균(mean), 중간값(median)
# 9. ls() : data frame의 column 명을 vector로 추출한다(정렬 : 오름차순)
ls(iris)
# 10. rev() : column 순서를 역순으로만든다
rev(iris)
# 11. length() : 길이를 구하는 함수,
# data frame에 length를 구하면 column의 개수를 알려준다
# matrix에 length를 구하면 요소의 개수를 알려준다
length(iris) # 결과 : 5

var1 = matrix(1:12, ncol=3)
var1

length(var1)

#######################################################################################3
















