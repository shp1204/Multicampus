# -> 입력문자열의 길이는 7 or 9 or 11
# 중앙 숫자를 기준으로 앞과 뒤의 숫자를 분리한 후 분리된 두 수를 거꾸로 뒤집어서 두 수의 차를 구한다
#
# 예) 7648623 -> 764 623(가운데 수는 버림) -> 467 326 -> 467-326 = 141
# 변수 두개, 인덱스로 추출 시 c사용, 거꾸로 도출? 
# 예) 764862 -> 764 620(가운데 수는 버림) -> 467 026 -> 467-26 = 441

# 문자를 숫자로 전환 #문자열을 벡터 7개로 나눠줄 수 없나

library(stringr)
input = "7648620"
list_input = str_extract_all(input,"[0-9]")
int_input = as.integer(list_input[[1]])
len_input=length(int_input)



if(len_input %% 2 == 1 & len_input >= 7 & len_input <=11 ){
  
  if(len_input == 7){
    
    first = int_input[3]*100 + int_input[2]*10 + int_input[1]
    second = int_input[7]*100 + int_input[6]*10 + int_input[5]
    result = first-second
    
  } else{
    
      if(len_input == 9){
        first = int_input[4]*1000 + int_input[3]*100 + int_input[2]*10 + int_input[1]
        second = int_input[8]*1000 + int_input[7]*100+ int_input[6]*10 + int_input[5]
        result = first-second
      }else{
          first = int_input[5]*10000 +int_input[4]*1000 + int_input[3]*100 + int_input[2]*10 + int_input[1]
          second = int_input[11]*1000 + int_input[10]*100+ int_input[9]*10 + int_input[8] +int_input[7]
          result = first-second
      }}
  print(result)
  
  }  else{print("7-11자리의 수를 입력하세요")}



