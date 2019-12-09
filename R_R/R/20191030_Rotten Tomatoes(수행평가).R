# 로튼토마토 사이트에서 2019년 가장 인기있는 영화 100개에 대해서 
# 영화제목, User rating, Genre 부분을 추출해서 Data Frame으로 만들고 파일로 출력하세요
# 코드와 만들어진 파일을 제출!

# 패키지
install.packages("jsonlite")
install.packages("rvest")
install.packages("httr")

library(jsonlite)
library(stringr)
library(httr)
library("rvest")

rm(list=ls()) 

# url
origin_url <-"https://www.rottentomatoes.com/top/bestofrt/?year=2019"
main_url <-"https://www.rottentomatoes.com"

# HTML 읽어와서 자료구조화
html_page <- read_html(origin_url)
html_node <- html_nodes(html_page, "tr>td>a.unstyled.articleLink")

# 저장할 곳 만들기
title <- vector(mode = "character", length = 100)
userrt <- vector(mode = "character", length = 100)
genre <- vector(mode = "character", length = 100)


# 접속할 링크
for(i in 1:100){
  link <- html_attr(html_node,name="href")
  movie_link <- str_c(main_url,link)[i]
  html_info_page <- read_html(movie_link)

  # 영화제목
  title_tmp <- html_text(html_nodes(html_info_page,
                                "h1"),
                         trim=T)
  title[i] = title_tmp
  
  # 영화 사용자 점수
  userrt_tmp <- html_text(html_nodes(html_info_page,
                                           "strong.mop-ratings-wrap__text--small")[2],
                                trim = TRUE)
  userrt[i] = userrt_tmp
  
  # 영화 장르
  genre_tmp <- html_text(html_nodes(html_info_page,
                                "div.meta-value>a[href*=genres]"),
                         trim=TRUE)
  genre[i] = paste(genre_tmp,collapse=", ")
  
  }

result<- data.frame(title,userrt,genre)
View(result)
