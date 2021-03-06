myResult = 200
myResult <- 300
400 -> myResult
myResult
print(myResult)
print("결과값은 : " myResult) #. 플러스 연산을 문자, 숫자 연결을 위해 사용할 수 없다. R에서는 숫자를 더할 때만 플러스 연산을 사용한다
#, 여러개의 값을 출력하려면 cat()을 사용한다
cat ("결과값은 : " , myResult)

##############################################
#. 멤버를 이요한 변수 선언
goods.price = 3000
goods.code = "001"
goods.name = "냉장고"

##############################################
# 출력되는 형식
myResult
# [1] 400 으로 출력된다고 하면, [1]은 출력물의 인덱스임
mySeq = seq(100) # 1부터 100까지 1씩 증가하는 숫자의 집합
# seg : 순서, 순열 (시퀀스)
mySeq
#  [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17
[18]  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34
[35]  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51
[52]  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68
[69]  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85
[86]  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100
# 맨 앞의 숫자는 출력되는 인덱스의 순서를 이야기함
mySeq = seq(5,100) # 5부터 100까지 1씩 증가하는 숫자의 집합
mySeq = seq(1,100, by = 2)
mySeq
# [1]  1  3  5  7  9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 [26] 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 81 83 85 87 89 91 93 95 97 99
