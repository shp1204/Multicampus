#if구문(조건문) 
# 조건에 따라서 실행되는 code block을 제어할 수 있다.
var1 = 100
var2 = 20

if(var1>var2) {
  #조건문이 참일 때 실행
  cat("참이에요!")
  } else {
  #조건문이 거짓일 때 실행
  cat("거짓이에요!")
  }


#ifelse : Java의 3항 연산자와 같다. 조건 ? 맞으면 1 틀리면 2번째
var1 = 10
var2 = 20

ifelse(var1>var2,"참일경우 선택","거짓일 경우 선택")

# 반복문(for,while)
# for : 반복 횟수만큼 반복 실행
# while : 조건이 TRUE일 동안 반복 실행

for(var1 in seq(1:5)){
  print(var1)
}

idx = 1
mySum = 0
while(idx<10){
 mySum = mySum + idx
 idx = idx+1
 }
mySum
#45

##############로직으로 문제풀기 (제어문 이용 : if,ifelse, for, while)#############3
# 1. 1부터 100 사이에 있는 3의 배수를 출력하자

for( var1 in seq(1:100)){
  if( var1 %% 3 == 0){
    print(var1)
  }
}

# 2. 1부터 100 사이에 있는 prime number()를 출력하자

for(var1 in seq(1:100)){
  if( is.integer(var1%/%2)=T)
  
  
  
}

#for( var1 in seq(1:100)){
  
 # if(var1%/%var2










#######################################################################################
# 사용자 정의 함수 (User Define Function)
# 함수명 = function(x) {...}
# 입력받은 숫자를 제곱해서 돌려주는 함수를 하나 만들어보자

myFunc = function(x){
  x = x*x
  return(x)
}

var1 = myFunc(5)


var1 = c(1:10)
sum(var1)



# sum 함수와 동일한 역할을 하는 mySum을 만들어보자 
# vector를 입력으로 받아서 합을 구하는 함수

mySum = function(x){
  result = 0
  for(t in x){
  result = result + x
}
return(result)
}
var1=c(1:10)
mySum(var1)

#######################3
mySum = function(x)
  result = 0
for(var1 in c(1:10)){
  result = result + x
}
mySum(var2)

#######################################################################################





