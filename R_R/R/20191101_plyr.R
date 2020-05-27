#######################################################################################3
#plyr package => dplyr 개량형 package
install.packages("plyr")
require(plyr) #library(plyr)

# 1. key값을 이용해서 두 개의 data frame을 병합하자( 세로방향, 열방향으로 결합 )


# data frame을 만들어보자
x = data.frame(id=c(1,2,3,4,5),
               height=c(150,190,170,188,167))
y = data.frame(id=c(1,2,3,6),
               weight=c(50,100,80,78))

join(x,y,by="id",type="inner")
# x와 y 데이터를 결합한다, id라는 키값을 이용해서, type은 inner로

# key를 1개 이용해서 결합하는걸 해보았ㄷㅏ !



# key를 2개 이상 이용해서 결합하려고하면?
x = data.frame(id=c(1,2,3,4,5),
               gender=c("M","F","M","F","M"),
               height=c(150,190,170,188,167))
y = data.frame(id=c(1,2,3,6),
               gender=c("F","F","M","F"),
               weight=c(50,100,80,78))

join(x,y,by=c("id","gender"),type="inner")
join(x,y,by=c("id","gender"),type="left")
join(x,y,by=c("id","gender"),type="right")
join(x,y,by=c("id","gender"),type="full")

#dplyr에서는 join() => left_join(),right_join, ,,, 함수 자체로 구별됨




# 2. 범주형 변수를 이용해서 그룹별 통계량 구하기
str(iris)
# $를 이용하여 data frame의 column을 명시한다
unique(iris$Species)
# unique : iris의 species column에 어떤 값이 있는가
# str, view는 데이터 수가 적을 때 이용, unique는 데이터량이 많을 때 값을 알아내기 위해 사용


# iris의 종별 꽃잎 길이의 평균을 구하세요
# tapply(대상 column, 범주형 column, 적용할 함수) => 범주형 column에 따라 정렬
# tapply는 한번에 한개의 통계만 구할 수 있다. 

tapply(iris$Petal.Length,
       iris$Species,
       FUN=mean)
# iris의 종별 꽃잎 길이의 평균과 표준편차를 구하세요
# 변수간의 얼마만큼의 차이들이 존재하는가
# 표준편차가 크면 양극화가 심하다.
# ddply() : 한번에 여러개의 통계치를 구할 수 있다

# ddply(data frame, column명, 기본통계량, 함수(), 함수())
df <-ddply(iris,
      .(Species),
      summarise,
      avg=mean(Petal.Length),
      sd=sd(Petal.Length))
df
#결과는 data frame형태로 나온다.


## plyr에서는 join()과 통계값을 구하는 함수(2개)만 알아두자!
# dplyr을 많이 사용하면서 plyr는 많이 사용하지 않는다


################################################################################################











