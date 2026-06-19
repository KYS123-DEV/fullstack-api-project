## [구조 예시]

### Front
lib/
├── main.dart               # 앱의 진짜 시작점 (NestJS의 main.ts 같은 놈)
│
├── common/                 # 앱 전체에서 공통으로 쓰는 것들
│   ├── widgets/            # 공통 버튼, 공통 로딩바 등 재사용할 화면 컴포넌트
│   └── utils/ (또는 shared/) # ◀ 말씀하신 곳! (날짜 포맷팅, 정규식 검사 등 순수 유틸 함수)
│
├── core/                   # 앱의 핵심 설정 (네트워크 클라이언트, 테마 설정 등)
│   └── constants/          # 백엔드 API 주소(http://localhost:3000), 색상 값 등 상수 관리
│
└── domains/ (또는 features/) # ◀ 말씀하신 기능별 도메인 구조! (★핵심)
    ├── auth/               # [로그인/회원가입 기능 부서]
    │   ├── screens/        # 로그인 화면, 회원가입 화면 (UI)
    │   ├── controllers/    # 로그인 상태 관리 및 비즈니스 로직
    │   └── services/       # NestJS 백엔드 API와 실제로 HTTP 통신하는 코드
    │
    └── boards/             # [게시판 기능 부서]
        ├── screens/        # 게시글 목록 화면, 글쓰기 화면
        ├── controllers/    
        └── services/       # 백엔드의 /boards 엔드포인트와 통신하는 코드
#
### Back
src/
├── common/                 # 공통 관리 (전체 프로젝트에서 쓰는 것들)
│   ├── decorators/         # 커스텀 데코레이터
│   ├── guards/             # 인증 가드 (JWT 검증 등)
│   ├── interceptors/       # 로깅이나 응답 포맷팅 인터셉터
│   └── middlewares/        # 라우터 미들웨어
│
├── config/                 # GCP 설정, 환경변수(dotenv) 설정 등
│
├── database/               # DB 연결 및 마이그레이션 파일들
│
├── domains/ (또는 modules/) # 실제 비즈니스 기능별 폴더 (★핵심)
│   ├── users/              # [기능 모듈]
│   │   ├── dto/            # Data Transfer Object (요청/응답 데이터 검증 객체)
│   │   ├── entities/       # DB 테이블과 매핑되는 엔티티 클래스
│   │   ├── users.controller.ts
│   │   ├── users.module.ts
│   │   └── users.service.ts`
│   │
│   └── boards/             # [기능 모듈]
│       ├── dto/
│       ├── entities/
│       ├── boards.controller.ts
│       ├── boards.module.ts
│       └── boards.service.ts
│`
├── app.module.ts           # 루트 모듈 (users, boards 모듈을 여기서 import)
└── main.ts                 # 진입점

