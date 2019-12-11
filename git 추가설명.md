## git 추가설명

# 1. commit

> commit을 통해 이력을 확장하면 hash 값이 부여되며 이 값을 통해 동일한 커밋인지를 확인한다.
>
> ```bash
> # WD 연결 시, staging area 비어있을 때
> # 변경사항 x
> $ git commit
> nothing to commit, working tree clean
> # WD 변경 O, staging area 비어있을 때
> $ git commit
> untracked files: lee.txt
> nothing added to commit but untracked files present
> ```
>
> 

### commit  메세지  작성하기[부제  : vim 활용법]

```bash
$ git commit

```

* 편집모드(i) : 문서 편집 가능

  => 아래쪽에 끼워넣기가 뜬다

  => commit 메세지는 짧게하되, 밑에 설명을 길게 할 때 사용할 수 있다.

  => esc 누르면 명령모드로 나가진다.

* 명령모드(esc) 

  => dd : 하나의 행을 삭제할 수 있다.

  => :wq    :  저장 및 종료( w : write 저장, q : quit 종료)

  => :q! : 강제 종료(q : quit, ! : 강제)

### log 활용하기

```bash
$ git log
$ git log --oneline
$ git log -1
$ git log -1 --oneline
$ git log --oneline --graph
```

몇 개의 이력을 확인할 때  :  해당 개수의 수를 입력하면된다

git log --oneline은 가장 최근 기록, hash도 한개만 보여준다

### 

* HEAD : 현재 작업하고 있는 커밋 이력 및 브랜치에 대한 포인터

```bash
a26b82b(HEAD -> master) Add lee.txt
# master branch에 있고,
# a26b82b 커밋의 상태에 있다.
```

* 예시 ) 

  ```bash
  a26b82b(HEAD -> master) Add lee.txt
  Sed4f94(feature/signout) Complete signout
  97871d5 (origin/master) 집 - main.html
  # 나는 master branch에서 a26b82b 커밋을 했고,
  # feature/signout 브랜치는 Sed4f94 이력이고,
  # 원격저장소(origin/master)는 97871d5 이다.직전 커밋 메세지 수정
  ```



### 직전 커밋 메세지 수정

* > 아래의 명령어는 **커밋 이력**을 변경하기 때문엥 조심해야한다. 공개된 저장소에(원격 저장소) 이미 push된 이력이라면 절대 해서는 안된다.

  ```bash
  $ git commit --amend
  ```

### 커밋 시 특정 파일을 빠뜨렸을 떄

만약, staging area에 특정 파일(omit_file.txt)을 올리지 않아서 커밋이 되지 않았을 때!

```bash
$ git add .
$ git commit --amend
```



##  2. staging area

* 커밋 이력이 있는 파일을 수정한 경우

  ```bash
  $ git status
  On branch master
  Changes not staged for commit: 
  # wd에서 작업을 했다 => staging area에 아직 안 올려서 "not staged for commit" 이라고 뜬다 => staging area에 추가해줘야한다 => add 해주자!
    (use "git add <file>..." to update what will be committed)
  # wd에서 방금 한 작업을 수행하지 않으려면 => git restore 
  # commit 이후에 변경된 사항을 없애버린다.
    (use "git restore <file>..." to discard changes in working directory)
          modified:   1.txt
  # 변경할 게 없다 => commit에 추가될 변화가 없다.
  no changes added to commit (use "git add" and/or "git commit -a")
  ```

  ```bash
  $ git add .
  $ git status
  On branch master
  # commit이 될 변화
  # commit 명령이 있을 때, 아래의 내용이 이력에 남는다.
  Changes to be committed:
    # 만약에 방금 add한걸 unstage하고 싶으면 => git restore을 입력해! 
    (use "git restore --staged <file>..." to unstage)
          modified:   1.txt
          new file:   k.txt
  ```

  

* 커밋 이력이 없는 파일을 수정한 경우

  ```bash
  $ git status
  On branch master
  Untracked files:
    (use "git add <file>..." to include in what will be committed)
          k.txt
  
  nothing added to commit but untracked files present (use "git add" to track)
  
  ```

### add 취소하기

```bash
$ git restore --staged 1.txt
```

* 참고 ) 구버전 git에서는 아래의 명령어를 사용해야 한다.

  ```bash
  $ git reset HEAD <file>
  ```

### Working Directory 변화 삭제하기

```bash
$ git restore <file>
```

* 참고 ) 구버전 git에서는 아래의 명령어를 사용해야 한다.

  ```bash
  $ git checkout -- <file>
  ```

  





















