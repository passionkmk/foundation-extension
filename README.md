# FoundationExtension

Swift Foundation 타입들을 위한 유틸리티 확장 라이브러리

## 설치

```swift
dependencies: [
    .package(url: "https://github.com/passionkmk/foundation-extension.git", from: "1.0.0")
]
```

## Array Extensions

```swift
let numbers = [1, 2, 3, 4, 5]
numbers[safe: 10]  // nil
numbers[safe: 2]   // Optional(3)

[1, 2, 2, 3, 3].unique  // [1, 2, 3]

var array = [1, 2, 3]
array.safeRemove(at: 10)    // 무시됨
array.safeInsert(0, at: 0)  // [0, 1, 2, 3]
```

### 메서드
- `subscript(safe index: Int) -> Element?` - 안전한 인덱스 접근
- `unique` - 중복 제거 (Hashable 타입)
- `safeRemove(at:)` - 안전한 요소 제거
- `safeInsert(_:at:)` - 안전한 요소 삽입

## String Extensions

```swift
"  hello  ".isBlank     // false
"   ".isBlank           // true
"  hello  ".trimmed     // "hello"
"hello"[safe: 0..<3]    // Optional("hel")
"test@email.com".isValidEmail  // true
"hello".capitalizingFirstLetter // "Hello"
```

### 메서드
- `isBlank` - 빈 문자열 여부
- `trimmed` - 앞뒤 공백 제거
- `subscript(safe range:)` - 안전한 부분 문자열
- `isValidEmail` - 이메일 유효성 검증
- `capitalizingFirstLetter` - 첫 글자 대문자

### iOS 16+ 전용
- `lines` - 줄 단위 분리
- `matches(regex:)` - 정규식 매칭

## Collection Extensions

```swift
[1, 2, 3].isNotEmpty           // true
[1, 2, 2, 3].removingDuplicates()  // [1, 2, 3]
[1, 2, 3, 4, 5].chunked(into: 2)   // [[1,2], [3,4], [5]]

var array = [1, 2, 3, 4]
array.removeFirst { $0 == 2 }  // [1, 3, 4]
```

### 메서드
- `isNotEmpty` - 비어있지 않음 확인
- `removingDuplicates()` - 중복 제거 (Equatable)
- `chunked(into:)` - 지정 크기로 분할
- `removeFirst(where:)` - 조건부 첫 번째 요소 제거

## Bool Extensions

```swift
true.not     // false
false.isNot  // true
```

### 메서드
- `not` - 반대값
- `isNot` - false 여부

## Optional Extensions

```swift
let value: Int? = 42
value.isExist     // true
value.isNotExist  // false
```

### 메서드
- `isExist` - nil이 아닌지 확인
- `isNotExist` - nil인지 확인

## Date Extensions

```swift
let date = Date()
date.string(format: "yyyy-MM-dd", timeZone: .current, locale: .current)
```

### 메서드
- `string(format:timeZone:locale:)` - 포맷된 문자열

## Int Extensions

```swift
1000.commaNotation  // "1,000"
```

### 메서드
- `commaNotation` - 콤마 표기법

## Double/Float Extensions

```swift
3.14159.precision(.point_2)  // 소수점 2자리
```

### 메서드
- `precision(_:)` - 소수점 정밀도 제어

## Result Extensions

```swift
let result: Result<String, Error> = .success("data")

result
    .onSuccess { print("성공: \($0)") }
    .onFailure { print("실패: \($0)") }

result.isSuccess  // true
result.value      // Optional("data")
```

### 메서드
- `isSuccess/isFailure` - 성공/실패 여부
- `value/error` - 값/에러 추출
- `onSuccess(_:)/onFailure(_:)` - 체이닝 가능한 액션
- `tryMap(_:)` - 변환 함수 적용

## Task Extensions (iOS 15+)

```swift
// 지연 실행
Task.delayed(by: 2.0) {
    print("2초 후 실행")
}

// 재시도 (iOS 16+)
let result = await Task.retry(maxAttempts: 3) {
    try await networkCall()
}
```

### 메서드
- `Task.delayed(by:operation:)` - 지연 실행
- `Task.retry(maxAttempts:delay:operation:)` - 재시도 로직 (iOS 16+)

## URL Extensions

```swift
let url = URL(string: "https://api.com")!

// 쿼리 파라미터 추가
let newUrl = url.appendingQueryParameter(name: "page", value: "1")

// 여러 파라미터 추가
let urlWithParams = url.appendingQueryParameters([
    "page": "1",
    "limit": "20"
])

// 파라미터 추출
let params = url.queryParameters
```

### 메서드
- `queryParameters` - 쿼리 파라미터 딕셔너리
- `appendingQueryParameter(name:value:)` - 단일 파라미터 추가
- `appendingQueryParameters(_:)` - 여러 파라미터 추가

## URLSession Extensions (iOS 15+)

```swift
// 타임아웃 설정
let (data, response) = try await URLSession.shared.data(from: url, timeout: 10.0)

// 직접 디코딩
let user = try await URLSession.shared.decode(User.self, from: url)
```

### 메서드
- `data(from:timeout:)` - 타임아웃 설정 요청
- `decode(_:from:decoder:)` - 직접 Codable 디코딩

## UserDefaults Extensions

```swift
// 직접 사용
UserDefaults.standard.setCodable(user, forKey: "user")
let user: User? = UserDefaults.standard.codable(User.self, forKey: "user")

// Property Wrapper
@UserDefault(key: "username", defaultValue: "Guest")
var username: String

@CodableUserDefault(key: "settings", defaultValue: Settings())
var settings: Settings
```

### 메서드
- `setCodable(_:forKey:)` - Codable 객체 저장
- `codable(_:forKey:)` - Codable 객체 로드
- `@UserDefault` - 기본 타입용 Property Wrapper
- `@CodableUserDefault` - Codable 타입용 Property Wrapper

## JSONDecoder Extensions

```swift
// snake_case 자동 변환
let decoder = JSONDecoder.snakeCaseConverting
let user = try decoder.decode(User.self, from: data)
```

### 메서드
- `snakeCaseConverting` - snake_case 키 변환 디코더

## 테스트 실행

```bash
swift test
```

## 요구사항

- Swift 6.0+
- iOS 15.0+ / macOS 12.0+ / watchOS 8.0+ / tvOS 15.0+