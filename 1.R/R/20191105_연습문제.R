# data : excel 파일(exec1105.xlsx)

# 만약 결측값이 존재하면 결측값은 결측값을 제외한 
# 해당 과목의 평균을 이용합니다.

# 만약 극단치가 존재하면 하위 극단치는 극단치값을 제외한
# 해당 과목의 1사분위 값을 이용하고 상위 극단치는
# 해당 과목의 3사분위 값을 이용합니다.

rm(list=ls()) 
library(MASS)
library(dplyr)
library(reshape2)
library(xlsx)
library(ggplot2)

# file 이름 : exec1105
score <- read.xlsx(file.choose(),sheetIndex = 1,header=F, encoding = "UTF-8")
name <- read.xlsx(file.choose(),sheetIndex = 2,header=F, encoding = "UTF-8")

View(score)
View(name)
View(df)

df<-score
df<-dplyr::rename(score,
           key=X1,
           subject=X2,
           score=X3)
name <-dplyr::rename(name,
              key=X1,
              name=X2,
              sex=X3)


## 데이터 reshape하기
df <- dcast(df,
              formula = key ~ subject,
              df.var = "score")
df<- left_join(df,name,by="key")


mean_all <- c(mean(df$eng,na.rm=T),
              mean(df$kor,na.rm=T),
              mean(df$math,na.rm=T))
mean_all

D <- summary(df)
D

for(key in seq(1:length(df$key))){
  np.ix[key,]
    
}




#na가 있는 column열번호를 찾아서 means_all의 열번호 값으로 대체한다



# 극단치를 알아보기 위한 sample 작성
data = df
data
# 기본 통계값을 이용해서 사분위 값을 알아보자
summary(data)

lower_data = c(1:8)
upper_data = c(8,9,10,11,12,13,14,22.1)

# IQR : 데이터 중간 위쪽의 mid point - 
#       데이터 중간 아래쪽의 mid point - 

iqr_value <- median(upper_data) - median(lower_data)
# = 11.5 - 4.5 = 7
# 극단치를 결정하는 기준값 : IQR*1.5
deter_value = iqr_value*1.5

# 3사분위값 + 기준값 을 넘어가면 극단치이다.
# 11.5 + deter_value = 22  

# => 극단치로 간주하지 않는다.

# 계산을 통해서 극단치를 판단하는 방법 

# 그래프를 이용하면 극단치를 눈으로 확인할 수 있다.
boxplot(data)$stats
boxplot(data)


























# 1. 전체 평균이 가장 높은 사람은 누구이며 평균값은 얼마인가요?
#김연아 81.11111

# 2. 남자와 여자의 전체 평균은 각각 얼마인가요?
# 남자 40.7 여자 54.6

# 3. 수학성적이 전체 수학 성적 평균보다 높은 남성은 누구이며
#    수학성적은 얼마인가요?
# 이순신 68 강감찬 78.66667