##########################################################################################################
# dplyr은 c++로 구현되어있어서 속도가 빠르다.
# dplyr은 코딩시 chainig을 사용할 수 있다.

var1 <- c(1,2,3,4,5)
var2 <- var1 * 2
var3 <- var2 + 5
# var1 <- c(1,2,3,4,5) * 2 + 5
# 중간 변수를 안만들고 코딩하는 방법 : chaining

install.packages("dplyr")
library(dplyr)

# dplyr의 주요함수들
# 1. tbl_df : 현재 console 크기에 맞추어서 data frame을 추출하라는 함수
tbl_df(iris)



######################iris 말고 다른 파일로 해보기##########################################################
library(xlsx)
# sheet index : 첫번째 sheet에서 파일을 불러온다
excel <- read.xlsx(file.choose(),
          sheetIndex = 1,
          encoding = "UTF-8")
#기본 요소들 확인해보기
View(excel)
str(excel)
class(excel)
ls(excel)
tbl_df(excel)

# 2. rename() : data frame의 column명을 바꿀 수 있다.
#    rename(data frame,
#           바꿀컬럼명1=이전컬럼명1,
#           바꿀컬럼명2=이전컬럼명2, ,,,)
# column명을 수정한 새로운 data frame이 리턴된다 !
# 기존의 data frame이 바뀌는것이 아니다 @@@@!!!!!!!
# 제공된 excel을 읽어들여서 data frame을 생성한 후 column명을 보니 
# AMT17 : 2017 이용금액
# Y17_CNT : 2017 이용횟수
# column명을 통일 및 정리해주자
df <- rename(excel,
             CNT17 = Y17_CNT,
             CNT16 = Y16_CNT)
df

######################################################################################

# 3. 하나의 data frame에서 하나 이상의 조건을 이용해서 데이터를 추출하려면 어떻게 해야하나
# filter(data frame, 조건1, 조건2, ,,,)

filter(excel,
       SEX == "M",
       AREA == "서울")

filter(excel,
       SEX == "M" & AREA == "서울")

# 모든 사람들 중에 지역이 서울 혹은 경기인 남성들 중 40살 이상의 사람들의 정보?
# or 는 역슬래쉬@@!!
filter(excel,
       SEX == "M" & AGE >= 40,
       AREA == "서울" | AREA == "경기")

# 모든 사람들 중에 지역이 서울 혹은 경기 혹은 제주인 남성들 중 40살 이상의 사람들의 정보?
# 하나의 column에서 조건이 많아질 때는 %in% 연산자를 사용할 수 있다.
filter(excel,
       SEX == "M" & AGE >= 40,
       AREA %in% c("서울","경기","지역"))

# 4.arrange(data frame, column1, column2, ,,, )
# 정렬의 기준은 오름차순 ! =default값
# 만약 내림차순으로 정렬하려면 desc() 함수 사용


# 서울, 남자, 2017년 처리 금액이 400,000원 이상인 사람을 나이가 많은 순으로 출력하자
result <- filter(excel,
                SEX == "M" & AREA == "서울",
                AMT17 >= 400000) 

go <- arrange(result,
              desc(AGE))
go

# 위를 chaining을 통해 연결해보자
# chaining 기호는 %>% 이고, 이 때 arrange 안에 data frame을 다시 넣지 않아도 된다
result <- filter(excel,
                 SEX == "M" & AREA == "서울",
                 AMT17 >= 400000) %>%
          arrange(desc(AGE))
result

# 5. select(data frame, column1, column2, ,,, )  
# 내가 추출하고자 하는 column을 지정해서 해당 column만 추출할 수 있다.
# # 서울, 남자, 2017년 처리 금액이 400,000원 이상인 사람을 나이가 많은 순으로 id와 나이, 2017년도 처리 건수를 출력하자
result <- filter(excel,
                 SEX == "M" & AREA == "서울",
                 AMT17 >= 400000) %>%
          arrange(desc(AGE)) %>%
          select(ID,AGE,Y17_CNT)
result

# ID부터 AGE까지만 출력할 때 select("ID:AGE")로 잡아도 출력된다 # 일일히 안쳐도됨
# SEX 만 제외하고 선택하고 싶을 때 select(-"SEX")

# 6. 새로운 column을 생성할 수 있다.
#dataframe$새로운 컬럼명 = "값"

# 17년도 처리 금액(50만 이상)을 기준으로 등급을 vip 나머지는 normal로 => 새로운 column을 생성할 것
# data frame의 column을 생성하는 기본 기능!
excel$GRADE = ifelse(excel$AMT17 >= 500000,
                     "VIP",
                     "NORMAL")
View(excel)

# dplyr은 새로운 column을 생성하기 위해 함수를 제공
# mutate(data frame, 
#       컬럼명1 = 수식1,
#       컬럼명2 = 수식2, ,,,)

# 경기, 여자 기준 / 2017년도 처리금액을 이용하여 / 처리금액의 10%를 가산한 값으로 / 새로운 컬럼 AMT17_REAL 만들고 / 
# AMT17_REAL이 45만원 이상인 경우 / VIP 컬럼을 만들어서 TRUE, FALSE로 나타내자

result <- filter(excel,
                 SEX == "F" & AREA == "경기")%>%
                 mutate(AMT17_REAL = AMT17 * 1.1)  
excel$VIP = ifelse(result$AMT17_REAL >= 450000,
                       "TRUE",
                       "FALSE")
View(result)  

## 한방에 처리하고 싶을 때

result <- filter(excel,
                 SEX == "F" & AREA == "경기")%>%
          mutate(AMT17_REAL = AMT17 * 1.1,
                 VIP = ifelse(AMT17_REAL >=450000,TRUE,FALSE)
                 )
View(result)

# 7. group_by() & summaries()
# group_by(dataframe, 조건 ), summarise(data frame, 조건)

df <- filter(excel,
             AREA == "서울" & AGE > 30) %>%
      group_by(SEX)%>%
      summarise(sum=sum(AMT17), cnt=n())

# sum은 그룹의 합 cnt 는 각각의 개수
df

# 8. plyr package의 join 함수가 dplyr에서는 각 기능별로 독립적인 함수로 제공된다.

# left_join(data frame1, data frame2, by= key)
# right_join()
# inner_join()
# full_join()

# 9. bind_rows(df1,df2) : 두 개의 df의 column명이 같아야 행이 제대로 결합된다.
# column명이 같지 않으면 컬럼을 생성해서 결합이 된다.
df1 <- data.frame(x=c("a","b","c"))
df1

df2 <- data.frame(x=c("d","e","f"))
df2

bind_rows(df1,df2)


df1 <- data.frame(x=c("1","2","3"))
df1

df2 <- data.frame(y=c("1","2","3"))
df2

bind_rows(df1,df2)

###################################################################################################


