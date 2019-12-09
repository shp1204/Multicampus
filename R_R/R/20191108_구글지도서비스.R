##################################################################
# 구글지도 서비스를 이용해보자

# Google Map Platform을 사용하기 위해서는 특정 package가 필요하다
# 이 package가 CRAN에 등록이 안되어 있어서 => github에 공유되어있는 것 사용
# CRAN(세계적으로 패키지를 등록하는? 사이트 => 사용자들이 쉽게 이용 가능)

# VCS(Version Control System)

# 원본 : A
# 홍길동은 원본을 : A1으로 변형
# 최길동은 원본을 : A2로 변형
# 파일을 여러명이 작업하면 파일이 어떻게 될까??? 

## 이런 공동작업에 대한 문제를 해결하기 위해서 나온게 vcs 
## CVCS (Centralized VCS)
# 소스 원본을 중앙서버가 갖고 있고, 나머지 사람은 복사본을 가져가서 작업
# BUT!! 원본이 삭제되면? 서버가 죽으면? 
# => 복사본만 갖고있는 사람들의 데이터를 원본에 옮길 수 없음(파일복구불가능)

# 그래서 중앙서버 => 분산서버로 바꾸기 시작했다.
# DVCS(Distributed VCS)
# 소스 원본을 여러 곳에서 보관한다
# (나중에 일주일동안 배울 예정, github 특강, 완전필수!!!!)
# Git을 이용하면 공동처리가 쉬워진다
# Git repository(저장소)
# 이런 Git Repository를 서비스 해주는 회사가 있어요 => Github

######################################################################

# 1.Github에 공유되어 있는 ggmap package를 설치해야 한다 (ggmap:구글맵패키지)
# package는 버전특성에 영향을 받기 때문에 (dependency 의존성)에 신경써야한다
sessionInfo()
# R 버전/ 패키지 등의 상태를 알 수 있다.
# R 버전이 3.6.1로 최신버전!bur 최신 버전의 R패키지가 아니면 패키지 설치 불가능, 설치 해도 사용이 어려움 => dependency 너무 중요해

# ggmap은 하위버전이므로 R다른버전 설치 ㄱ
# CRAN => windows => base => previous release => 3.5.1
# 버전을 맞췄으니 필요한 패키지를 깃허브에서 다운받아 설치해보자


install.packages("devtools")
# devtools(개발툴)안에 github를 개발할 수 있는 패키지가 들어있다.
library(devtools)

install_github("dkahle/ggmap")
# 사실 install.packages는 CRAN에서 데이터를 받는 것인데 지금은 github에서 다운받아야하므로 github도 다운받아야한다 ^..^

library(ggmap)

# 생성한 구글 API KEY
googleAPIKey = "AIzaSyDXYUddQnNbTIGypBazJOIDCNvUavHJdl8"

# 구글 API Key를 이용해서 인증을 받아야한다
register_google(key = googleAPIKey)

gg_seoul <- get_googlemap("seoul",
                          maptype = "roadmap")
ggmap(gg_seoul)
library(dplyr)
library(ggplot2)

geo_code = geocode(enc2utf8("공덕역"))
# enc2utf8 함수로 한글을 유니코드로 변환하고 geocode를 이용해서 위도/경도 출력
geo_code
# 테이블 형태로 출력되어있기 때문에 벡터로 변경해보자

geo_data = as.numeric(geo_code)
geo_data
# 숫자형 벡터로 출력한다


# center : map의 어딘가를 가운데로 설정해준다
get_googlemap(center=geo_data,
              maptype = "roadmap",
              zoom = 15)%>%
  ggmap() +
  geom_point(data=geo_code,
             aes(x=lon,
                 y=lat),
             size=5,
             color="red")

###########################################################

addr <- c("공덕역","역삼역")
gc <- geocode(enc2utf8(addr))
df <- data.frame(lon=gc$lon,
                 lat=gc$lat)
df

# 두 점을 한 지도에 출력할 때, 두 지점 각각의 평균 위도, 경도를 지도의 중앙으로 잡자 !
# marker : 표지판
cen <- c(mean(df$lon),mean(df$lat))
get_googlemap(center=cen,
              maptype = "roadmap",
              zoom=13,
              markers = gc)%>%
ggmap()


# 지하철역 주변 아파트 정보 : "서울 열린 데이터 광장" 이라는 공공포털고고
# 아파트 실거래 금액 데이터 : "국토부 실거래가 공개 시스템" 

################################################################

# interactive Graph

# package 설치
install.packages("plotly")
library(plotly)

# mpg data set을 이용해서 배기량과 고속도로 연비에 대한 산점도를 그려보자
library(ggplot2)

df <- as.data.frame(mpg)
head(df)

g <- ggplot(data = df,
       aes(x=displ,
           y=hwy)) + 
      geom_point(size=3,
             color="blue")

ggplotly(g)
# ggploty : 마우스 커서를 점 근처에 가져가면 값을 나타낸다 
#         : 일부분을 확대해서도 볼 수 있다(더블클릭하면 원래대로 돌아옴)
#         : html로 저장할 수 있다

##########################################################

addr <- c("공덕역","역삼역")
gc <- geocode(enc2utf8(addr))
df <- data.frame(lon=gc$lon,
                 lat=gc$lat)
cen <- c(mean(df$lon),mean(df$lat))
result <-get_googlemap(center=cen,
              maptype = "roadmap",
              zoom=13,
              markers = gc)%>%
         ggmap()

ggplotly(result)

#############################################확대, 값 확인
# 시계열 그래프#

# 시간에 따른 선그래프는 단순 확대만으로는 사용이 힘들다
# 특정 구간에 대한 자세한 사항을 보기 위해서 다른 package를 이용한다

install.packages("dygraphs")
library(dygraphs)

# 예제로 사용할 data set은 economics
# 시계열 그래프는 데이터를 xts라는 형식으로 변환시켜줘야 한다.
# dygraph : 움직일 수 있는 그래프를 그림 ( 확대하면 그 구간만 자세히 보여준다)
# dyRangeSelector : 그림 밑에 바가 생겨서 조절하기 더 편리함

ggplot(data=economics,
       aes(x=date,
           y=psavert)) +
  geom_line()

library(xts)
# 시간에 따른 개인저축률 추이
save_rate <- xts(economics$psavert,
                 order.by=economics$date) 
#order.by : 날짜순대로 정렬하기 때문에
#날짜는 데이터가 아니라 column을 나타낸다  

# 시간에 따른 실업률 추이
unemp_rate <- xts(economics$unemploy/1000,
                 order.by=economics$date)

unemp_save = cbind(save_rate,unemp_rate) # x축 범위가 같아야 잘 보인다 !!!

head(save_rate)
dygraph(unemp_save)%>%
  dyRangeSelector()


