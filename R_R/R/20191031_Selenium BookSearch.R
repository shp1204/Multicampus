##################################################################################
# selenium을 이용한 동적 page scrping

# selenium을 R에서 사용할 수 있도록 도와주는 package를 설치해야한다

install.packages("RSelenium")
library(RSelenium)

# R 프로그램에서 selenium server에 접속한 후 remote driver 객체를 return 받자.

remDr <- remoteDriver(remoteServerAddr="localhost",
             port=4445,
             browserName="chrome")
remDr
# 접속이 성공하면 
# selenium 서버를 이용해서 chrome을 자동화 시켜준다
# driver를 통해 selenium은 크롬 브라우저의 자동화 가능


# browser open
remDr$open()

# open된 browser의 주소를 변경하자
#"" 안에 내가 들어갈 url입력
remDr$navigate("http://localhost:8080/bookSearch/index2.html")

# 입력상자를 찾자 #css selector를 이용한다+ text type을 찾는다 
inputBox <- remDr$findElement(using="css",
                           "[type=text]")

# 찾은 입력상자에 검색어를 넣는다
inputBox$sendKeysToElement(list("여행"))

# 검색하기를 클릭한다
btn <- remDr$findElement(using="css",
                         "[type=button]")

# 찾은 버튼에 click event를 발생
btn$clickElement()

# 만들어진 html을 데려와서 프로그램적으로 찍거나 데이터 프레임으로 만들자
# selector나 xpath를 이용해 추출하자

# AJAX 호출이 발생해서 출력된 화면에서 필요한 내용을 추출
# findElement와 Elements는 다르다@!! s는 여러개 
li_element =  remDr$findElements(using="css",
                                "li")

# 이렇게 얻어온 element 각각에 대해서 함수를 호출하자
# sapply : 함수를 요소 각각에 대해 실행하자  어떤함수? => function함수
# getElementText : element안에있는 글자를 데려오자
myList <- sapply(li_element,function(x){
  x$getElementText()
})

for(i in 1:length(myList)){
  print(myList[[i]])
}












