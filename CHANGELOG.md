# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-12-07

### Added
- Array 안전한 접근 및 중복 제거 기능
- String 검증 및 포매팅 유틸리티
- Collection 확장 및 청킹 기능
- Bool 헬퍼 메서드
- Optional 존재 여부 확인
- Date 포매팅 확장
- 숫자 타입 포매팅 (콤마 표기법, 소수점 정밀도)
- Result 타입 함수형 처리
- Task 지연 실행 및 재시도 로직 (iOS 15+)
- URL 쿼리 파라미터 조작
- URLSession async/await 확장
- UserDefaults Codable 지원 및 Property Wrapper
- JSON decoder snake_case 변환
- 포괄적인 @Test 스위트
- Swift 6 동시성 지원
- watchOS 및 tvOS 플랫폼 지원

### Technical
- **Swift 6.0 완전 지원**
- iOS 15.0+ / macOS 12.0+ / watchOS 8.0+ / tvOS 15.0+
- Full strict concurrency 및 Sendable 프로토콜 준수
- @unchecked Sendable을 통한 안전한 동시성 처리
- 한국어 주석 및 문서화