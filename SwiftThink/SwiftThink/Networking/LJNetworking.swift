//
//  LJNetworking.swift
//  SwiftThink
//
//  Created by leoli on 2018/4/10.
//  Copyright © 2018年 leoli. All rights reserved.
//

protocol LJURLNetworking {
    func asURL() -> URL
}

extension String: LJURLNetworking {
    public func asURL() -> URL {
        guard let url = URL(string: self) else {
            return URL(string: "www.baidu.com")!
        }
        return url
    }
}

enum HTTPMethod: String {
    case GET, OPTIONS, HEAD, POST, PUT, PATCH, DELETE, TRACK, CONNECT
}

struct ConfigOptionals {
    var httpMethod: HTTPMethod = .GET
}

import UIKit

open class LJNetworking<T: Codable> {
    open let session: URLSession
    var op: ConfigOptionals = ConfigOptionals()

    typealias CompletionClosure = (_ data: T) -> Void
    var completionClosure: CompletionClosure = { _ in }

    typealias ConfigRequestClosure = (_ request: URLRequest) -> Void
    var configRequestClosure: ConfigRequestClosure = { _ in }

    public init() {
        self.session = URLSession.shared
    }

    // MARK: - 请求
    func requestJSON(_ url: LJURLNetworking,
                     completionClosure: @escaping CompletionClosure) {
        self.completionClosure = completionClosure
        let request: URLRequest = URLRequest(url: url.asURL())
        let task = self.session.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            let decoder = JSONDecoder()
            do {
                print("success")
                let jsonModel = try decoder.decode(T.self, from: data!)
                self.completionClosure(jsonModel)
            } catch {
                print("fail")
            }
        }
        task.resume()
    }

    func method(_ md: HTTPMethod) -> LJNetworking {
        self.op.httpMethod = md
        return self
    }

    func configRequest(_ c: @escaping ConfigRequestClosure) -> LJNetworking {
        self.configRequestClosure = c
        return self
    }
}
