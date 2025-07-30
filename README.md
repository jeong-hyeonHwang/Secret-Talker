# SecretTalker
> 반응형 메시지 암호화 학습/실험형 프로젝트

## 프로젝트 목표
- 클린 아키텍처 & 클린 코드에서 습득한 프로그래밍 패러다임과 설계 원칙을 프로젝트에 적용해보자.
- SwiftUI 기반 반응형 흐름을 구성하자.
- WWDC에서 소개된 새로운 기술 스택들을 써보자.

## Demo
|메시지 생성(Maker)|메시지 읽기(Opener)|
|:---:|:---:|
![Opener_MV](https://github.com/user-attachments/assets/ac2421ea-2cf1-4d30-802c-fb43dd249783)|![Maker_MV](https://github.com/user-attachments/assets/b63994db-00ec-4c45-9ea2-a87d119cdfbf)|

## Screenshots

### Maker: 메시지 생성 및 QR 공유

|메시지 리스트|메시지 생성|생성 후 QR 읽기|
|:---:|:---:|:---:|
|<img width="350" alt="Maker_List" src="https://github.com/user-attachments/assets/75502e58-dc7e-4bc7-b174-4c68d2263093" />|<img width="350" alt="Maker_Make" src="https://github.com/user-attachments/assets/ccbdf910-d1d4-42bc-957a-6c651e93fbc4" />|<img width="350" alt="Maker_QR" src="https://github.com/user-attachments/assets/22d909b4-a8d7-4774-b344-40436a7e7359" />|


### Opener: 메시지 해독

|카메라를 통해 QR 읽기|암호 입력|해독 후 메시지 열람|
|:---:|:---:|:---:|
|<img width="350" alt="Opener_Camera" src="https://github.com/user-attachments/assets/f7f17bd2-4df5-4032-a028-1dd3bf5b94e1" />|<img width="350" alt="Opener_Solve" src="https://github.com/user-attachments/assets/e2e5c1b3-1939-4b08-9ef1-86b309d5151f" />|<img width="350" alt="Opener_Solved" src="https://github.com/user-attachments/assets/72bd0ee5-bca5-42c5-bebc-e76427dd9b38" />|


## Tech Skill
|       Tech       | Description                                                                     |
| :--------------: | :------------------------------------------------------------------------------ |
|    **SwiftUI**   | 앱 전반의 UI 구성에 사용<br>상태 기반 인터페이스 구현과 화면 간 흐름 제어에 초점을 맞춰 구성|
|     **UIKit**    | SwiftUI에서 직접 제어하기 어려운 **탭바 커스터마이징** 및 내비게이션 바 스타일 적용에 사용|
|    **Combine**   | 상태 변화에 따른 UI 업데이트, QR 스캔 시점 관리 등에서 반응형 흐름을 구현하기 위해 사용|
| **AVFoundation** | **카메라 미리보기** 및 실시간 프레임 처리를 위해 활용<br>QR 스캐너 기능 구현의 핵심 역할|
|   **CryptoKit**  | 메시지 데이터의 **암호화 및 복호화**를 위해 사용<br>QR코드로 안전한 메시지 전달을 가능하게 함|
|   **SwiftData**  | 생성된 메시지 및 스캔된 메시지를 **로컬 DB에 저장**하고 불러오기 위해 사용|
