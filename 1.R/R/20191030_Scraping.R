##############################################################################################
# R에서 JSON 데이터 처리
# Network을 통해서 JSON 데이터를 받아서 Data Frame으로 만들기 위해 새로운 package를 이용해보자.

# 1. package 설치
install.packages("jsonlite")
# 네트워크와 관련된 package
install.packages("httr")
# 2. package를 사용하기 위해 loading 작업
library(jsonlite)
# 3. 문자열 처리하기 위한 package loading
library(stringr)
library(httr)

# 4. 접속할 url 작성
url <- "http://localhost:8080/bookSearch/search?keyword="
request_url <- str_c(url,
                     scan(what=character()))
URLencode <- URLencode(request_url) # 한글처리

# 주소가 완성되었다 ! jsonlite안에 있는 json의 일부를 가져오는 함수 사용
df <- fromJSON(URLencode) #Json이 테이블 구조로 떨어진다.

remove(df)
str(df)
# view() : data frame의 뷰 형태로 출력하는것 (구조분석 시 이용)
# str() : data frame의 구조를 파악
# names() : 


# 찾은 도서 제목만 console에 출력
for(idx in 1:nrow(df)){
  print(df$title[idx]) # title column을 벡터형태로 가져옴
}


# JSON을 이용해서 Data Frame을 생성할 수 있다.
# data frame을 csv 형식으로 file에 저장

write.csv(df,
          file="C:/R_R/Data/book.csv",
          row.names = FALSE,
          quote = FALSE)        #\로 되어있는거 다 /로 바꿔준다
# ""를 TRUE로 해주는 것이 좋다. ,로 분리하는데 데이터에 ,가 있고 ""가 없을 경우 데이터가 꼬이게됨

# Data Frame을 JSON으로 변경하려면 어떻게 하나요?
df_json <- toJSON(df)
df_json
prettify(df_json)

write(df_json, file="C:/R_R/Data/book_json.txt")
write(prettify(df_json), file="C:/R_R/Data/book_json.txt")
# json 형태는 write 사용시 .csv할 필요없다




#####################################연습문제####################################################

#2018년 10월 30일 박스오피스 순위를 알아내서 제목과 누적관람객수를 csv 파일로 저장해보자




# url
movie_url <- "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="
movie_key <- "42677d82313c4ea3346ce45270c30acc&targetDt="
movie_targetDt <- scan()

real_url <- str_c(movie_url,
                  movie_key,
                  movie_targetDt)
real_url

# df형태로 변환
df <- fromJSON(real_url)
movie_df <- df$boxOfficeResult$dailyBoxOfficeList



# 제목과 누적관람객수 console에 출력
# 방법1
df123 <- data.frame(movie_df$movieNm, movie_df$audiAcc)
write.csv(df123,
          file="C:/R_R/Data/movie.csv")


# 방법2
for(idx in 1:nrow(movie_df)){
  
 print()
 
}

df_new = as.data.frame(df)
df_new



movie_save



# data frame을 csv 형식으로 file에 저장
write.csv(movie_save,
          file="C:/R_R/Data/movie.csv",
          row.names = FALSE)


# data frane을 새로 생성한 후 파일 출력
# data frame에서 로직처리해서 데이터를 추출해 text파일에 append에서 출력










