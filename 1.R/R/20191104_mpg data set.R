## 3주차
# 데이터 조작 및 정제(결측치,이상치 제어)
# 그래프, 시각화(ggplot2)

# mpg data set : 인기있는 차종에 대한 내용

# mpg data set을 이용하기 위해서 특정 package를 설치해보자
# ggplot2에 mpg data set이 같이 들어있다.

install.packages("ggplot2")
library(ggplot2)
library(dplyr)
library(xlsx)

mpg
str(mpg) 
class(mpg) #mpg는 table data frame 형태, console 크기에 맞추어서 data frame을 출력해준다!
tbl_df() #data_frame을 테이블 형식으로 만들어준다 => 출력 목적으로 많이 사용

df <- as.data.frame(mpg)
str(df)

# 사용할 데이터 프레임을 준비했다 !
ls(mpg)     # column명만 벡터 형태로 출력해준다, 알파벳순 오름차순으로 정렬되어 나온다

# mpg에 대한 document를 살펴보고 column에 대한 의미를 먼저 파악하자
help(mpg)
head(mpg)   
tail(mpg)
head(mpg, 10) #인자를 주면 보고싶은 개수만큼 볼 수 있다.
View(df) # View창을 통해 데이터를 확인

dim(df)   #dimension : 몇 개 행과 몇 개 열로 구성되었는지 알려준다
length(df) 
#원래 length()는 원소의 개수를 구하는 함수인데 data frame에 적용되면 column 개수를 구한다
summary(df)
rev(df)

################################################################################

## 데이터 조작 (dplyr) ##

# 속도에 강점이 있는 C++로 구현되어있다.
# chaining가능 (%>%)
# dplyr이 제공하는 여러 함수를 이용해서 원하는 데이터를 추출할 수 있다.

# 1. tbl_df()
# class에서 구조 확인한 후 데이터프레임으로 바꿔주고 사용하기
df <- tbl_df(df)
df <- as.data.frame(df)
df

# 2. rename() #column의 이름을 변경할 수 있다.
# row data를 이용할 경우 column명이 없을 때 column명을 새로 명시해서 사용하자
# column명이 복잡할 때 소문자로 전체변경해도되고 ㅇㅇㅇㅇ
# df의 column명을 모두 소문자/ 대문자로 변경해보자

names(df) = toupper(names(df))
names(df) = tolower(names(df))

# 3. 조건을 만족하는 행 추출 함수
# filter(dataframe, 조건)
# mpg data set에서 2008년도에 생산된 차량이 몇 개 있는지 추출해보자
filter(df,
       year == 2008)%>%
  nrow()

# 모든 차량에 대해 평균 도시연비보다 도시연비가 높은 차량의 model 명을 출력하세요 #23개

avg_cty <- mean(df$cty, na.rm=T )
avg_cty
result <-                        #118개
        
  
w<- unique(filter(df,
              cty > avg_cty)$model)

w                                 #23개

# 고속도로 연비가 상위 75% 이상인 차량을 제조하는 제조사는 몇개인지 출력하세요 #9개

w<-unique(filter(df,
       hwy >= summary(df$hwy)[5])$manufacturer)

length(w)
# summary의 결과가 벡터로 나온다 => summary에서 index 값으로 값 추출한다

# 오토 차량 중 배기량이 2500cc 이상인 차량수는 몇개? #125개
k <- filter(df,
            str_detect(trans,"auto"))

nrow(filter(k,
       displ >= 2.5))

####조건을 붙여서 써보자###
nrow(filter(df,
       str_detect(trans,"auto"),
       displ >= 2.5))

# 4. arrange() : 정렬하는 함수
# arrnage(data frame, dolumn1, desc(column2))


avg_cty <- mean(df$cty, na.rm=T )
avg_cty
                        #118개
  
  
w<- unique(filter(df,
                    cty > avg_cty)$model)

w                                 #23개

# 모든 차량에 대해 평균 도시연비보다 도시연비가 높은 차량의 모델명을 오름차순으로 정렬

df %>% filter(cty > mean(cty)) %>% 
      select(model) %>%
      unique()%>%
      arrange(model)

# 5. select() : data frame에서 원하는 column만 추출하는 함수
# select(data frame, column1, column2, ,,,)

# 6. mutate() : 새로운 column을 생성하려면 어떻게 해야하나?
# 도시 연비와 고속도로 연비를 합쳐서 평균 연비 column을 만들어보자.
mutate(df, 
       mean_rate = (cty+hwy)/2)
df$mean_rate = (df$cty+df$hwy)/2
df

# 7. summarise()
# 통계량을 구해서 새로운 컬럼으로 생성하는 함수
# model 명이 a4이고 배기량이 2000cc 이상인 차들에 대해 평균 연비(cty , hwy)?
result<- filter(df,
         model == "a4",
        displ >= 2)%>%
      mutate(mean_result = mean((cty+hwy)/2))
unique(result$mean_result)


## summarise로 처리해보자
filter(df,model == "a4",
          displ >= 2)%>%
          summarise(avg_rate = mean(c(cty,hwy)))

# 8. group_by() : 범주형 변수에 대한 grouping
df %>% filter(displ >= 2.0)%>%
  group_by(manufacturer)%>%
  summarise(avg_rate = mean(c(cty,hwy)))




