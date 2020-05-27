@@@ 데이터 타입의 우선순위 : character -> complex -> numeric -> logical
@@@ TRUE와 FALSE는 대문자로 !
@@@ 데이터타입조사 : mode
@@@ 데이터타입확인 : is.
@@@ 데이터타입변환 : as.
@@@ 패키지 불러오기 : library, require
@@@ 패키지 삭제 : remove
@@@ 패키지 경로확인 : libPaths
@@@ 현재 작업중인 위치 : getwd
@@@ 작업위치 변경 : setwd

mySeq = seq(100)
mySeq = seq(5,100)
mySeq = seq(1,100,by=2)
print(mySeq)

var1 = 100
var2 = 3
var1%/%var2 
var1%%var2 
var1 == var2
var1 != var2

myVector <- c(TRUE,10,20)
myVector
myVector2 <- c("hi",3,2,TRUE)
myVector2

------------------------------------------------------------------------------------
  
@@@ vector 첨자 index는 1로 시작
@@@ [start : end] 두 수 모두 inclusive
@@@ 등차수열 : seq
@@@ 반복 : rep
@@@ 데이터 개수 알기 : length
@@@ 데이터 추출 하기 : index
@@@ index 추출시 마이너스 입력하면 그 값을 제외하고 나머지를 출력함
@@@ 데이터 이름 지정 : names
@@@ vector연산 시, 개수가 맞지 않을때? 그냥 연산됨
@@@ 합집합 : union
@@@ 교집합 : intersect
@@@ 차집합 : setdiff
@@@ 크기,순서, 내용이동일할 때만 출력 : identical
@@@ 크기, 순서 상관x, 내용만 동일 : setequal 

var1 = rep(1:3,times=3)
var1
var2 = rep(1:3,each=3)
var2

var1 = 1:3
var2 = 4:6
var1*var2
--------------------------------------------------------------------------
@@@ matrix 값이 열 기준으로 채워진다
@@@ 행 개수 설정 : nrow
@@@ 행 기준으로 값을 채울 때 : byrow=TRUE
@@@ 두 벡터를 행끼리 연결 : rbind
@@@ 두 벡터를 열끼리 연결 : cbind
@@@ apply(X=행렬,MARGIN=기준,FUN=함수명)
@@@ MARGIN=1이면 행기준, 2면 열기준
@@@ 전치행렬 : t
@@@ 행렬곱 : %*%
@@@ 역행렬 : solve

var1 = matrix(c(1:21),nrow=3,ncol=7)
var1
apply(X=var1, MARGIN=1, FUN=max)

var1 = matrix(c(1:6), ncol=3)
var2 = matrix(c(1,-1,2,-2,1,-1),ncol=3)
var3 = matrix(c(1,-1,2,-2,1,-1),ncol=2)
var1
var3
t(var1)
var1%*%var3
-----------------------------------------------------------------------
# 09부터