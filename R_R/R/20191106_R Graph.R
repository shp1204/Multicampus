# 숫자나 문자로 표현하는 것 보다 그림(그래프)으로 표현하면 변수의 관계, 데이터 경향을 더 쉽게 파악할 수 있다.

# 해들리 위컴
# reshape2 package
# dplyr package
# ggplot2 package
# R에서 가장 많이 사용된다


# mpg data set을 사용하자


### 산점도(scatter) - 변수간의 관계를, 데이터 성향을 파악하기 위해서 사용한다

# ggplot2는 3단계로 그래프를 그린다
# 1. 축을 정하자 (배경을 설정)
# 2. 그래프를 추가한다
# 3. 축 범위, 배경 설정을 한다

library(dplyr)
library(ggplot2)
df <- as.data.frame(mpg)

# 배경 설정
# data 설정 : 그래프를 그리는데 필요한 데이터
# aes(x=, y=) : 축 설정시 사용하는 속성

# 배기량에 따른 고속도로 연비
ggplot(data=df,
       aes(x=displ,
           y=hwy))
# 우리가 원하는 그래프를 그릴 수 있다.
# 산점도를 그리는 함수 : geom_point
# ddplyr에서 %>% 의 기호대신 + 기호가 사용된다

ggplot(data=df,
       aes(x=displ,
           y=hwy)) + 
  geom_point()

# 설정을 추가할 수 있다.
# 데이터의 범위 중 일부분만 볼 수 있다.
# xlim : x축의 범위 제한
# ylim : y축의 범위 제한
# size : 점의 크기변화
# color : 색 변화
# geom_point(size=, color="")
ggplot(data=df,
       aes(x=displ,
           y=hwy)) + 
  geom_point(size=3,color ="blue") +
  xlim(3,5)+
  ylim(20,30)

# plot.new() : 화면의 그래프를 모두 지워준다
plot.new()

##################################################################

### 막대 그래프( 일반, 빈도, 누적, 히스토그램)
# 집단간의 비교를 할 때 많이 사용된다
# 구동방식(drv) : f(전륜),r(후륜),4(4륜)
# 범주가 정해졍있으므로 facotr

# 구동방식에 따른 고속도로 평균연비를 비교해 보자.
go <-group_by(df,
         drv)%>%
     summarise(mean = mean(hwy))
# grouping과 summarise를 하면 테이블 데이터프레임으로 결과가 도출된다
# 따라서 data frame 형태로 바꾼다
as.data.frame(go)

# geom_col() : 막대그래프 그리는 함수
ggplot(data=go,
       aes(x=drv,
           y=mean))+
  geom_col(width = 0.5)

# 막대그래프의 길이에 따라서 순서를 재 배치하려면
# reorder(x축이름,어떤거에 따라?), 기본은 오름차순/// 내림차순으로 하려면 -mean이라고 한다
# color는 선색깔, fill은 색채우기
ggplot(data=go,
       aes(x=reorder(drv,-mean),
           y=mean))+
  geom_col(width = 0.5,
           color = "Red",
           fill = "white")

# 빈도 막대 그래프
# 사용하는 함수는 geom_bar()함수 사용한다
# raw data frame을 직접 이용해서 처리할 수 있다.
# 빈도 그래프는 어차피 건수만 나타내기 때문에 mean을 y축에 설정해주지 않아도 된다.

plot.new()

ggplot(data=df,
       aes(x=drv))+
  geom_bar()

# 누적빈도 그래프 : 안에 축을 하나 더 설정해야한다(범주형 데이터)
ggplot(data=df,
       aes(x=drv))+
  geom_bar(aes(fill=factor(class)))

# 히스토그램 : 구간에 몇개 있는가(구간당 분포)(연속형 데이터)
# 기본적으로 30칸으로 나눠준다

ggplot(data=df,
       aes(x=hwy))+
  geom_histogram(aes(fill=factor(class)))

############################################################################
### 선그래프 - 시계열 데이터를 표현할 때(시간에 따라 변동하는 데이터)
# 일반적으로 환율, 주식, 경제동향

# mpg는 시간에 대한 데이터가 없다.
# line chart를 위해서 economics data set을 이용
# psavert : 개인 저축률, pop : 인구, unemped : 구직활동하고 있는 기간(주 단위의 median값), 
# pce : 개인 소비 지출(십억단위)

economics
View(economics)

ggplot(data=economics,
       aes(x=date,
           y=unemploy))+
  geom_line()


