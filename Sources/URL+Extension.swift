//
//  URL+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension URL {
    /// URL의 쿼리 파라미터들을 딕셔너리로 반환
    var queryParameters: [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return [:]
        }
        
        var parameters: [String: String] = [:]
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
    
    /// 단일 쿼리 파라미터 추가
    /// - Parameters:
    ///   - name: 파라미터 이름
    ///   - value: 파라미터 값
    /// - Returns: 파라미터가 추가된 URL
    func appendingQueryParameter(name: String, value: String) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        var queryItems = components.queryItems ?? []
        queryItems.append(URLQueryItem(name: name, value: value))
        components.queryItems = queryItems
        
        return components.url
    }
    
    /// 여러 쿼리 파라미터 추가
    /// - Parameter parameters: 추가할 파라미터 딕셔너리
    /// - Returns: 파라미터들이 추가된 URL
    func appendingQueryParameters(_ parameters: [String: String]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        var queryItems = components.queryItems ?? []
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        components.queryItems = queryItems
        
        return components.url
    }
}

@available(iOS 15.0, macOS 12.0, *)
public extension URLSession {
    /// 타임아웃 설정이 있는 데이터 요청
    /// - Parameters:
    ///   - url: 요청할 URL
    ///   - timeout: 타임아웃 시간
    /// - Returns: 데이터와 응답
    func data(from url: URL, timeout: TimeInterval) async throws -> (Data, URLResponse) {
        var request = URLRequest(url: url)
        request.timeoutInterval = timeout
        return try await data(for: request)
    }
    
    /// JSON 데이터를 바로 Codable 타입으로 디코딩
    /// - Parameters:
    ///   - type: 디코딩할 타입
    ///   - url: 요청할 URL
    ///   - decoder: JSON 디코더 (기본: JSONDecoder())
    /// - Returns: 디코딩된 객체
    func decode<T: Decodable>(
        _ type: T.Type,
        from url: URL,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let (data, _) = try await data(from: url)
        return try decoder.decode(type, from: data)
    }
}