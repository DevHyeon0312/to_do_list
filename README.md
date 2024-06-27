### flutter_template

### 목표
- 테스크 카드를 생성, 수정, 삭제할 수 있는 기능 : Item 을 클릭하여 detail page 에서 처리
- 테스크 카드는 완료된 작업과 진행 중인 작업을 구분할 수 있어야 하며, 각 목록은 탭으로 구분 -> 탭별로 해당 상태에 맞는 Item 을 보여줌
- 각 테스크 카드는 드래그&드랍을 통해 정렬 -> Item 좌측의 Drag Icon 을 통해 처리
- 각 테스크 카드와 상태는 앱 재실행 이후에도 유지 -> Local DataBase (SQLite) 를 통해 처리

### 제한사항
- 상태 관리는 GetX를 사용 -> OK
- 상태 관리 및 데이터 저장에 필요한 패키지 외에 다른 써드파티 패키지는 사용금지 -> OK
- 단위 테스트를 추가 -> Mockito 를 사용하여 테스트 진행
- 코드의 재사용성과 효율성을 고려하여 프로젝트를 구성 -> MVVM 패턴을 적용 , Clean Architecture 개념 적용 (구조는 정확히 일치하지 않음) , common widget 을 통한 재사용성 증가

### 미리보기
- 

#### Show VS-Code Interface
- [VS-Code Interface](https://github1s.com/DevHyeon0312/to_do_list)

#### Spec
- [getX](https://pub.dev/packages/get) - State Management
- [floor](https://pub.dev/packages/flutter_riverpod) - Local DataBase (SQLite)
- [mockito](https://pub.dev/packages/mockito) - Mock Test

#### Project Structure
```dart
.
└── lib
    ├── app
    │   ├── data
    │   │   ├── enums
    │   │   ├── model
    │   │   └── uscase
    │   ├── featrue
    │   │   ├── main
    │   │   │   ├── controller
    │   │   │   └── main_page.dart
    │   │   └── task
    │   │       ├── controller
    │   │       │     └── ...
    │   │       ├── page
    │   │       │     └── ...
    │   │       └── widget
    │   │             └── ...
    │   └── navigation
    │       ├── app_binding.dart
    │       ├── app_page.dart
    │       └── app_route.dart
    │   
    ├── common
    │   ├── util
    │   │     └── ...
    │   └── widget
    │         └── ...
    │
    └── core
        ├── dao
        │     └── ...
        ├── database
        │     └── ...
        ├── entity
        │     └── ...
        ├── repository
        │     └── ...
        └── database_module.dart
```
