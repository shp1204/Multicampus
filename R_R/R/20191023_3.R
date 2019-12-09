###############################################################################
# 데이터 입출력
# 키보드로부터 데이터를 받을 수 있다.
# scan() 함수를 이용해서 숫자데이터를 받을 수 있다

myNum = scan()

#1: 1
#2: 2
#3: 3
#4: 
#  Read 3 items
myNum


# scan()을 이용해서 문자열도 입력받을 수 있다
var1 = scan(what=character())
#1: 이것은
#2: 소리없는
#3: 아우성
#4: 
#  Read 3 items
var1
# 결과 :  "이것은"   "소리없는" "아우성" 


#edit() 함수도 이용할 수 있다
var1 = data.frame()
df=edit(var1)                                       #새 창이 뜬다, 편하게 데이터 입력 가능
df

##############################################################################

# 파일로부터 데이터를 받을 수 있다.
# text 파일에 ","로 구분된 데이터들을 읽어들여보자

getwd()
setwd("C:/R_R/Data")

getwd()
setwd(str_c(getwd(),"/iii"))


student_midterm = read.table(file="123.txt",sep=",",fileEncoding = "UTF-8")

student_midterm = read.table(file.choose(),sep=",",fileEncoding = "UTF-8")
student_midterm

#  V1       V2 V3 V4  V5
#1  1   홍길동 20 30  50
#2  2   김길동 60 30  20
#3  3 신사임당 67 89  30
#4  4   이순신 10 10 100

student_midterm = read.table(file.choose(),sep=",",fileEncoding = "UTF-8",header = T)
student_midterm
#  X0     이름 국어 영어 수학
#1  1   홍길동   20   30   50
#2  2   김길동   60   30   20
#3  3 신사임당   67   89   30
#4  4   이순신   10   10  100










