//
//  Result+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Result {
    /// Result가 성공 상태인지 확인
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
    
    /// Result가 실패 상태인지 확인
    var isFailure: Bool {
        !isSuccess
    }
    
    /// 성공 값 추출 (실패 시 nil)
    var value: Success? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
    
    /// 에러 값 추출 (성공 시 nil)
    var error: Failure? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
    
    /// 성공 시 액션 실행 (체이닝 가능)
    /// - Parameter action: 성공 값에 대한 액션
    /// - Returns: 원본 Result
    func onSuccess(_ action: (Success) -> Void) -> Result<Success, Failure> {
        if case let .success(value) = self {
            action(value)
        }
        return self
    }
    
    /// 실패 시 액션 실행 (체이닝 가능)
    /// - Parameter action: 에러 값에 대한 액션
    /// - Returns: 원본 Result
    func onFailure(_ action: (Failure) -> Void) -> Result<Success, Failure> {
        if case let .failure(error) = self {
            action(error)
        }
        return self
    }
}

public extension Result where Failure: Error {
    /// 성공 값에 변환 함수 적용 (throwing 함수 지원)
    /// - Parameter transform: 변환 함수
    /// - Returns: 변환된 Result
    func tryMap<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> Result<NewSuccess, any Error> {
        switch self {
        case .success(let value):
            do {
                return .success(try transform(value))
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}