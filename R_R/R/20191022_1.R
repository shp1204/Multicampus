# package 데이터분석에 꼭 필요한 것. 함수의 집합. 
# R은 처음 설치할 때 base package가 같이 설치된다.
# 추가적인 기능을 이용하기 위해서 외부 package를 찾아서 설치해야 한다
#그래프를 그리기 위해서 많이 사용하는 package는 ggplot2!
# package를 설치하자

install.packages("ggplot2")

# 설치된 package를 메모리에 load해야 사용할 수 있다.
# 둘 중 하나를 이용해서 로드

library(ggplot2)
require(ggplot2)

# 간단한 빈도를 나타내는 막대그래프를 그리기 위해 vector를 하나 만들자

var1 = c("a","b","c","a","b","a")
qplot(var1) #package 안의 함수를 이용해서 빈도그래프 그리기

#설치된 package를 삭제하려면(삭제할때는 무조건 "___")
remove.packages("ggplot2")

#package가 설치된 폴더 경로를 알아보자
.libPaths()

#package 설치 경로를 변경하고 싶을 때
.libPaths("C:/R_R/LIB")


.libPaths()


install.packages("ggplot2")

# 많은 package에 대한 정보, 사용법 등을 알면 알수록 R을 잘 사용할 수 있다.

# package를 설치하면 package에서 제공하는 함수를 이용할수 있다.

library(ggplot2) #로드해야 example 등의 함수 사용 가능

example(qplot)

# working directory
# working directory의 약자가 getwd()
getwd()
setwd("C:/R_R/Project")



















