## Week3

# 데이터 조작, 데이터 정제
# 시각화에 대한 내용(ggplot2)

# mpg data set을 이용해서 데이터 조작, 
# 정제에 대한 내용을 학습해 보아요!!

# mpg data set을 이용하기 위해서 특정 package를 설치해보아요!

install.packages("ggplot2")     # package 설치
library(ggplot2)        # package를 메모리에 로딩
mpg
str(mpg)        # 자료구조를 조사해 보아요!!
class(mpg)      # 자료구조를 조사해 보아요!!
# mpg는 table data frame 형태
# 출력을 용이하게 하기 위한 형태이고
# Console 크기에 맞춰서 data frame을 출력

df <- as.data.frame(mpg)    # data frame으로 변환
df

# 사용할 data frame을 준비했어요!!
# data frame의 column명을 알아보아요!!
ls(df)      # column명을 오름차순으로 정렬해서 추출

# mpg에 대한 document를 확인해서 column의 의미를
# 먼저 파악해야 해요!

head(df)        # 기본적으로 6개 출력
tail(df)

head(df, 3)     # 보고싶은 개수를 지정할 수 있어요!
View(df)        # View창을 통해 데이터를 확인!
dim(df)         # data frame이 몇개의 행과 열로 구성되어 있는지 확인

nrow(df)        # data frame의 행의 개수를 추출
ncol(df)        # data frame의 열의 개수를 추출
length(df)      # 원래 length()는 원소의 개수를 구하는 함수인데
                # data frame에 적용되면 column의 개수를 구해요!

str(df)         # 자료구조, 행의 개수, 열의 개수, 컬럼명, 데이터 타입 등을 추출.

summary(df)     # data frame의 가장 기본적인 통계데이터를 추출

rev()           # vector에 대해서 데이터를 역순으로 변환하는 기능능

#################################################################################

## 데이터 조작 ( dplyr : 디플라이알 )
## data frame을 조작할 때 가장 많이 사용하는 package
## 속도에 강점 : C++로 구현되어 있어요!
## Chaining(pipeline)이 가능해요 ( %>% )
## dplyr이 제공하는 여러 함수를 이용해서 우리가 원하는 데이터를 추출

library(dplyr)

# 1. tbl_df()
df
df <- tbl_df(df)            # table data frame
df <- as.data.frame(df)     # data frame
df

# 2. rename() : column의 이름을 변경할 수 있어요
# raw data를 이용할 경우 column명이 없을때
# column명을 새로 명시해서 사용해야 해요!
# 컬럼명에 대소문자가 같이 있는 경우
# 모두 소문자, 대문자로 변경해서 사용하면 편해요!
# df의 컬럼명을 모두 소문자 혹은 대문자로 변경하려면
# names()를 이용해서 하는게 더 편해요!
names(df) = toupper(names(df))
names(df)

names(df) = tolower(names(df))
names(df)

new_df <- rename(df,
                 MODEL = model)           # data frame을 리턴
head(new_df)                              # (함수가 적용된 data frame을 출력)

# 3. 조건을 만족하는 행을 추출하는 함수
# filter(data frame, 
#        조건1, 조건2, 조건3, ...)
# mpg data set에서
# 2008년도에 생산된 차량이 몇개 있는지 추출

df <- as.data.frame(mpg)
nrow(filter(df,
            df$year == 2008))

# Q1.모든 차량에 대해 평균 도시연비보다 도시연비가
#    높은 차량의 model명을 출력하세요
#    모델명은 23개
#    차량의 대수는 118대

# 내가한거
# df_1 <- filter(df,
#               df$cty > mean(df$cty))
# length(unique(df_1$model))

avg_cty <- mean(df$cty, na.rm = T)      # na.rm = T : NA가 있으면 제외하고 계산하렴
unique(filter(df,
       cty > avg_cty)$model)


# Q2. 고속도로 연비가 상위 75% 이상인 차량을
#     제조하는 제조사는 몇개인지 추출하세요!
#     총 15개 제조사 중 9개

# 내가한거
# length(unique(filter(df,
#                      hwy >= quantile(hwy,
#                                      probs = 0.75))$manufacturer))

length(unique(filter(df,
                     hwy >= summary(hwy)[5])$manufacturer))

# Q3. 오토 차량중 배기량이 2500cc 이상인 차량 수는? 
#     총 234개의 차종 중 125개
library(stringr)
nrow(filter(df,
            displ >= 2.5,
            str_detect(trans, "auto")))


# 4. arrange() : 정렬하는 함수
# arrange(data frame,
#         column1,              # 기본 정렬방식 : 오름차순
#         desc(column2))        # desc() : 내림차순 정렬



# Q4.모든 차량에 대해 평균 도시연비보다 도시연비가
#    높은 차량의 model명을 출력하세요
#    단, 모델명을 오름차순으로 정렬하세요

avg_cty <- mean(df$cty, na.rm = T)
unique(filter(df,
              cty > avg_cty)$model)

