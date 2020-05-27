##################################################################################
# 변수 삭제하기
var1 = 2
vae2 = 5

rm(list=ls())      # ls() : 환경창에 있는 객체들
cat("\014")        # console clear 

####################################################################################

student_midterm=read.table(file.choose(),sep=",",fileEncoding = "UTF-8")
student_midterm

student_midterm=read.table(file.choose(),sep=",",fileEncoding = "UTF-8",header = T)
student_midterm

#####################################################################################

# 파일로부터 데이터를 읽어들일 때 일반 txt형식은 많이 사용되지 않는다
# 일반 txt 형식은 많이 사용되지 않는다

# 컴퓨터간에 데이터를 주고 받으려고 한다
# process간에 데이터 통신을 하기 위해서 특정 형식을 이용해 데이터를 주고 받는다


# 1. CSV( comma seperated value )
# comma 기호를 이용해서 데이터를 구분, 해당 문자열을 전달해서 데이터 통신을 해보자
# 예)  "홍길동, 20, 서울, 김길동, 30, 부산, 최길동, 50, 인천,..."
# 장점 : 간단하다, 구조가 간단하여 부가적인 데이터가 적다(상대적으로 크기가 작다)
# -> 많은 양의 데이터를 처리할 수 있다
# 단점 : 구조적 데이터를 표현하기에 적합하지 않다 = parsing 작업이 복잡하다
#         유지보수에 문제가 발생한다 


# 2. XML 방식
# tag를 이용해서 데이터를 표현하는 방식
# 예) <name>홍길동</name><age>20</age><address>서울</address>
# <phone>
#     <mobile>010-111-2222</mobiel>
#     <home>02-333-4444</home> 
# </phone>
# 장점 : 구조적 데이터를 표현하기에  적합, 사용하기에 편리, 데이터의 의미를 표현할 수 있다 , tag안에 새로운 tag 추가 가능
# 단점 : 부가적인 데이터가 너어무 크다.

# 3. JSON (Java Script Object Notation)
# 예) {name : "홍길동", age : 20, address : 서울,...}
# 장점 : 구조적 표현이 가능하면서 XML보다 크기가 작다
 

########################################################################################

# 어제는 read.table()  : sep가 있어야한다
# 오늘은 read.csv() : sep가 ","이기 때문에 생략가능, header = T가 기본

getwd()
df = read.csv(file.choose(),fileEncoding = "UTF-8")
df

# Excel 파일을 불러올 수 있다.
# 확장 pacakge를 이용해야 한다.
# R을 설치하면 base system이 설치된다고 표현한다( base package, recommended package )
# other package

# xlslx package를 설치하고 로딩한다
install.packages("xlsx")
library(xlsx)

# JAVA_HOME 환경변수 설정
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_231")

student_midterm = read.xlsx(file.choose(),sheetIndex = 1, encoding = "UTF-8")
student_midterm
class(summary(student_midterm))
#######################################################################################

# 처리된 결과를 file에 write 해보자!
# write.table() : data frame을 file에 저장

# cat() : 분석 결과 (vector)를 file에 저장
# capture.output() : 분석 결과(list,table)를 file에 저장

cat("처리된 결과는 :","\n","\n", file = "C:/R_R/Data/report.txt", append = T)
#\n은 한 칸 띄운다는 의미
#append=T는 원래 파일에 덧붙여서 추가한다는 의미! F면 새로 덮어씌워서 기존 데이터가 날라감
write.table(student_midterm,file= "C:/R_R/Data/report.txt",row.names = F, quote = F, append = T)
capture.output(summary(student_midterm),file = "C:/R_R/Data/report.txt", append = T )
#row.names=F : 행 번호 샂게, quote : "" 삭제

#write.xlsx()
df = data.frame(x=c(1:5),y=seq(1,10,2), z=c("a","b","c","d","e"),stringsAsFactors=F)
df
#stringsAsFactors = F 데이터가 범주형이 아닌 문자형

write.xlsx(df, "C:/R_R/Data/report.xlsx")

#################################################################################################
















