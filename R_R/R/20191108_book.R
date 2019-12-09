
# R에서 Database에 연결해보자
# MySQL에 연결해서 데이터를 가져오자

# 1. MySQL DBMS를 기동 : mysqld
# cmd cd 주소창 mysqld

# 2. R에서 DBMS에 접근하려면 몇 개의 package가 필요할까
# Java 언어를 이용, Java가 설치되어 있어야한다
# JAVA_HOME 환경변수도 잡아줘야 한다

install.packages("rJava")
# R언어에서 Java언어를 사용하기 위한 package
install.packages("RJDBC")
# R언어에서 JDBC라는 기능을 이용하기 위한 package
# Java로 Database를 사용하기 위한 library
install.packages("DBI")
# 데이터베이스를 사용하기 위한 package

# 사용 => 연결 => 제어

library(rJava)
library(RJDBC)
library(DBI)

# 필요한 package와 로딩이 끝나고 driver가 필요하다
# Java언어가 Database에 접속하고 사용하기 위한 기능이 들어있는 library
# 사용하는 데이터베이스마다 설정방법이 다르다.
# MySQL Driver 설정을 해보자

# JDBC(설정, 파일위치)

# Java가 Database를 접속, 이용하기 위한 설정
drv = JDBC(driverClass = "com.mysql.jdbc.Driver",
           classPath="C:/R_R/mysql-connector-java-5.1.48-bin.jar")

# R언어에서 Database 연결
# dbConnect(드라이브, 라이브러리, 아이디, 패스워드)
conn <- dbConnect(drv,
                  "jdbc:mysql://localhost:3306/library",
                  "data", #MySQL id
                  "data") #MySQL pw

# Query 실행(SQL : 데이터베이스를 제어하기 위한 언어)
# sql = select(column을 가져온다)/ column이름/ from/ 테이블이름
sql = "select btitle from book"

# 데이터 프레임으로 저장하기 위해 쿼리를 가져온다(연결, column)
df <- dbGetQuery(conn, sql);
head(df)

library(dplyr)

df %>% filter(bprice > 55000) %>%
  select(btitle)


##################################################################
# R의 기본 & EDA

# ===> R 샤이니 : 웹 프레임웍 => python flask 로 대체

# ===> Python
# data type & data structure & 로직
# Numpy & Pandas를 이용한 EDA
# 통계 개념, Python에서 처리, R에서 처리
# 통계적 데이터 분석
# Tensorflow를 이용한 machine learning > AI
# Deep Learning(CNN) 
# 이거는 R에서는 어떻게 할건지









