install.packages("foreign")
library(foreign)

# 필요한 package를 미리 로딩
library(stringr)
library(ggplot2)
library(dplyr)
library(xlsx)

rm(list=ls())

raw_data_file = "C:/R_R/Data/Koweps_hpc10_2015_beta1.sav"
raw_welfare <- read.spss(file=raw_data_file,
                         to.data.frame = T)
welfare <- raw_welfare
str(welfare)

# 컬럼명 변경하기
welfare <- rename(welfare,
                  gender=h10_g3, # 성별 
                  birth=h10_g4,  # 출생연도
                  marriage=h10_g10, # 혼인상태
                  religion=h10_g11, # 종교유무
                  code_job=h10_eco9, # 직업코드
                  income=p1002_8aq1, # 평균월급
                  code_region=h10_reg7) # 지역코드

#----------------------------------------------------------------------
 
### 1. 성별에 따른 월급 차이

# 이상치 확인
table(welfare$gender)
# 1=남자, 2=여자
welfare$gender = ifelse(welfare$gender == 1,
                        "male",
                        "female")
# 데이터타입 확인
class(welfare$income)
# 기본 통계량 확인
summary(welfare$income)

# 이상치 처리
welfare$income = ifelse(welfare$income %in% c(0,9999),
                        NA,
                        welfare$income)
# NA개수 확인
table(is.na(welfare$income))

# 사용할 데이터를 골라내보자
gender_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(gender) %>%
  summarise(mean_income = mean(income))
gender_income = as.data.frame(gender_income)
gender_income

# 그래프로 그리기
ggplot(data=gender_income,
       aes(x=gender,
           y=mean_income)) +
  geom_col(width=0.5) + 
  labs(x="성별",
       y="평균 월급",
       title="성별에 따른 월급",
       subtitle="남성이 여성보다 150만원 많이 번다!!",
       caption="Example 1 Fig.")

#-------------------------------------------------------------------

### 2. 나이와 월급의 관계 파악해보자, 몇 살 때 월급을 가장 많이 받을까?

# 출생연도 파악하기
class(welfare$birth)
summary(welfare$birth)
# 나이 결측치 확인
table(is.na(welfare$birth)) 
# 이상치 확인
welfare$birth = ifelse(welfare$birth == 9999,
                       NA,
                       welfare$birth)
table(is.na(welfare$birth))

# 나이 column 생성
welfare <- welfare %>%
  mutate(age = 2015 - birth + 1)

# 나이별로 수입평균 계산
age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))
head(age_income)
age_income = as.data.frame(age_income)

# 평균 월급에 따라 내림차순했을 때 첫번째 출력
age_income %>% arrange(desc(mean_income)) %>%
  select(age) %>% head(1)

# 그래프로 그리기
ggplot(data=age_income,
       aes(x=age,
           y=mean_income)) + 
  geom_line()

#-----------------------------------------------------------------
# 3. 연령대에 따른 월급 차이
# 30대 미만 : 초년(young)
# 30~59세 : 중년(middle)
# 60세 이상 : 노년(old)
# 위의 범주로 연령대에 따른 월급 차이 분석

# 연령대 column 생성
welfare <- welfare %>%
  mutate(age_group = ifelse(age < 30,
                            "young",
                            ifelse(age<60,
                                   "middle",
                                   "old")))

# 연령대별 평균 수입 출력
age_group_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age_group) %>%
  summarise(mean_income = mean(income))
age_group_income = as.data.frame(age_group_income)
age_group_income

ggplot(data=age_group_income,
       aes(x=age_group,
           y=mean_income)) + 
  geom_col(width=0.5) + 
  scale_x_discrete(limits=c("young","middle","old"))

#---------------------------------------------------------------
# 4. 연령대 및 성별의 월급 차이를 알아보아요
# 초년 여자, 초년 남자
# 중년 여자, 중년 남자
# 노년 여자, 노년 남자

# 위에서 나눈 그룹 사용하기
gender_age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age_group, gender) %>%
  summarise(mean_income = mean(income))
gender_age_income = as.data.frame(gender_age_income)

plot.new()
# 누적 차트로 표현해야 될 듯 해요!!
ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income)) +
  geom_col(aes(fill=gender))

# 누적차트를 이렇게도 만들 수 있어요!
ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income,
           fill=gender)) +
  geom_col(position="dodge")

#-------------------------------------------------
# 5. 나이 및 성별에 따른 월급 차이 분석

welfare <- welfare %>%
  mutate(age = 2015 - birth + 1)

# 나이별로 수입평균 계산
age_gender_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, gender) %>%
  summarise(mean_income = mean(income))

head(age_gender_income)

#-------------------------------------------------
# 6. 직업별 월급

welfare <- welfare %>%
  mutate(job_group)

# 직업별 평균 수입 출력
job_group_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(code_job) %>%
  summarise(mean_income = mean(income))
job_group_income = as.data.frame(job_group_income)
job_group_income

# 코드북 불러오기
code_book <- read.xlsx(file.choose(),sheetIndex=2,encoding = "UTF-8")
result<-left_join(job_group_income,code_book,by="code_job")
View(result)

#-------------------------------------------------

# 7. 종교 유무에 따른 이혼률

# 종교가 없는 사람의 이혼율 : 7.0
# 종교가 있는 사람의 이혼율 : 5.6
# 1,2,4면 group_marriage => marriage
# 3이면 group_marriage => divorce


# 이혼여부에 관한 column 생성
welfare <-welfare %>%
  mutate(group_marriage 
         = ifelse(marriage%in%c(1,2,4),
                  "marriage",
                  ifelse(marriage == 3,
                         "divorce",
                         NA)))
table(welfare$group_marriage)

# 종교유무에 따른 이혼여부 출력
religion_divorce <- welfare %>%
  filter(!is.na(group_marriage))%>%
  group_by(religion, group_marriage)%>%
  summarise(n=n())%>%
  mutate(total_n = sum(n))%>%
  mutate(pct = round(n/total_n*100,1))

religion_divorce
