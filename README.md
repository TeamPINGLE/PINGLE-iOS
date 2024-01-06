![1](https://github.com/TeamPINGLE/PINGLE-iOS/assets/109775321/fb6a1db3-cb9e-4f0e-b530-d786da5e820e)

---------
![2](https://github.com/TeamPINGLE/PINGLE-iOS/assets/109775321/ce24b8f5-8761-4364-84ef-0f1d56ff37ea)
~~~
Ready to PINGLE?
가볍고 재미있는 모임 문화, 핑글과 함께 만들어요!
~~~

---------
![3](https://github.com/TeamPINGLE/PINGLE-iOS/assets/109775321/8a68fbdf-f3a8-41bd-9bee-5227e7124ab3)
![리드미 3](https://github.com/TeamPINGLE/PINGLE-iOS/assets/109775321/66b696c9-7762-4887-9ecc-991f932e4826)

| 👑 [정채은](https://github.com/chaentopia) | [방민지](https://github.com/bangMinjI98) | [강민수](https://github.com/alstn38) |
| :--------: | :--------: | :--------: |
| 홈 지도 뷰 | 번개 개최 뷰 | 온보딩, 마이페이지 |
---------

![4](https://github.com/TeamPINGLE/PINGLE-iOS/assets/109775321/f53c55cf-e617-465d-84a6-5deca9de8b5a)
~~~
기본적으로 swiftlint를 통해 코드를 관리합니다. 또한 스타일쉐어의 코드 컨벤션을 따릅니다.
~~~
``` javascript
# 코드에 비활성화 하고 싶은 룰이 있다면 해당 코드 바로 상단에
# swiftlint:disable [룰 이름]과 같이 적어주세요

# ex:
# swiftlint:disable colon
# let noWarning :String = ""
 
# 기본 활성화된 룰 중에 비활성화할 룰들을 지정
disabled_rules:
- trailing_whitespace # 후행 공백
- identifier_name # 식별자 이름
- shorthand_operator # 속기 연산자
- function_body_length # 함수 바디 길이
- nesting # 중첩
- cyclomatic_complexity # 순환 복잡도

# 기본 룰이 아닌 룰들 활성화
opt_in_rules:
- empty_count # count보다 isEmpty 사용
- empty_string # == 0 보다 isEmpty 사용
- empty_collection_literal # == [] 보다 isEmpty 사용
- collection_alignment # 정렬

# 린트 과정에서 무시할 파일 경로. `included`보다 우선순위 높음
excluded:
- Pingle-iOS/Application
- Pingle-iOS/Pods
- Pods
```

기타 Code Convention은 아래 링크에서 확인할 수 있습니다.
[PINGLE-iOS Code Convention](https://pinglepingle.notion.site/Code-Convention-7fb87884a1314a34a1a7e48bf9a6d085?pvs=4)

---------
![6](https://github.com/TeamPINGLE/PINGLE-iOS/assets/109775321/d2f0a417-555a-4eae-a620-ead20d23845f)
- main 브랜치 : 릴리즈 버전 관리
- develop 브랜치 : 개발 작업용

~~~
1. 기능 개발, 수정, 네트워크, 리팩토링, 세팅 등 기타 이슈에 맞는 이슈 템플릿 설정 후 이슈 생성
2. develop 브랜치에서 이슈 브랜치 생성
3. 이슈 브랜치에서 작업
4. 작업 완료 후 PR 작성, 체크리스트를 통해 어떤 것을 해결한 이슈인지 명시
5. 뱅크샐러드 코드리뷰 컨벤션에 맞춰 approve 1개 이상 받은 후 머지
~~~

기타 Git Convention은 아래 링크에서 확인할 수 있습니다.
[PINGLE-iOS Git Convention](https://pinglepingle.notion.site/Git-Convention-bd4adf3b86e449f09c8a9daecfd44095?pvs=4)

---------
![5](https://github.com/TeamPINGLE/PINGLE-iOS/assets/109775321/2d9a4f9b-bd9d-4ff4-9dd9-382b743bcf21)
```
📦 Pingle-iOS
┣ 📜 .swiftlint
┣ 📂 Storyboard
┃ ┣ 📜 LaunchScreen
┃
┣ 📂 Application
┃ ┣ 📜 Appdelegate
┃ ┣ 📜 SceneDelegate
┃
┣ 📂 Global
┃ ┣ 📂 Extension
┃ ┣ 📂 Literals
┃ ┃ ┣ 📜 ImageLiterals
┃ ┃ ┣ 📜 StringLiterals
┃ ┃
┃ ┣ 📂 Resources
┃ ┃ ┣ 📂 Font
┃ ┃ ┣ 📜 Font
┃ ┃ ┣ 📜 Color
┃ ┃ ┣ 📜 Assets
┃ ┃ ┣ 📜 Info.plist
┃ ┃
┃ ┣ 📂 Protocols
┃
┣ 📂 Presentation
┃ ┣ 📂 Base
┃ ┣ 📂 Onboarding
┃ ┃ ┃ ┣ 📂 ViewController
┃ ┃ ┃ ┃ ┣ 📜 OnboardingViewController
┃ ┃ ┃ ┣ 📂 Views
┃ ┃ ┃ ┃ ┣ 📜 OnboardingView
┃ ┃ ┃ ┣ 📂 Cells
┃ ┃ ┃ ┃ ┣ 📜 OnboardingTableViewCell
┃ ┣ 📂 Home
┃ ┣ 📂 TabBar
┃ ┣ 📂 Recommend
┃ ┣ 📂 Meeting
┃ ┣ 📂 MyPingle
┃ ┣ 📂 Profile
┃
┣ 📂 Network
┃ ┣ 📂 Base
┃ ┣ 📂 Onboarding
┃ ┃ ┃ ┣ 📜 DTO
┃ ┃ ┃ ┣ 📜 Router
┃ ┃ ┃ ┣ 📜 Service
┃ ┣ 📂 Home
┃ ┣ 📂 Recommend
┃ ┣ 📂 Meeting
┃ ┣ 📂 MyPingle
┃ ┣ 📂 Profile
```

---------

![9](https://github.com/TeamPINGLE/PINGLE-iOS/assets/109775321/a06d96ee-aca4-4806-9502-61f0dc162947)

[PINGLE-iOS UI 설계](https://pinglepingle.notion.site/a2fd01fab47c4ad187a6074a8a575d80?v=e767197afc8841d5ac2661bb80c51f15&pvs=4)


---------
![8](https://github.com/TeamPINGLE/PINGLE-iOS/assets/109775321/3aeb0366-0444-46b8-9dc5-6fb4b8bb3140)

[PINGLE-iOS 기능 설계](https://pinglepingle.notion.site/c02dfaffbf3b4f6e884750399e71aee6?v=1b13977db2ff4565834ef1e2c46aafa6&pvs=4)

