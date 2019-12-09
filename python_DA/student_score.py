
## class 정의

class Student:
    # class variable
    
    # 생성자(constructor) 가 나오면 instance variable을 정의한다 (각 객체만 가지는 값 )
    def __init__(self,n,k,e,m): # name,korean,english,math의 인자를 받자 (instance를 가지는 변수에 setting)
        self.sName = n      # student name
        self.sKor = int(k)  # 문자열이기 때문에 숫자로 바꿔준다
        self.sEng = int(e)
        self.sMath = int(m)
            # self.sAvg = (self.sKor + self.sEng + self.sMath)/3 로 쓸 수 있지만 함수로 빼버리자!
        self.sAvg = self.calcul_avg()
              
        
     # method
    def calcul_avg(self):   #self를 괄호에 넣어야 내가 가진 객체 데이터를 활용한다 !
        return (self.sKor + self.sEng + self.sMath) / 3
    
    
    def print_student(self):
        print("학생의 이름은 : {}, 평균은 : {:.2f}".format(self.sName, self.sAvg))
        # 소수점 둘째 자리까지 평균을 출력하자