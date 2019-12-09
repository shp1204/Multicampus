#############################################################################################
# web Crawling : 인터넷 상에서 필요한 정보를 읽어와서 수집하는 일련의 작업(과정)

# Web scraping : 하나의 web page에서 내가 원하는 부분을 추출하는 행위
# Web crawling(web spidering) : 자동화 봇인 crawler가 정해진 규칙에 따라 복수개의 web page를 browsin하는 행위

# scraping을 할 때 CSS(jQuery) selector를 이용해서 필요한 정보를 추출
# selector를 이용해서 추출하기 힘든 것도 있다. 
# 추가적으로 xpath도 이용해보자 : xml을 기반으로한다
# xpath는 xml보다 더 세밀하고 정확하게 데이터를 추출한다

# 특정 사이트에 접속해서 내가 원하는 데이터를 추출해보자

# 1. 서버로부터 받은 HTML 문자열을 자료구조화 시키는 패키지를 이용해야한다.
install.packages("rvest")
library("rvest")
library(stringr)

# 2. url을 준비하자
url <- "https://movie.naver.com/movie/point/af/list.nhn"
page <- "page="
request_url <- str_c(url,"?",page,1)
request_url

# 3. 준비된 URL로 서버에 접속해서 HTML을 읽어온 후 자료구조화 시키자
html_page <- read_html(request_url)
html_page

# 4. selector를 이용해서 추출하기 원하는 요소를 선택하자
nodes = html_nodes(html_page,
           "td.title > a.movie")
nodes

# 5. tag사이에 들어있는 text를 추출한다.
title <- html_text(nodes)
title

# 6. selector를 이용해서 리뷰 요소를 선택하자
# - trim=TRUE면 앞뒤의 공백 제거(\n과 \t)
# \n 줄바꿈 \t tab

nodes2 = html_nodes(html_page,
                   "td.title")
review <- html_text(nodes2, trim=TRUE)
review

# 7. 필요없는 문자들을 제거
# 특정 패턴 및 정규식 
review = str_remove_all(review, "\t")
review = str_remove_all(review, "\n")
review = str_remove_all(review, "신고")
review

# 8. 영화제목과 리뷰에 대한 내용을 추출
df <- cbind(title, review)
df

# 9. 이렇게 구축한 데이터를 파일에 저장하자

############ 여기까지 selector를 이용해서 scrapping한 것!############################
#####################################################################################

# 같은 작업을 xpath를 이용해서 처리해보자.

# 1. 설치
install.packages("rvest")
library("rvest")
library(stringr)

# 2. url
url <- "https://movie.naver.com/movie/point/af/list.nhn"
page <- "page="
request_url <- str_c(url,"?",page,1)

# 3. 자료구조화
html_page <- read_html(request_url)

# 4. title가져오기
nodes = html_nodes(html_page,
                   "td.title > a.movie")
title <- html_text(nodes, trim=TRUE)

# 5.review 부분은 xpath로 가져오자
# jQuery에서 <>로 표시했던 '자식'을 /로 표현


review = vector(mode="character",length=10)
for(idx in 1:10){
  mypath = str_c('//*[@id="old_content"]/table/tbody/tr[', idx , ']/td[2]/text()')
  
  nodes = html_nodes(html_page,
                   xpath=mypath )

txt <- html_text(nodes,trim=TRUE)
review[idx] = txt[3]

}


#####################################################################################################

# 반복해서 page를 browsing 하는 crawling까지 포함해보자

extract_comment <- function(idx){
  
  url <- "https://movie.naver.com/movie/point/af/list.nhn"
  page <- "page="
  request_url <- str_c(url,"?",page,idx)
  
  # 3. 자료구조화
  html_page <- read_html(request_url,
                         encoding = "CP949")
  
  # 4. title가져오기
  nodes = html_nodes(html_page,
                     "td.title > a.movie")
  title <- html_text(nodes, trim=TRUE)
  
  # 5.review 부분은 xpath로 가져오자
  # jQuery에서 <>로 표시했던 '자식'을 /로 표현
  
  
  review = vector(mode="character",length=10)
  for(idx in 1:10){
    mypath = str_c('//*[@id="old_content"]/table/tbody/tr[', idx , ']/td[2]/text()')
    
    nodes = html_nodes(html_page,
                       xpath=mypath )
    
    txt <- html_text(nodes,trim=TRUE)
    review[idx] = txt[3]
    
  }
  df = cbind(title,review)
  return(df)
}

result_df = data.frame();


for(i in 1:10){
 tmp <-extract_comment(i)
 # extract_comment가 호출하면 df가 위에서 return됨  
 result_df = rbind(result_df, tmp)
 
}
View(result_df)


