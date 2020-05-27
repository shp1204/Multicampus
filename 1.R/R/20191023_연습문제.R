# 1. 4,6,5,7,10,9,4 데이터를 이용해서 숫자형 vector를 생서하세요
x = c(4,6,5,7,10,9,4); x

# 2. 아래의 두 벡터의 연산 결과는? #Recycling
x1 = c(3,5,6,8)
x2 = c(3,3,4)
x1;x2;
x1+x2
#결과 : 6  8 10 11

# 3. data frame을 이용하여 다음의 결과를 도출하세요
Age = c(22,25,18,20)
Name = c("James","Mathew","Oliver","Stella")
Gender = c("M","M","F","F")

#출력형태 Age Name Gender
######1   22  James M
######2   25 Mathew M

df=data.frame(Age=Age,Name=Name,Gender=Gender)
df[c(1:2),]

subset(df,Gender == "M")
subset(df,Gender != " F")
subset(df,Age >= 22)

# 4. 아래의 구문을 실행한 결과는?
x = c(1,2,3,4,5)
(x*x)[!is.na(x) & x > 2]
#-> (1 4 9 16 25)에서 
#is.na(x)가 아니고 ( T T T T T )
#x가 2보다 큰 값   ( F F T T T )
# 3,4,5에 대해서 제곱값!!

#별개로
#(1 4 9 16 25)[(F F T T T)] #Fancy indexing을 하면 TRUE만 남기고 FALSE는 다 날림
#반드시 length가 같아야한다.


# 5. 다음의 계산 결과는? #Fancy indexing
x = c(2,4,6,8)
y = c(T,T,F,T)
sum(x[y])
#결과 : 14

# 6. 제공된 vector에서 결측치(NA)의 개수를 구한는 코드를 작성하세요
var1=c(34,55,89,45,NA,22,12,NA,99,NA,100)
is.na(var1)                                 #NA인가요? 맞으면 T
sum(is.na(var1))                            #합하면 T=1, F=0으로 계산

# 6-1. 결측치를 제외한 평균을 구하세요      #fancy indexing 
!is.na(var1)
mean(var1[(!is.na(var1))])                  #57

# 7. [복습] 2개의 vector를 결합하려한다
x1 = c(1,2,3)
x2 = c(4,5,6)
c(x1,x2)
# 1 2 3 4 5 6 

# vector를 결합해서 matrix를 만들어보자
rbind(x1,x2)
cbind(x1,x2)

# 8. [복습] 다음 코드의 실행 결과는?        #data type의 우선순위
x = c("Blue",10,TRUE,20)
is.character(x)                             #TRUE

