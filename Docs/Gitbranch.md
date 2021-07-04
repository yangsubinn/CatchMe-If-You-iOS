## 🌈 git-flow
```
1. ZenHub에서 Issue를 생성한다.
2. feature Branch를 생성한다.
3. Add - Commit - Push - Pull Request 의 과정을 거친다.
4. Pull Request가 작성되면 작성자 이외의 다른 팀원이 Code Review를 한다.
5. Code Review가 완료되면 Pull Request 작성자가 develop Branch로 merge 한다.
6. 종료된 Issue와 Pull Request의 ZenHub를 관리한다.

```

- `main` : 개발이 완료된 산출물이 저장될 공간
- `develop` : feature 브랜치에서 구현된 기능들이 merge될 브랜치
- `feature` : 기능을 개발하는 브랜치, 이슈별/작업별로 브랜치를 생성하여 기능을 개발한다
- `release` : 릴리즈를 준비하는 브랜치, 릴리즈 직전 QA 기간에 사용한다
- `hotfix` : 버그를 수정하는 브랜치

<br/>

## 🌈 Branch Naming Rule

- Branch를 생성하기 전 Issue를 먼저 작성합니다. 
- Issue 작성 후 생성되는 번호와 Issue의 간략한 설명 등을 조합하여 Branch의 이름을 결정합니다. 
- `<Prefix>/<Issue_Number>-<Description>`의 양식을 따릅니다.

  **예시**
  ```
  main
  develop/v1.0.0
  feature/10-sign-up
  release/v1.0.0
  hotfix/11-main-activty-bug
  ```

<br/>

## 🌈 Issue Naming Rule

- `[<PREFIX>] <Description>` 의 양식을 준수하되, Prefix는 협업하며 맞춰가기로 합니다. 
- 또한 Prefix는 대문자를 사용합니다.

    **예시**

    ```
    [FEAT] 회원가입 구현
    [DEBUG] MainActivity 버그 수정
    [STYLE] 폰트 변경
    ```
    
<br/>

## 🌈 Commit Message Convention

- [Fix] : 버그, 오류 해결
- [Chore] : 코드 수정, 내부 파일 수정
- [Correct] : 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용합니다.
- [Add] : Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 View 생성
- [Feat] : 새로운 기능 구현
- [Del] : 쓸모없는 코드 삭제
- [Docs] : README나 WIKI 등의 문서 개정
- [Mod] : storyboard 파일만 수정한 경우
- [Move] : 프로젝트 내 파일이나 코드의 이동
- [Rename] : 파일 이름 변경이 있을 때 사용합니다.
- [Improve] : 향상이 있을 때 사용합니다.
- [Refactor] : 전면 수정이 있을 때 사용합니다

    **예시**

    ```
    [접두어] 내용(#이슈번호)<br>
    세부내용<br>
    각주<br>

    ```
<br/>
<br/>

[참고](https://github.com/TeamMyDaily/4most-Android/wiki/1.-Git-%EC%82%AC%EC%9A%A9%EB%B2%95)
