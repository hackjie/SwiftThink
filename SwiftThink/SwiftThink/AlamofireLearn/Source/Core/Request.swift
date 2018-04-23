//
//  Request.swift
//  SwiftThink
//
//  Created by leoli on 2018/4/23.
//  Copyright © 2018年 leoli. All rights reserved.
//

import Foundation

public protocol RequestAdapter {
    func adapt(_ urlRequeset: URLRequest) throws -> URLRequest
}

public typealias HTTPHeaders = [String: String]


open class Request {

}


open class DataRequest: Request {

}
