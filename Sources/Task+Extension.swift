//
//  Task+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

/// Task 재시도 관련 에러
public enum TaskRetryError: Error, Sendable {
    case invalidMaxAttempts
    case unexpectedError
}

@available(iOS 15.0, macOS 12.0, *)
public extension Task where Failure == any Error {
    /// 지연 실행되는 Task 생성
    /// - Parameters:
    ///   - timeInterval: 지연 시간 (초)
    ///   - operation: 실행할 비동기 작업
    /// - Returns: 지연 실행되는 Task
    static func delayed(
        by timeInterval: TimeInterval,
        operation: @escaping @Sendable () async throws -> Success
    ) -> Task {
        Task {
            await _sleep(timeInterval)
            return try await operation()
        }
    }
    
    /// 내부 sleep 함수
    private static func _sleep(_ timeInterval: TimeInterval) async {
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            DispatchQueue.global().asyncAfter(deadline: .now() + timeInterval) {
                continuation.resume()
            }
        }
    }
}

@available(iOS 15.0, macOS 12.0, *)
public extension Task where Success == Void, Failure == any Error {
    /// 지연 실행되는 Void Task 생성
    /// - Parameters:
    ///   - timeInterval: 지연 시간 (초)
    ///   - operation: 실행할 비동기 작업
    /// - Returns: 지연 실행되는 Task
    static func delayed(
        by timeInterval: TimeInterval,
        operation: @escaping @Sendable () async throws -> Void
    ) -> Task {
        Task {
            await _sleep(timeInterval)
            try await operation()
        }
    }
    
    /// 내부 sleep 함수
    private static func _sleep(_ timeInterval: TimeInterval) async {
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            DispatchQueue.global().asyncAfter(deadline: .now() + timeInterval) {
                continuation.resume()
            }
        }
    }
}

@available(iOS 15.0, macOS 12.0, *)
public extension Task where Failure == Never {
    /// 재시도 로직을 가진 비동기 작업 실행
    /// - Parameters:
    ///   - maxAttempts: 최대 시도 횟수 (기본: 3)
    ///   - delaySeconds: 재시도 간격 초 (기본: 1)
    ///   - operation: 실행할 비동기 작업
    /// - Returns: 성공 또는 실패 Result
    static func retry<T>(
        maxAttempts: Int = 3,
        delaySeconds: TimeInterval = 1.0,
        operation: @escaping @Sendable () async throws -> T
    ) async -> Result<T, any Error> {
        guard maxAttempts > 0 else {
            return .failure(TaskRetryError.invalidMaxAttempts)
        }
        
        for attempt in 1...maxAttempts {
            do {
                let result = try await operation()
                return .success(result)
            } catch {
                if attempt == maxAttempts {
                    return .failure(error)
                }
                await _sleep(delaySeconds * Double(attempt))
            }
        }
        
        // 이 지점에 도달하는 것은 불가능하지만 컴파일러를 위해 포함
        return .failure(TaskRetryError.unexpectedError)
    }
    
    /// 내부 sleep 함수
    private static func _sleep(_ timeInterval: TimeInterval) async {
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            DispatchQueue.global().asyncAfter(deadline: .now() + timeInterval) {
                continuation.resume()
            }
        }
    }
}