df %>% filter(cty > mean(cty)) %>% 
       select(model) %>% 
       unique() %>%
       arrange(model)

# 5. select() : data frame에서 원하는 column만 추출하는 함수
# select(data frame, column1, column2, ...)

# 6. 새로운 column을 생성하려면 어떻게 해야 하나요?

# 도시연비와 고속도로 연비를 합쳐서
# 평균 연비 column을 만들어 보아요!

# R의 기본기능을 이용해서 column을 만들 수 있어요!
df$mean_rate = (df$cty + df$hwy) / 2
df

# column을 추가할 떄는 mutate()함수를 이용해요
df <- as.data.frame(mpg)
new_df <- df %>% mutate(mean_rate = (cty + hwy) / 2)     # 수식말고 함수쓰려면?
head(new_df)

# 7. summarise() : 통계량을 구해서 새로운 컬럼으로 생성하는 함수
#                  1행 1열 data frame으로 출력

# model명이 a4이고 배기량이 2000cc 이상인 차들에 대해
# 전체 평균연비를 계산하세요!

# No summarise()
result <- df %>% filter(model == "a4", displ >= 2.0) %>% 
                 mutate(avg_rate = (cty + hwy) / 2) %>% 
                 select(avg_rate)
mean(result$avg_rate)


summary(df$hwy)
# summarise() 적용
df %>% 
    filter(model == "a4",
           displ >= 2.0) %>% 
    summarise(avg_rate = mean(c(cty,hwy)))
    

# 8. group_by() : 범주형 변수에 대한 grouping
#                 (~별 통계량, ~에 대한 통계량 등)
df %>% 
    filter(displ >= 2.0) %>% 
    group_by(manufacturer) %>% 
    summarise(avg_rate = mean(c(cty,hwy))) %>% 
    as.data.frame()

# 9. left_join, right_join(), inner_join(), outer_join()


###############################################################################
# 연습문제 2
df <- as.data.frame(mpg)
str(df)

# 1. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 확인하세요.
#       4이하    5이상
#    25.96319   18.07895
displ4 <- df %>% 
                filter(displ <= 4) %>% 
                summarise(avg_hwy4 = mean(hwy))
displ5 <-  df %>% 
                filter(displ >= 5) %>% 
                summarise(avg_hwy5 = mean(hwy))   

result1 <- cbind(displ4, displ5)
result1

# 2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 한다. "audi"와 "toyota" 중 어느 manufacturer(제조회사)의 cty(도시 연비)가 평균적으로 더 높은지 확인하세요.
audi_cty <- df %>% 
                filter(manufacturer == "audi") %>% 
                summarise(avg_cty_audi = mean(cty))

toyota_cty <- df %>% 
                    filter(manufacturer == "toyota") %>% 
                    summarise(avg_cty_toyota = mean(cty))


result2 <- cbind(audi_cty, toyota_cty)
result2


# 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 한다. 이 회사들의 데이터를 추출한 후 hwy(고속도로 연비) 전체 평균을 구하세요.

result3 <- df %>% 
                filter(manufacturer %in% c("chevrolet", "ford", "honda")) %>% 
                summarise(avg_hwy = mean(hwy))
result3


# 4. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 한다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.

df %>% 
    filter(manufacturer == "audi") %>% 
    group_by(model) %>% 
    arrange(desc(hwy)) %>% 
    head(5)

# 5. mpg 데이터는 연비를 나타내는 변수가 2개입니다. 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 사용하려 합니다. 평균 연비 변수는 두 연비(고속도로와 도시)의 평균을 이용합니다. 회사별로 "suv" 자동차의 평균 연비를 구한후 내림차순으로 정렬한 후 1~5위까지 데이터를 출력하세요.

# subaru 21.9
# toyota 16.3
# nissan 15.9
# mercury 15.6
# jeep 15.6

df %>% 
    group_by(manufacturer) %>% 
    filter(class == "suv") %>%
    summarise(avg_rate = mean(c(cty,hwy))) %>%
    arrange(desc(avg_rate)) %>% 
    head(5)

# 6. mpg 데이터의 class는 "suv", "compact" 등 자동차의 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교하려 합니다. class별 cty 평균을 구하고 cty 평균이 높은 순으로 정렬해 출력하세요.


df %>% 
    group_by(class) %>% 
    summarise(avg_cty = mean(cty)) %>% 
    arrange(desc(avg_cty))


# 7. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려 합니다. hwy(고속도로 연비) 평균이 가장 높은 회사 세 곳을 출력하세요.

df %>% 
    group_by(manufacturer) %>% 
    summarise(avg_hwy = mean(hwy)) %>% 
    arrange(desc(avg_hwy)) %>% 
    head(3)


# 8. 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

df %>% 
    group_by(manufacturer) %>% 
    summarise(n_compact = sum(class == "compact")) %>% 
    arrange(desc(n_compact))

