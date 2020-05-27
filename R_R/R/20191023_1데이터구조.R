#######################################################################
# 다른 데이터 타입을 저장하는 자료구조
# : List(1차원), data frame(2차원), 범주형 자료구조 -> factor

########################################################################
# 1. factor
# 범주형 데이터를 저장하기 위한 자료구조
# 범주형 데이터는 
# ex) 방의 크기가 "대","중","소" => level
# 일반적으로vector를 이용해서 factor를 만들어요

#6명의 혈액형 데이터를 vector에 저장하고 factor로 변형해보자

var1 = c("A","AB","O","A","B","B")
var1

factor_var1 = factor(var1)
factor_var1
#[1] A  AB O  A  B  B 
#Levels: A AB B O

nlevels(factor_var1)
#4, level의 개수

levels(factor_var1)
#"A" "AB" "B" "O"
###level의 데이터타입은 무조건 character?

var1 = c(1,2,3,4,5,5,3,2)
var1

factor_var1 = factor(var1)
factor_var1
levels(factor_var1)

is.factor(factor_var1)
#TRUE

# 남성과 여성의 성별데이터로 factor를 생성하고 빈도수를 구해보자

var1 = c("MAN","WOMAN","MAN","MAN","MAN","WOMAN")
var1

factor_gender = factor(var1)
factor_gender
#[1] MAN   WOMAN MAN   MAN   MAN   WOMAN
#Levels: MAN WOMAN

table(factor_gender)
#MAN WOMAN 
#4     2 

plot(factor_gender)   #그래프 등장!
################################################################################################
#2.List
# 1차원 선형구조
# 다른 데이터 타입이 들어올 수 있다
# 중첩 자료구조로 이용

#지금까지 했던 여러 자료구조들을 생성해서 List 안에 저장해보자

var_scalar = 100
var_scalar

var_vector = c(10,20,30)
var_vector

var_matrix = matrix(c(1:12),ncol=3,nrow=4,byrow=T)
var_matrix
#     [,1] [,2] [,3]
#[1,]    1    2    3
#[2,]    4    5    6
#[3,]    7    8    9
#[4,]   10   11   12

var_array = array(c(1:12),dim=c(2,2,3)) #2행2열3면
var_array
#sticky memo

var_df = data.frame(id=1:4,name=c("홍길동","최길동","이길동","김길동"),age=c(30,40,20,10))
var_df
#sticky memo

myList = list(var_scalar, var_vector, var_matrix, var_array, var_df)
myList
# 다른 자료구조를 저장할 수 있다 = 중첩 자료구조
myList[1] 
#[1] 100
myList[[1]] # key값을 이용하여 공간에 access하는 것.
#[1] 100
myList[2:3]
#[[1]] : key와 value로 저장되는 자료구조이고 데이터를 출력할 때 key값도 같이 출력






myList = list(name = c("홍길동","김길동"), age=c(20,30),address=c("서울","부산"))
#key가 name, value가 홍길동 김길동
#데이터 사이즈는 3, key값이 부여가 되어있는 상태
myList
#$name
#[1] "홍길동" "김길동"
#$age
#[1] 20 30
#$address
#[1] "서울" "부산"

myList[1]
#$name
#[1] "홍길동" "김길동"
myList["name"]
#$name
#[1] "홍길동" "김길동"
myList$name
#"홍길동" "김길동"
myList$name[2]
#[1] "김길동"


#잘 사용안하는 방법이지만 가능한 방법
myList[[1]]                                  #key값이 부여되어있으면 사용하는걸 권장!
#[1] "홍길동" "김길동"
myList[["name"]]                             # [] 공간에 access  [[]] key로 value에 access
#[1] "홍길동" "김길동" 



######################################################################################
#3. data frame
# matrix와 같은 2차원 형태의 자료구조
# 다른 데이터 타입 사용 가능
# column명을 이용가능
# data base의 table과 유사함


#vector를 이용해서 data frame을 만들어보자

no = c(1,2,3)
name = c("홍길동","김길동","최길동")
age = c(10,20,30)

df = data.frame(s_no = no, s_name=name, s_age=age)
#s_no,s_name,s_age가 column 명
df
#s_no s_name s_age
#1    1 홍길동    10
#2    2 김길동    20
#3    3 최길동    30
df[1]                                 #첫번째 열
df$s_name                             #list에서 $의 의미는 key, data frame에서 $는 column명을 지칭한다
#[1] 홍길동 김길동 최길동         
#Levels: 김길동 최길동 홍길동         #자동으로 범주로 잡혀서 character형태로 만드는 것이 좋다

#dataframe의 함수
str(df)                               #data frame의 구조를 볼 수 있다
#'data.frame':	3 obs. of  3 variables:
#$ s_no  : num  1 2 3
#$ s_name: Factor w/ 3 levels "김길동","최길동",..: 3 1 2
#$ s_age : num  10 20 30
summary(df)                           #data frame의 요약통계를 알 수 있다. 통계량을 알 수 있다
#s_no        s_name      s_age   
#Min.   :1.0   김길동:1   Min.   :10  
#1st Qu.:1.5   최길동:1   1st Qu.:15  
#Median :2.0   홍길동:1   Median :20  
#Mean   :2.0              Mean   :20  
#3rd Qu.:2.5              3rd Qu.:25  
#Max.   :3.0              Max.   :30


df=data.frame(x=c(1:5), y=seq(2,10,2),z=c("a","b","c","d","e"))
df
#df은 recycling이 안되기 때문에 각 열의 사이즈가 무조건 똑같아야함!

#연습문제
#주어진 data frame의 1,2번째 column에 대해서 각각 합계를 구하세요
apply(X=df[,c(1:2)],MARGIN=2,FUN=sum)                               #apply는 data frame에도 적용할 수 있다
apply(X=df[,-3],MARGIN=2,FUN=sum)
apply(X=df[c("x","y")],MARGIN=2,FUN=sum)   
#x  y 
#15 30 

# subset()
# data frame에서 조건에 맞는 행을 추출해서 독립적인 data frame 생성
df=data.frame(x=c(1:5), y=seq(2,10,2),z=c("a","b","c","d","e"))
df
subset(df,x>3)
#  x  y z
#4 4  8 d
#5 5 10 e
subset(df,x<3 & y>=4)
#  x y z
#2 2 4 b
subset(df, z == "c")



myMatrix=matrix(c(1:12),ncol=3,nrow=4,byrow=T)
myMatrix
#     [,1] [,2] [,3]
#[1,]    1    2    3
#[2,]    4    5    6
#[3,]    7    8    9
#[4,]   10   11   12
df_mat=data.frame(myMatrix)
df_mat
#  X1 X2 X3
#1  1  2  3
#2  4  5  6
#3  7  8  9
#4 10 11 12






