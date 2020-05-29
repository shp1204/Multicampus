1. 내가 업로드할 파일/ 폴더가 기존에서 어떤게 변경되었는지 확인하자

   => git status

2.  변경된 상태를 확인 했으면 add해서 목록에 추가하자

   => 전부 다 추가할 때 ?  git add .

   =>  폴더 한개만 추가할 때 ?  git add R_R/

3. 목록의 commit을 확정지어보자

   => git commit -m "R_R 추가"

4. 업로드해보자

   => git push origin master

5.  만약에 이전에 했던 것을 되돌리고 싶다면???

   => git reset HEAD~4 ( 4번째 명령 전의 상태로 돌아가자 )