# 
#
# 데이터 정제
# 우리가 얻는 raw data는 항상 오류를 포함하고 있다. 
# 분석하기 전에 데이터 오류를 수정해야 한다. 

# 1. 결측치 처리(NA)
# 결측치는 누락된 값을 지칭, 비어있는 값을 지칭
# 결측치가 있으면 함수적용이 잘못될 수 있다.
# 분석자체가 잘못될 수 있다.

# 결측치를 찾자
# is.na() 함수 사용하여 결측치 확인 가능

df <- data.frame(id=c(1,2,NA,4,5,NA,7),
                 score = c(20,30,90,NA,60,NA,99))
View(df)

sum(is.na(df))  #계산을 통해 NA 개수 확인

table(is.na(df$id))   # 빈도구하는 함수를 이용해 결측치 확인

# 결측치를 제거해보자.
# => data frame이기 때문에 결측치가 들어가 있는 행 자체를 삭제

filter(df,
      is.na(id) == F & is.na(score) == F)

filter(df,
       !is.na(id),
       !is.na(score))

na.omit(df) #na를 찾아서 해당 행을 삭제

# 행을 지우는 행위는 크게 좋지 않다 => 결측치만 문제고 나머지는 사용할 필요가 있다.
# 행을 지우면 결측치 뿐만 아니라 정상데이터도 같이 삭제되기 때문에 분석시 문제가 될 수 있다.
df
mean(df$score) #NA와의 연산결과는 무조건 NA
mean(df$score, na.rm=T) #NA를 제외하고 연산하기

# 결측치가 포함된 행을 삭제하기에는 부담이 있다. 
# score안에 있는 na값을 다른값으로 대체해서 score의 평균을 구해보자
# score안의 NA를 NA를 제외한 평균으로 구해서 그 값으로 대체하자.

sub_mean <- mean(df$score,na.rm=T)

df$score = ifelse(is.na(df$score),
                  sub_mean,
                  df$score)
###############################################################################################
# 결측치 (NA)
# 이상치 및 존재할 수 없는 값이 포함된 경우
# 극단치 : 정상적인 범주에서 너무 벗어난 값이 들어온 경우 => 정상적인 범주에 대한 기준을 세워야한다. 
# 데이터 프레임을 생성할 때 stringAsFactors 안하면 character로 처리를 못하기 때문에 옵션 !!


df <- data.frame(id=c(1,2,NA,4,5,NA,7),
                 score = c(20,30,90,NA,60,NA,99),
                 gender = c("M","F","M","F","M","F","^^"),
                 stringsAsFactors = F)

# 이상치가 존재하면 결측치로 바꿔준다
# %IN%
df$gender = ifelse(df$gender%in%c("M","F"),
                  df$gender,
                  NA)

df

# 극단치 : 이상치 중에 값이 극단적으로 크거나 작은 값을 의미, 기준을 정하자 => 이미 기준이 있다!

# 극단치를 분류하는 기준은 IQR을 이용하자(interqualitile range)
# 4분위부터 알아보자

# 극단치를 알아보기 위한 sample 작성
data = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,22.1)

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



















