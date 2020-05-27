

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

* > 아래의 명령어는 메세지도 변경하고 **커밋 이력**을 변경하기 때문에 조심해야한다. 공개된 저장소에(원격 저장소) 이미 push된 이력이라면 절대 해서는 안된다.

  ```bash
  $ git commit --amend
  ```

### 커밋 시 특정 파일을 빠뜨렸을 떄

만약, staging area에 특정 파일(omit_file.txt)을 올리지 않아서 커밋이 되지 않았을 때!

```bash
$ git add .
$ git commit --amend
```

```bash
git commit --amend를 입력

새로운 창이 나오는데 거기에서 내용을 바꾸려면 i를 입력한다.
그러면 내용을 변경할 수 있다.
내용을 변경할 때 첫 줄 다음에 한 줄 띄어쓰고 써야한다.
다 쓰고나서는 esc + :wq 하면 나가진다.
```

# 2. staging area

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
  # git add : 걍 add
  # git commit -a : tracked된 이력이 있는 경우에 add와 commit을 동시에
  # git commit -am "blabla"
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
  # tracking 되고 있지 않는 파일 => commit에 한 번도 관리된적이 없다.
  Untracked files:
    (use "git add <file>..." to include in what will be committed)
          k.txt
  # staging area가 비어있고, tracking 되고 있지 않는 파일도 있다.
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

> git에서는 모든 commit된 내용은 되돌릴 수 있다. 다만, 아래의 wd내용을 삭제하는 것은 되돌릴 수가 없다.

```bash
$ git restore <file>
```

* 참고 ) 구버전 git에서는 아래의 명령어를 사용해야 한다.

  ```bash
  $ git checkout -- <file>
  ```

# 3. git merge와 stash

merge 하려고 했더니 오류가 발생한다 !

```bash
$ git merge test
# local 변화를 병합해서 덮어쓰려고하는데 @!!
error: Your local changes to the following files would be overwritten by merge:
        a.txt
# 변경 이력을 추가하거나 or 임시저장공간에 맡겨놔!
Please commit your changes or stash them before you merge.
Aborting
Updating 8e7392f..ee27283
```

### stash

> 변경사항을 임시로 저장해두는 공간이다.

### git  stash : 임시 저장하기

```bash
$ git stash
Saved working directory and index state WIP on master: 8e7392f a.txt
```

### git stash list : 저장되었는지 확인하기

```bash
$ git stash list
stash@{0}: WIP on master: 8e7392f a.txt
```

### git stash pop : 저장해둔거 꺼내오기

```bash
$ git stash pop
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   a.txt

no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (1bc7a2a197144141b638fd07d0703a631c103d17)

```

### [ merge 시 충돌 해결 방법 ]

git merge test => 오류 발생 => git stash => git merge test => git stash pop => 끝 !



# 4. Reset vs Revert

> commit 이력을 되돌리는 작업을 한다.

* reset : 이력을 삭제한다.

  => --mixed (기본옵션) : 해당 commit 이후 변경사항 staging area에 보관

  => --hard : 해당 commit 이후 변경사항 모두 삭제 "**주의**"

  => --soft : 해당 commit 이후 변경사항 및 working directory 내용까지 모두 보관

  

  ```bash
  $ git log --oneline
  76a9ebf (HEAD -> master) d
  ee27283 (test) a.txt test
  8e7392f a.txt
  ```

* revert : 되돌렸다는 이력을 남긴다.

  ```bash
  $ git log --oneline
  f105058 (HEAD -> master) Revert "Revert "a.txt test""
  3eace0f b.txt
  23575ce Revert "a.txt test"
  76a9ebf d
  ee27283 (test) a.txt test
  8e7392f a.txt
  ```

  

















