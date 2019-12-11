# Git branch

> Git 개발 흐름에서 branch는 매우 중요하다 ! 
>
> 독립적인 개발 환경을 제공하여 동시에 다양한 작업을 진행할 수 있도록 만들어준다.
>
> 일반적으로 브랜치의 이름은 "해당 작업"을 나타낸다.

## 1. 기초 명령어

```bash
$ git branch #branch 목록 확인
$ git branch {브랜치이름} #{브랜치이름} 생성
$ git checkout {브랜치이름} #{브랜치이름} 으로 이동
$ git branch -d {브랜치이름} #{브랜치이름} 삭제

$ git checkout -b {브랜치이름} #{브랜치이름} 생성 및 이동
```

### branch 병합

```bash
(master) $ git merge feature
# master 브랜치로 feature 브랜치 이력 가져오기 ( 병합 )
```

### 상황 1. fast-foward

1. feature/test branch 생성 및 이동

   ```bash
   $ git checkout -b feature/test
   ```

2. 작업 완료 후 commit

   ```bash
   $ touch test.txt
   $ git add .
   $ git commit -m "test기능 개발 완료"
   ```
   
   ```bash
   $ git log --oneline
   ### 결과 붙여넣기 ###
   ```
   
   


3. master 이동

   ```bash
   $ git checkout master
   $ git log --oneline
   ### 결과 ###
   ```
   
   


4. master에 병합

   ```bash
   $ git merge feature/test
   ### 결과 ###
   ```
   
   


5. 결과 -> fast-foward (단순히 HEAD를 이동)

   ```bash
   $ git log --oneline
   ### 결과 ###
   ```

   

6. branch 삭제

   ```bash
   $ git branch -d feature/test
   ```
   
   
   
   

---

### 상황 2. merge commit

> feature 브랜치에서 작업하는 동안
>
> master 브랜치에서 다른 이력이 추가된 경우

1. feature/signout branch 생성 및 이동

   ```bash
   $ git checkout -b feature/signout
   ```

   

2. 작업 완료 후 commit

   ```bash
   $ touch signout.txt
   $ git add .
   $ git commit -m "complete signout"
   ```

   

3. master 이동

   ```bash
   $ git checkout master
   ```

   

4. *master에 추가 commit 이 발생시키기!!*

   * **다른 파일을 수정 혹은 생성하세요!**

   ```bash
   $ touch master.txt
   $ git add .
   $ git commit -m "update master"
   $ git log --oneline
   ##결과##
   ```

   

5. master에 병합

   

6. 결과 -> 자동으로 *merge commit 발생*

   

7. 그래프 확인하기

   

8. branch 삭제

   

---

### 상황 3. merge commit 충돌

1. feature/board branch 생성 및 이동

   ```bash
   $ git checkout -b hotfix/text
   ```

   

2. 작업 완료 후 commit

   ```bash
   # 직접 test.txt 파일 수정
   $ git add .
   $ git commit -m 'hotfix test'
   $ git log --oneline
   ##결과##
   ```
   
   


3. master 이동

   ```bash
   $ git checkout master
   ```
   
   


4. *master에 추가 commit 이 발생시키기!!*

   * **동일 파일을 수정 혹은 생성하세요!**

     ```bash
     # test.txt 수정
     $ git add .
     $ git commit -m 'master test'
     ```

     

   

5. master에 병합

   ```bash
   (master) $ git merge hotfix/test
   ### 결과 ####
   # merging하다가 멈췄다 ! 
   ```
   
   


6. 결과 -> *merge conflict발생*

   ```bash
   # 충돌 났을 때의 결과
   ```
   
   


7. 충돌 확인 및 해결

   visual studio code에서 확인하고 내가 선택할 수 있다.


8. merge commit 진행

    ```bash
    $ git add .
    $ git commit
```
   
   * vim 편집기 화면이 나타납니다.
   
   * 자동으로 작성된 커밋 메시지를 확인하고, `esc`를 누른 후 `:wq`를 입력하여 저장 및 종료를 합니다.
      * `w` : write
      * `q` : quit
      
   * 커밋이  확인 해봅시다.
   
9. 그래프 확인하기

    


10. branch 삭제

    ```bash
    $ git branch -d hotfix/test
    ```
    
    