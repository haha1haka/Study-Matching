



<img width="956" alt="스크린샷 2022-12-15 15 13 44" src="https://user-images.githubusercontent.com/106936018/207786299-27e6bf64-fd99-4019-a193-976926f9be00.png">

<br/>

# SeSAC Study Matching

> *개발기간: 22.11.08 ~ 22.11.30*

* API 명세와 디자인 리소스를 전달 받아 실제 현업 개발 환경을 경함한 프로젝트 입니다.
* 회원 가입과 로그인이 가능하고, 내정보를 확인 및 수정 할 수 있습니다.
* 주변 스터디를 구하고있는 사람들을 지도상에서 확인 할 수 있습니다.
* 원하는 스터디 wishList를 작성하고, wishList에 해당하는 사람들을 불러 올 수 있습니다.
* 상대방의 원하는 스터디를 확인 할 수 있고, 1 : 1 채팅 요청을 보낼 수 있습니다.

<br/>

# Table Of Contents

* [Tech Stack](https://github.com/haha1haka/Study-Matching#tech-stack)
* [Team Collaboration](https://github.com/haha1haka/Study-Matching#team-collaboration)
* [Simulation](https://github.com/haha1haka/Study-Matching#simulation)
* [Trouble Shooting](https://github.com/haha1haka/Study-Matching#-trouble-shooting)

    



<br/>



## Tech Stack 

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




<br/>

## Team Collaboration



> 팀명: 문어단(개발하다 머리 빠져서 문어의 머리처럼 되는것 영광으로 생각하자는?? ㅎㅎ)

<img width="763" alt="스크린샷 2022-12-15 16 19 21" src="https://user-images.githubusercontent.com/106936018/207797401-bc0f1525-1529-47d2-adb8-f45c8c900778.png">

### Team Communication

* 서비스적으로 고려해야할 지점들을 논의하고, 해결해 갔습니다.

* 매일 스크럼을 작성하여,서로의 기술을 공유하고, 논의 했던 점과 진행 상황을 소통 하였습니다.




<img width="587" alt="스크린샷 2022-12-15 16 19 41" src="https://user-images.githubusercontent.com/106936018/207797465-2492b29c-028a-4cea-95cb-366ac8eddca8.png">



<img width="559" alt="스크린샷 2022-12-15 16 19 50" src="https://user-images.githubusercontent.com/106936018/207797498-3d662e9c-0b95-4dad-a44c-5426d06a06dc.png">

<img width="565" alt="스크린샷 2022-12-15 16 19 59" src="https://user-images.githubusercontent.com/106936018/207797521-7880dbb2-623d-4fd3-ba3a-e40a6c695172.png">



<img width="181" alt="스크린샷 2022-12-15 16 20 12" src="https://user-images.githubusercontent.com/106936018/207797566-5bd3c092-3d57-4e36-a398-65a222ac8e5d.png">



### Figma

<img width="858" alt="스크린샷 2022-12-17 16 49 23" src="https://user-images.githubusercontent.com/106936018/208231725-996689b6-7f72-4d86-8594-dcf96892b747.png">





<br/>

## Simulation

### 1. SplashViewController & Onboarding

![11온보딩](https://user-images.githubusercontent.com/106936018/208286582-db48a7e9-1899-4403-8efd-1a8e34bc9327.gif)





* LauchScreen을 controller 로 만들어 네트워킹 신호 약할시  대응
* NWPathMonitor 를 이용한 실시간 네트워크 모니터링



### 2. SignUp & SignIn

![2222회원](https://user-images.githubusercontent.com/106936018/208286586-a042406c-7868-4ec3-af25-447268403e62.gif)





* FirebaseAuth 전화번호 인증을 이용한 로그인
* 로그인시 해당 updateFCMToken을 서버에 post. 멀티디바이스 대응
* 전화번호, 이메일, 생년월일 등 유효성 검사 
* 이미 회원가입이 된 유저, 금지된 단어의 닉네임, 토큰만료 등 다양한 서비스 case 대응 




### 3. MyInfo



![33myinfo](https://user-images.githubusercontent.com/106936018/208286593-70071d1c-1a2d-4f93-815b-f0518584c3a6.gif)



* CompositionalLayout을 이용한 Expandable Cell UI 구성
* 저장버튼 클릭시 정보 update 
* 회원 탈퇴진행 및 화면 분기처리



### 4. Map & 주변 유저 매칭



![44map](https://user-images.githubusercontent.com/106936018/208286597-e4c3250f-6bd6-4ed2-bddb-30688e480931.gif)

* CLLocation을 이용한 위치서비스 확인 권한요청
* 사용자 위치 변경시마다 user탐색, 성별구분, GPS버튼을 통한 본인 위치 확인
* 사용자의 현재상태(탐색, 매칭대기, 매칭)에 따라 UI처리
* Mapkit을 이용하여, 주변 사용자 탐색 및 CustomAnnotation 표시 
* 추천 스터디 상단 배치, 중복 스터디 제거 등 대응
* 5초마다 서버 호출을 통해 사용자(본인)상태 확인하여, 매칭확정되면 자동으로 채팅화면 진입



### 5. Chat

![chat](https://user-images.githubusercontent.com/106936018/208351792-6e73ddf5-08c0-4696-9226-b3bd7bc81854.gif)

* WebSocket 을 이용한 1 : 1 채팅 구현
* 지난내역의 채팅들을 realmDB상에 저장, 채팅방에 입장시, 지난 채팅 내역들 fetch
* 소켓을 연결하고 해제 해줘야하는 시점 대응



<br/>







## 💥 Trouble Shooting



### application/x-www.form-urlencoded

* ContentType이 **application/x-www.form-urlencoded** 일경우
    * 서버에 post 시 encoding 을 필수로 진행 해야하는데 생략
    * key=value&key=&value&key=&value..형태로 데이터 전송
    * Router body parameter 구조개선

```swift
case .queue(let lat, let long, let studylist):
    var parameters = ["lat": "\(lat)", "long": "\(long)"]
                        .compactMap{ "\($0)=\($1)" }
                        .joined(separator: "&")
            
    studylist.forEach { parameters += "&studylist=\($0)" }
            
    return parameters
```

* Alomofire, Moya등 외부 라이브러리에서는 Array를 encode 할때 `.noBracket`으로 Encoding 후에 통신 하면 쉽게됌

    

#### Content-Type의 이해

> * api 연동시 Message Body 에 들어가는 타입을 HTTP Header 에 명시할 수 있도록 해주는 필드
> * Message Body 의 type 정보를 나타냅
> * application/json 과 application/x-www.form-urlencoded 두종류 존재



<br/>



### RxRelam 을 이용한 채팅 구현 

* 모든 채팅Log realm 에 저장해서, log(Data)가 변경될시 UI구성 할려고함
* 채팅이 안 이루어지고 있을시, 상대방의 chatting 내역은 realm 에 존재 하지 않는 문제점으로,
* 이전 내역의 chatting 을 불러올시 sync 안맞음
* 상대의 마지막 chatting 시각으로   `{baseURL}/v1/chat/{from}?lastchatDate={lastchatDate}` api 호출로 해결

#### 기존코드

```swift
Observable.changeset(from: viewModel.chatDataBase) 
    .bind(onNext: { array, changes in
     var snapshot = self.dataSource.snapshot()
    snapshot.appendSections([0])
    snapshot.appendItems(array.toArray(), toSection: 0)
    snashot.reconfigureItems(array.toArray())
    self.dataSource.apply(snapshot)
})
```

#### 개선

```swift
viewModel.payloadChat // payloadChat: 상대 마지막 chat data 기준으로 이전채팅 내역 api 호출 후 넘어온 chat
    .bind(onNext: { payloadChat in
    snapshot.appendItems(self.viewModel.chatDataBase.toArray(),toSection: 0)
    if !snapshot.sectionIdentifiers.isEmpty {
    snapshot.appendItems(payloadChat,toSection: 0)
    }
    self.dataSource.apply(snapshot)
})
.disposed(by: disposeBag)
```

<br/>

### 멀티디바이스 대응 

* 타인의 Device에 내 아이디로 로그인을 진행 했을시, 타인의 `FCM(Firebase Cloud Message)` 을 내가 쓰게 되는것을 방지
* `{baseURL}/v1/user/update_fcm_token` api 를 **로그인시 서버로 보내** 본인과 서버 FCMToken sync를 맞춰주기





<br/>

### dataSource(cell)의 ItemType 구분하기

* 1개의 collectionView 각각 다른 cell 에 각각 다른 ItemType 을 구분지어야 하는 문제
* 해당 각 cell의  ItemType을 enum case 연관값으로 담아놓기

```swift
enum Item: Hashable {
    case main(Main)
    case sub(Sub)
}
```

* 각각 구분된 Type 으로 구성된 Item 을 ItemTyped으로 diffableDatasource 구성

```swift
class ProfileDataSource: UICollectionViewDiffableDataSource<Int, Item> {
    convenience init(collectionView:       UICollectionView,
                     mainCellRegistration: ProfileMainCellRegistration,
                     subCellRegistration:  ProfileSubCellRegistration)
    {
        self.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .main(let main):
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: mainCellRegistration,
                    for: indexPath,
                    item: main)
                return cell
            case .sub(let sub):
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: subCellRegistration,
                    for: indexPath,
                    item: sub)
                return cell
            }
        }
}
```



<br/>



### ExpandableCell

* cell 클릭시 expandable 하게 구현 해야 하는 문제 
* 카드뷰가 접혀 있을때와, 열려 있을때 constrains 를 둬서
* cell이 isSelected 될시 updateAppearance()해주는 방식으로 해결

```swift
func updateAppearance() {
    closedConstraint?.isActive = !isSelected
    openConstraint?.isActive = isSelected
        
    UIView.animate(withDuration: 0.3) {
        let upsideDown = CGAffineTransform(rotationAngle: .pi * 0.999 )
        self.disclosureView.transform = self.isSelected ? upsideDown :.identity
    }
}
```

* 여기서,  UI를 업데이트 시켜주기 위해 datasource 를 refresh 해주는 코드를 **shouldSelectItemAt** (Delegate매서드)에 구현 해서 해결

```swift
    func collectionView(
        _ collectionView: UICollectionView,
        shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {

        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        
        dataSource.refresh()
        
        return false
    }
```



#### shouldSelectItemAt이해

> cell 을 선택된 상태로 할건지 안할건지 true false 로 처리 가능





















































