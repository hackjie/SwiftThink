//
//  AFError.swift
//  SwiftThink
//
//  Created by leoli on 2018/4/23.
//  Copyright © 2018年 leoli. All rights reserved.
//

import Foundation

public enum AFError: Error {
    case invalidURL(url: URLConvertible)
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)

    public enum ParameterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
        case propertyListEncodingFailed(error: Error)
    }
}
