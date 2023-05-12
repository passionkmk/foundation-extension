//
//  Codable+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension JSONDecoder {
    static let snakeCaseConverting: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
