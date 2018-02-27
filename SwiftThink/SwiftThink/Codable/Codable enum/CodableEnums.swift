//
//  CodableEnums.swift
//  SwiftThink
//
//  Created by leoli on 2018/1/24.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

enum Either<A: Codable, B: Codable> {
    case left(A)
    case right(B)
}

extension Either: Encodable {
    enum CodingKeys: CodingKey {
        case left
        case right
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .left(let value):
            try container.encode(value, forKey: .left)
        case .right(let value):
            try container.encode(value, forKey: .right)
        }
    }
}

extension Either: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let leftValue = try container.decode(A.self, forKey: .left)
            self = .left(leftValue)
        } catch {
            let rightValue = try container.decode(B.self, forKey: .right)
            self = .right(rightValue)
        }
    }
}
