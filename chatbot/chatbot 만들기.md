# 1. visual studio code 들어가자

작업할 폴더 => 오/마 => visual studio code열고 => ctrl + shift + p=> 입력 => ctrl + ` 

## 1) 가상환경 만들기

```bash
$ python -m venv venv
# venv : venv라는 이름의 가상환경을 만들자
```

venv => scripts => activate 에 들어가면 진입성공

![image-20191211142325041](C:\Users\student\AppData\Roaming\Typora\typora-user-images\image-20191211142325041.png)

=> 매번 껐다 켤 때마다 번거로우니까 확장 프로그램을 하나 설치해서 간편하게 들어올 수 있도록 하자

1)  왼쪽 제일 아래의 아이콘 클릭 => python => 젤 위에거 설치

2) ctrl+shift+p => interpreter 입력 => 우리가 만든 venv 를 경로로 설정한다

3) 껐다 켜도 ctrl+ `을 누르면 우리가 잡아둔 경로(venv)로 이동한다

4) 빠져나갈 때는 deactivate

5) gitignore.io에서 : visualstudiocode, venv, flask

생성해서 복사

5) terminal에 vi .gitignore 입력후 붙여넣기