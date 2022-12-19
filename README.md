



<img width="956" alt="스크린샷 2022-12-15 15 13 44" src="https://user-images.githubusercontent.com/106936018/207786299-27e6bf64-fd99-4019-a193-976926f9be00.png">

<br/>

<br/>

<br/>

# SeSAC Study Matching

<br/>

API 명세와 디자인 리소스를 전달 받아 실제 현업 개발 환경을 경함한 프로젝트 입니다.

회원 가입과 로그인이 가능하고, 내정보를 확인 및 수정 할 수 있습니다.

주변 스터디를 구하고있는 사람들을 지도상에서 확인 할 수 있습니다.

원하는 스터디 wishList를 작성하고, wishList에 해당하는 사람들을 불러 올 수 있습니다.

상대방의 원하는 스터디를 확인 할 수 있고, 1 : 1 채팅 요청을 보낼 수 있습니다.







<br/><br/><br/>

# Table Of Contents

<br/>

* Tech Stack
* Team Collaboration
* Simulation
* Error Handling
* Tech Posting



<br/><br/><br/>



## Tech Stack 

<br/>

* MVVM

* Swift5.7

* UIKit

* RxSwift

* RxCocoa

* RealmDatabase

* URLSession

* FirebaseAuth

* APNs

* Mapkit

* SnapKit

* Confluence

* Swagger

* InSomnia

* Figma

  ​    



<br/><br/><br/>

## Team Collaboration

<br/>



> 팀명: 문어단(개발하다 머리 빠져서 문어의 머리처럼 되는것 영광으로 생각하자는?? ㅎㅎ)

<img width="763" alt="스크린샷 2022-12-15 16 19 21" src="https://user-images.githubusercontent.com/106936018/207797401-bc0f1525-1529-47d2-adb8-f45c8c900778.png">

<br/><br/>

### Team Communication

* 서비스적으로 고려해야할 지점들을 논의하고, 해결해 갔습니다.

* 매일 스크럼을 작성하여,서로의 기술을 공유하고, 논의 했던 점과 진행 상황을 소통 하였습니다.

  ​    



<img width="589" alt="스크린샷 2022-12-15 16 19 32" src="https://user-images.githubusercontent.com/106936018/207797434-377e15cf-35c1-4f40-a32f-1e226c8264f1.png">

<br/>



<img width="587" alt="스크린샷 2022-12-15 16 19 41" src="https://user-images.githubusercontent.com/106936018/207797465-2492b29c-028a-4cea-95cb-366ac8eddca8.png">

<br/>

<img width="559" alt="스크린샷 2022-12-15 16 19 50" src="https://user-images.githubusercontent.com/106936018/207797498-3d662e9c-0b95-4dad-a44c-5426d06a06dc.png">

<img width="565" alt="스크린샷 2022-12-15 16 19 59" src="https://user-images.githubusercontent.com/106936018/207797521-7880dbb2-623d-4fd3-ba3a-e40a6c695172.png">

<br/>

<img width="181" alt="스크린샷 2022-12-15 16 20 12" src="https://user-images.githubusercontent.com/106936018/207797566-5bd3c092-3d57-4e36-a398-65a222ac8e5d.png">

<br/>

Figma

<img width="858" alt="스크린샷 2022-12-17 16 49 23" src="https://user-images.githubusercontent.com/106936018/208231725-996689b6-7f72-4d86-8594-dcf96892b747.png">





<br/><br/><br/>

## Simulation

<br/>

### 1. SplashViewController & Onboarding

![11온보딩](https://user-images.githubusercontent.com/106936018/208286582-db48a7e9-1899-4403-8efd-1a8e34bc9327.gif)





* LauchScreen을 controller 로 만들어 네트워킹 신호 약할시  대응

* NWPathMonitor 를 이용한 실시간 네트워크 모니터링

<br/><br/>

### 2. SignUp & SignIn

![2222회원](https://user-images.githubusercontent.com/106936018/208286586-a042406c-7868-4ec3-af25-447268403e62.gif)





* 로그인시 해당 updateFCMToken을 서버에 post. 멀티디바이스 대응
* FirebaseAuth 전화번호 인증을 이용한 회원가입
* 전화번호, 이메일, 생년월일 유효성 검사 
* 이미 회원가입이 된 유저, 금지된 단어의 닉네임, 토큰만료 등 다양한 서비스 case 대응 

<br/><br/>


### 3. MyInfo



![33myinfo](https://user-images.githubusercontent.com/106936018/208286593-70071d1c-1a2d-4f93-815b-f0518584c3a6.gif)



* CompositionalLayout을 이용한 Expandable Cell UI 구성

<br/><br/>

### 4. Map & 주변 유저 매칭



![44map](https://user-images.githubusercontent.com/106936018/208286597-e4c3250f-6bd6-4ed2-bddb-30688e480931.gif)

* CLLocation을 이용한 위치서비스 확인 권한요청
* Mapkit을 이용하여, 주변 사용자 탐색 및 CustomAnnotation 표시 

<br/><br/>

### 5. Chat



* WebSocket 을 이용한 1 : 1 채팅 구현
* 지난내역의 채팅들을 realmDB상에 저장, 채팅방에 입장시, 지난 채팅 내역들 fetch



<br/><br/><br/>

## Error Handling



<br/><br/><br/>

## Tech Posting





![스크린샷 2022-12-11 21.59.55](/Users/haha1haka/Desktop/Workspace/정리정리정리/0.imageServer/스크린샷 2022-12-11 21.59.55.png)





> [https://woozzang.tistory.com/33](https://woozzang.tistory.com/33)

















