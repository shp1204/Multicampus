###########################################################################################
# MovieLens Data Set을 이용해서 처리해보자
# 영화에 대한 평점 정보를 기록해 놓은 데이터
# 평점은 1점~ 5점까지 줄 수 있다.(5점 최고, 1점 최저)
# 사람과 영화의 수가 많다. =>
## timestamp 는 년, 월, 일, 시간(시,분,초)까지.
# 2019-11-01 10:10:30 => 나라마다 날짜와 시간 표기법이 달라서 숫자로 날짜를 표현하는 방식
# timestamp         날짜
#     1       1970년 1월 1일 0시 0분 1초
#     2       1970년 1월 1일 0시 0분 2초
# 1초 증가할 때마다 1씩 올라간다
# 하루 뒤면 + 60*60*24

rm(list=ls()) 

# 데이터 구조 확인, 컬럼의 의미 확인

# 1. 사용자가 평가한 모든 영화의 전체 평균 평점
# 2. 각 사용자별 평균 평점
# 3. 각 영화별 평균 평점
# 4. 평균 평점이 가장 높은 영화의 제목을 내림차순으로 정렬해서 출력(동률이 있는 경우 모두 출력)
# 5. comedy 영화 중 가장 평점이 낮은 영화의 제목을 오름차순으로 출력(동률이 있는 경우 모두 출력)
# 6. 2015년도에 평가된 모든 Romance영화의 평균 평점 출력=> timestamp변환. 범위 찾아봥

#기본 작업 
install.packages("xlsx")
install.packages("dplyr")
library(dplyr)
library(xlsx)
library(stringr)
library(ggplot2)

# data frame 불러오기
# C:\R_R\Data\ml-latest-small
rate <- read.csv(file.choose(),
                fileEncoding = "UTF-8")

genre <- read.csv(file.choose(),
                  fileEncoding = "UTF-8")

ls(rate)
ls(genre)


# 1. 사용자가 평가한 모든 영화의 전체 평균 평점
mean_all <- mean(rate$rating)
mean_all                            # 3.501557

# 2. 각 사용자별 평균 평점 : userId끼리 그룹화 > 사용자별 평균 평점 출력
# numeric인 userId를 factor로 바꿔야할 거같은데

mean_each<-rate %>% group_by(userId) %>%
         select(userId, rating) %>%
         summarise(meanR = mean(rating))

mean_each

# 3. 각 영화별 평균 평점

mean_eachmovie <- group_by(rate,movieId)%>%
                  summarise(mean=mean(rating))
View(mean_eachmovie)


# 4. 평균 평점이 가장 높은 영화의 제목을 내림차순으로 정렬해서 출력(동률이 있는 경우 모두 출력)


max_movie <- max(mean_eachmovie$mean)

top_movie <- filter(mean_eachmovie,
                    mean_eachmovie$mean == max_movie)

top_list <- left_join(top_movie,genre,by="movieId")

result <- arrange(top_list,desc(title))%>%
          select(title)

View(result)


# 5. comedy 영화 중 가장 평점이 낮은 영화의 제목을 오름차순으로 출력(동률이 있는 경우 모두 출력)
# str_detect : "" 해당 문자열이 포함된 행 모두 출력

find <- as.character(genre$genres)

find2 <- filter(genre,
                str_detect(find,"Comedy"))
View(find2)                


comedy <- as.data.frame(left_join(find2,rate,
                                  by="movieId")%>%
                        select(movieId,title,rating)%>%
                        group_by(title)%>%
                        summarise(mean=mean(rating)))

min_comedy <- as.numeric(summary(comedy$mean)[1])

lowestrt_comedy_movie <-arrange(filter(comedy, mean==min_comedy),title)
lowestrt_comedy_movie


# 6. 2015년도에 평가된 모든 Romance영화의 평균 평점 출력=> timestamp변환. 범위 찾아봥

find3 <- as.character(genre$genres)
find4 <- filter(genre,
                str_detect(find3,"Romance"))

# 셀 합치기 & select
View(find4)
movies <- as.data.frame(left_join(find4,
                                  rate,
                                  by="movieId"))%>%
  select(title,rating,timestamp)

# timestamp 변환

begin <- as.numeric(as.POSIXct("2015-01-01 00:00:00"))
end <- as.numeric(as.POSIXct("2015-12-31 23:59:59"))

# 2015년에 평가된 영화 찾기
rating_15 <- movies%>%filter(timestamp >= begin & timestamp <= end)%>%
  select(rating)

mean(as.numeric(rating_15$rating))



