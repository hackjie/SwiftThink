//
//  NetworkingViewController.swift
//  SwiftThink
//
//  Created by leoli on 2018/4/3.
//  Copyright © 2018年 leoli. All rights reserved.
//

let TestAPI = "http://api.fixer.io/latest?base=CNY"

import UIKit

class NetworkingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        testPackageRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.


    }
    
    func test() {
        let json =
            """
            {
                "name": "lijie",
                "age": 22
            }
            """.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let person = try decoder.decode(Person.self, from: json)
            print(person.name)
        } catch {
            print(error)
        }
    }

    func testNetworkRequest() {
        let sesssion = URLSession.shared
        let request: URLRequest = URLRequest.init(url: URL.init(string: TestAPI)!)
        let task = sesssion.dataTask(with: request) { (data, response, error) in
            if (error == nil) {
                let decoder = JSONDecoder()
                do {
                    let jsonModel = try decoder.decode(CurrencyRate.self, from: data!)
                    print(jsonModel)
                } catch {
                    print("解析失败")
                }
            }
        }
        task.resume()
    }

    func testPackageRequest() {
        LJNetworking<CurrencyRate>().requestJSON(TestAPI) { jsonModel in
            print(jsonModel)
        }
    }

    func testConfigRequest() {
        LJNetworking<CurrencyRate>()
        .method(.POST)
        .configRequest { (request) in

        }.requestJSON(TestAPI) { (jsonModel) in
            print(jsonModel)
        }
    }

}
