//
//  UserDefaults+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension UserDefaults {
    /// Codable 객체를 UserDefaults에 저장
    /// - Parameters:
    ///   - value: 저장할 Codable 객체
    ///   - key: 저장 키
    func setCodable<T: Codable>(_ value: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(value) {
            set(encoded, forKey: key)
        }
    }
    
    /// UserDefaults에서 Codable 객체 로드
    /// - Parameters:
    ///   - type: 로드할 타입
    ///   - key: 저장 키
    /// - Returns: 디코딩된 객체 또는 nil
    func codable<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
    
    /// Codable 객체용 subscript 접근
    subscript<T: Codable>(codable key: String) -> T? {
        get { codable(T.self, forKey: key) }
        set { 
            if let value = newValue {
                setCodable(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
    
    /// Optional 값 저장 (nil인 경우 제거)
    /// - Parameters:
    ///   - value: 저장할 값
    ///   - key: 저장 키
    func setOptional<T>(_ value: T?, forKey key: String) {
        if let value = value {
            set(value, forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }
}

/// UserDefaults 값을 위한 Property Wrapper
@propertyWrapper
public struct UserDefault<T: Sendable>: @unchecked Sendable {
    let key: String
    let defaultValue: T
    let userDefaults: UserDefaults
    
    /// UserDefault Property Wrapper 초기화
    /// - Parameters:
    ///   - key: UserDefaults 키
    ///   - defaultValue: 기본값
    ///   - userDefaults: UserDefaults 인스턴스 (기본: .standard)
    public init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
    
    public var wrappedValue: T {
        get {
            userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}

/// Codable 객체를 위한 Property Wrapper
@propertyWrapper
public struct CodableUserDefault<T: Codable & Sendable>: @unchecked Sendable {
    let key: String
    let defaultValue: T
    let userDefaults: UserDefaults
    
    /// CodableUserDefault Property Wrapper 초기화
    /// - Parameters:
    ///   - key: UserDefaults 키
    ///   - defaultValue: 기본값
    ///   - userDefaults: UserDefaults 인스턴스 (기본: .standard)
    public init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
    
    public var wrappedValue: T {
        get {
            userDefaults.codable(T.self, forKey: key) ?? defaultValue
        }
        set {
            userDefaults.setCodable(newValue, forKey: key)
        }
    }
}