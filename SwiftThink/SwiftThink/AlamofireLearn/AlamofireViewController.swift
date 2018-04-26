//
//  AlamofireViewController.swift
//  SwiftThink
//
//  Created by leoli on 2018/4/23.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit
import Alamofire

//http://zengwenzhi.com/category/alamofire/
class AlamofireViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        testOne()
    }

    func testOne() {
        Alamofire.request(TestAPI).responseJSON { (dataResponse) in
            print(dataResponse)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
