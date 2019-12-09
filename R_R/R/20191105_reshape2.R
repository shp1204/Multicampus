  # reshape2 package 이용 : 데이터 형태를 바꿀 수 있다
  
  # 가로로 되어있는 데이터를 세로로 바꿀 수 있다.
  # 컬럼으로 저장되어 있는 데이터를 row형태로
  # row로 저장되어 있는 데이터를 컬럼으로 전환
  
  # 2개의 sample file을 이용해보자
  # melt_mpg.csv
  # sample_mpg.csv
  install.packages("reshape2")
  install.packages("stringr")
  library(reshape2)
  library(stringr)
  library(ggplot2)
  library(dplyr)
  library(xlsx)
  
  
  sample_mpg <- read.csv(file="C:/R_R/Data/sample_mpg.csv",
                         sep=",",
                         header = T,
                         fileEncoding = "UTF-8")
  View(sample_mpg)
  
  melt_sample_mpg <- read.csv(file="C:/R_R/Data/melt_mpg.csv",
                              sep=",",
                              header = T,
                              fileEncoding = "UTF-8")
  View(melt_sample_mpg)
  str(melt_sample_mpg)
  class(melt_sample_mpg)
  
  # 두 개의 data frame에 대해서 평균 도시 연비
  
  mean(sample_mpg$cty)  # 18.25
  
  filter(melt_sample_mpg,            # 18.25
         variable == "cty")%>%
        summarise(mean=mean(value))
  
  # 두 개의 data frame에 대해서 평균 연비를 구해서 표시
  # 평균연비 = 도시연비와 고속도로 연비의 평균으로 계산
  
  mutate(sample_mpg,
          average = (cty+hwy)/2)
  # reshape2 package는 수집한 데이터를 분석하기 편한 형태로 가공할 때 사용하는 대표적인 package
  # 2개의 함수만 잘 알아두면된다.
  # 1. melt() : column으로 되어있는 데이터를 row로 바뀐다
  # column을 row형태로 바꾸어 가로로 긴 데이터를 세로로 길게 전환하는 함수
  # (sample_mpg => melt_sample_mpg)
  # melt() : numeric을 포함하고 있는 모든 column을 row로 변환한다
  # 간단한 예를 통해 melt의 동작 방식을 알아보자
  
  airquality
  df <- airquality
  View(df) :#153행*6열
  
  nrow(melt(df)) #918행
  nrow(melt(df,na.rm=T)) #874

  melt(df, 
       id.vars = "Month") #153*5
  
  melt(df, 
       id.vars = c("Month","Day"),
       measure.vars = "Ozone")
  # 녹이지 않고 싶은 column을 정하고/ 녹이고 싶은 column만 설정
 
  
  melt_df <-melt(df, 
       id.vars = c("Month","Day"),
       measure.vars = "Ozone",
       variable.name = "Item",
       value.name = "Item_value")
  
  #melt : 모두 변수와 값(numeric에 대해서만)으로 바꿔줌
  View(melt_df)
  
  # 2. dcast() : data frame cast
  #    row로 되어있는 데이터를 column형태로 전환
  #    각각의 colunm이 겹치지 않아야 한다. 겸치면 진행하기 어려움
  # formula = 명시하고 싶은 함수 사용
  dcast(melt_df,
         formula = Month ~ Item,
         fun=mean,
         na.rm = T)
  # 처음에 받은  csv파일의 내용을 원상복귀 시켜보자
  melt_sample_mpg
  dcast(melt_sample_mpg,
        formula=manufacturer + model + class + trans + year ~ variable,
        value.var = "value")
        
  # 제공된 파일을 이용한 melt 형식의 data frame은 원상복귀 될 수 없다. 
  
  # melt된 데이터를 생성해보자(with mpg)
  df <- mpg
  audi_df <- df%>%
            filter(manufacturer == "audi",
                   model == "a4")
  
  melt_audi_df <- melt(audi_df,
                       id.vars=c("manufacturer",
                                 "model",
                                 "year",
                                 "cyl",
                                 "trans"),
                       measure.vars=c("displ",
                                      "cty",
                                      "hwy"))
  View(melt_audi_df)
  
  dcast(melt_audi_df,
        formula = manufacturer + model + year + cyl + trans ~ variable,
        value.var = "value")









