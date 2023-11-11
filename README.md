# CL.D-iOS 🧗🏼‍♂️

<img width="250" alt="Group 34064" src="https://github.com/ssu-it-project/cl-d-iOS/assets/25146374/b349460e-bc2b-4efd-ae99-af5fb057fba3">

### [📱 앱 설치하러 가기](https://apps.apple.com/kr/app/%ED%81%B4%EB%94%94/id6468676840)

> 클라이밍을 디자인하다 🧗‍♂️, 클디
> 
> v1.0.0 **개발기간: 2023.08.01 ~ 2023.10.25**
> 
> **지속적인 업데이트**: 2023.10.25 ~ (진행중)

# ✨ 프로젝트 주요 화면

![클디 레포 001](https://github.com/ssu-it-project/cl-d-iOS/assets/25146374/3d6c5c3f-7c80-4307-8225-fd62c0c1691e)

### 주요 기능

- 유저 클라이밍 영상 피드 제공
- 사용자 위치 기반 주변 클라이밍장별 정보와 섹터, 홀드 색상별 등반 영상 조회
- 클라이밍장 즐겨찾기 
- 나의 클라이밍 등반 영상 업로딩 및 피드 작성
- 나의 클라이밍 등반 기록 조회

# **⚙️ 개발환경 및 기술스택**

- Minimum Deployments: iOS 15.0
- Dependence Manager : SPM
- Swift Version: 5.8.1
- `UIKit` `MVVM` `RxSwift` `RxCocoa`
- `Codebase UI` `SnapKit`
- `DiffableDataSource` `CompositionalLayout` `Tabman` `RxGesture`
- `AVFoundation` `AVPlayerLayer` `AVPlayerViewController`
- `PHImageManager` `LightCompressor` `Kingfisher`
- `CoreLocation` `KakaoMap`
- `RxKakaoOpenSDK` `AppleLogin`
- `RxMoya` `Alamofire RequestInterceptor`

# **🔥 아키텍처**

![클디 drawio](https://github.com/ssu-it-project/cl-d-iOS/assets/25146374/1ecc31b2-0b40-4813-9327-e3baccfde52d)

- Data Layer : 백엔드 or 로컬 데이터로부터 데이터를 가져오는 책임을 갖습니다. Repository 를 갖습니다.
- Domain Layer : 앱의 비즈니스 로직을 담당합니다. UseCase, VO (Value Object), Repository Protocol 을 갖습니다.
- Presentaion Layer : UI 로직 관련 책임을 갖습니다. MVVM 패턴을 활용했습니다.


## Contact CL.D-iOS

smulsmul2020@gmail.com
