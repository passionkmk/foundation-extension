//
//  ResultExtensionTests.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Testing
import Foundation
@testable import FoundationExtension

enum TestError: Error, Equatable {
    case generic
    case specific(String)
}

struct ResultExtensionTests {
    
    @Test("Result 성공 상태 체크")
    func testIsSuccess() {
        let success: Result<String, TestError> = .success("hello")
        let failure: Result<String, TestError> = .failure(.generic)
        
        #expect(success.isSuccess == true)
        #expect(failure.isSuccess == false)
    }
    
    @Test("Result 실패 상태 체크")
    func testIsFailure() {
        let success: Result<String, TestError> = .success("hello")
        let failure: Result<String, TestError> = .failure(.generic)
        
        #expect(success.isFailure == false)
        #expect(failure.isFailure == true)
    }
    
    @Test("Result 값 추출")
    func testValue() {
        let success: Result<String, TestError> = .success("hello")
        let failure: Result<String, TestError> = .failure(.generic)
        
        #expect(success.value == "hello")
        #expect(failure.value == nil)
    }
    
    @Test("Result 에러 추출")
    func testError() {
        let success: Result<String, TestError> = .success("hello")
        let failure: Result<String, TestError> = .failure(.generic)
        
        #expect(success.error == nil)
        #expect(failure.error == TestError.generic)
    }
    
    @Test("성공 시 액션 실행")
    func testOnSuccess() {
        var executed = false
        let result: Result<String, TestError> = .success("hello")
        
        let chainedResult = result.onSuccess { value in
            executed = true
            #expect(value == "hello")
        }
        
        #expect(executed == true)
        #expect(chainedResult.isSuccess == true)
    }
    
    @Test("실패 시 액션 실행")
    func testOnFailure() {
        var executed = false
        let result: Result<String, TestError> = .failure(.generic)
        
        let chainedResult = result.onFailure { error in
            executed = true
            #expect(error == TestError.generic)
        }
        
        #expect(executed == true)
        #expect(chainedResult.isFailure == true)
    }
    
    @Test("tryMap 성공 케이스")
    func testTryMapSuccess() {
        let result: Result<Int, TestError> = .success(5)
        
        let mapped = result.tryMap { value in
            return value * 2
        }
        
        #expect(mapped.isSuccess == true)
        #expect(mapped.value == 10)
    }
    
    @Test("tryMap 실패 케이스")
    func testTryMapFailure() {
        let result: Result<Int, TestError> = .failure(.generic)
        
        let mapped = result.tryMap { value in
            return value * 2
        }
        
        #expect(mapped.isFailure == true)
    }
    
    @Test("tryMap 변환 중 에러 발생")
    func testTryMapThrows() {
        let result: Result<String, TestError> = .success("abc")
        
        let mapped = result.tryMap { value in
            throw TestError.specific("conversion error")
        }
        
        #expect(mapped.isFailure == true)
    }
}