economics
View(economics)

ggplot(data=economics,
       aes(x=date,
           y=unemploy))+
  geom_point(color="red")+
  geom_line(color="blue")

############################################################################ 
# box 그래프 - 데이터의 분포를 쉽게 파악할 수 있다

df = as.data.frame(mpg)
head(df)

# 구동 방식별 hwy(고속도로 연비) 상자그림을 그려보자

ggplot(data=df,
       aes(x=drv,
           y=hwy))+
  geom_boxplot()

############################################################################

# 이렇게 ggplot2를 이용해서 4가지 종류의 그래프를 그릴 수 있다.
# 추가적으로 객체를 포함시켜서 그래프를 더 이해하기 쉬운 형태로 만들어보자.

# mpg : 자동차 연비에 대한 data set
# economics : 월별 경제 지표에 대한 data set

# 날짜별 개인저축률에 대한 선 그래프를 그려보자
# 축설정할 때는 axes인데 함수 이름은 aes이다
# intercept : y절편, slope = 기울기
# 일반적인 직선을 그릴 수 있다.

ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_line() +
  geom_abline(intercept=12.1,
              slope=-0.0003444)

# 수평선을 그릴 수 있다.
# 전체 저축률에 대한 평균으로 그려보자
# vline : 세로직선
# hline : 가로직선
# yintercept : y절편
ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_line() +
  geom_hline(yintercept=mean(economics$psavert))

# 가장 개인저축률이 낮은 날짜에 대한 수직선을 그릴 수 있다.
lowest <- filter(economics,
                 min(psavert) == psavert)


ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_line() +
  geom_vline(xintercept=lowest$date,
             color="red")

# 만약 직접 날짜를 입력해서 수직선을 표현하려면?
# Data Type 변경하기

ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_line() +
  geom_vline(xintercept=as.Date.character("2005-05-01"),
             color="red")


ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_line() +
  geom_vline(xintercept=lowest$date,
             color="red") +
  geom_vline(xintercept=as.Date.character("2000-05-01"),
             color="blue")

# 그래프 안에서 text를 표현하려면 어떻게 해야하나?

ggplot(data = economics,
       aes(x=date,
           y=psavert)) +
  geom_point() +
  xlim(as.Date("1990-01-01"),
       as.Date("1992-12-01")) +
  ylim(7,10) +
  geom_text(aes(label=psavert,
                vjust=-0.5,
                hjust=-0.3))
  
# vjust와 hjust는 위아래, 옆으로의 위치를 조정하는 것이다
# label은 점에 나타내고자 하는 값을 준다
# hjust : -1로 설정하면 수가 점보다 오른쪽에있다.
#         +2로 설정하면 수가 점보다 왼쪽에있다. 
# vjust : -1로 설정하면 수가 점보다 위에 있다.
#         +로 설정하면 수가 점보다 밑에 있다.


# 특정 영역을 highlight 해보자
# annotate("모양",xmin,xmax,ymin,ymax등등) : 원래 그린 그래프에 새로운 그림을 덧씌우자 
# alpha = : 투명도를 조절할 때(1이면 안투명한거, 0이면 완전 투명)
ggplot(data = economics,
       aes(x=date,
           y=psavert)) +
  geom_point() +
  annotate("rect",
           xmin=as.Date("1985-01-01"),
           ymin=5,
           xmax=as.Date("2000-01-01"),
           ymax=10,
           alpha=0.2,
           fill="purple")

#############################################################################
##여기에 추가적으로 화살표도 그려넣어보자
# arrow : 화살표
# text : text 추가
# labs : x축과 y축에 대한 제목
# theme : 전체적인 설정 변경

ggplot(data = economics,
       aes(x=date,
           y=psavert)) +
  geom_point() +
  annotate("rect",
           xmin=as.Date("1985-01-01"),
           xmax=as.Date("2000-01-01"),
           ymin=5,
           ymax=10,
           alpha=0.2,
           fill="purple")+
  annotate("segment",
           x=as.Date("1995-03-25"),
           xend=as.Date("1995-09-20"),
           y=8,
           yend=6,
           arrow=arrow(),
           color="yellow",
           size=5)+
  annotate("text",
           x=as.Date("1995-03-25"),
           y=9.5,
           label = "My Birth",
           color = "red",
           size = 10)+
  labs(x="연도",
      y="개인별 저축률",
      title="연도별 개인저축률 추이")+
  theme_dark()

##########################################################################









