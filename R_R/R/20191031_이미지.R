##################################################################################################
# KAKAO API(이미지검색) + 찾은 이미지 파일로 저장

# 사용하는 package는 네트워크 연결을 통해 서버에 접속해서 결과를 받아올 때 사용하는 패키지를 이용

# Opne API의 주소를 알아야 호출할 수 있다.
# kakao developer -> 검색 -> REST API -> 이미지 검색 ->

## 주소창 : curl -v -X GET "https://dapi.kakao.com/v2/search/image" \
## 쿼리 이용 : --data-urlencode "query=설현" \
## 키값을 발급받아서 헤더에 넣어야한다-H "Authorizaion: KakaoAK kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"

install.packages("jsonlite")
install.packages("rvest")
install.packages("httr")
install.packages("jpeg")


library(jsonlite)
library(stringr)
library(httr)
library("rvest")
library("jpeg")

image_url <- "https://dapi.kakao.com/v2/search/image"

keyword <- "query=아이유"

#한글을 이용하기 때문에 한글을 url encode 처리할 것!

request_url <- str_c(image_url,
                     "?",
                     keyword)
request_url <- URLencode(request_url)




# web에서 클라이언트가 서버쪽 프로그램을 호출할 때, 호출방식이 있다. (크게 4가지)
# GET, POST, PUT, DELETE의 네가지 방식 
# 일반적으로 GET, POST를 이용한다(REST가 아닐 때)
# GET방식 : 서버 프로그램을 호출할 때, 전달하는 데이터를 URL뒤에 붙여서 전달할 수 있다.
#          => ?뒤에 키워드로 부르는거@!!
# POST방식 : 서버 프로그램을 호출할 때 전달 데이터가 request header에 붙어서 전달
#          => url뒤에 안붙고 요청 header안에 데이터를 붙여서 보낸다
#          => file size가 크면 get방식으로 전달이 불가능하다


#####url#####
# open API를 사용할 때 거의 대부분 인증절차를 거쳐야 사용할 수 있다.
# 기존과 다르게  fromJSON을 사용하지 않는다 @ 정형적인 형태의 package로 처리해보기 위해서
# GET으로 가져오면 응답객체로 받아온다 =>  content로 받아와서 dataframe형태로 저장한다

apikey <- "4148ea93bc96c3c419b2d656747be1d6"

result <- GET(request_url,
              add_headers(
                  Authorization = paste("KakaoAK", apikey)))

http_status(result)   # 접속상태 결과

result_data <- content(result)
result_data                       #content : 결과 내용을 추출


#########################################1-80개 불러오기#########################################


for(idx in 1:length(result_data$documents)){
  #request 문제를 내는것 response 응답하는 것
  req = result_data$documents[[idx]]$thumbnail_url
  res = GET(req) #이미지에 대한 응답
  imgData = content(res,"raw")
  # 이미지는 실제로0101로 이루어진 binary 데이터이기 때문에 데이터 타입을 변경해야한다.
  # 결과로 받은 이미지를 raw 형태로 추출한다.
  
  writeBin(imgData,
           paste("C:/R_R/Image/img",
           idx,
           ".png")
           )
  
  # R_R폴더에 Image 폴더에 img1 , img2의 png 확장자 파일을 만들자
  # bin을 저장할 때 
}

####################################################################################################3















