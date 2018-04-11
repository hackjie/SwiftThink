//
//  DelegatedViewController.swift
//  SwiftThink
//
//  Created by leoli on 2018/4/11.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

class DelegatedViewController: BaseViewController {

    var numToString = Delegated<Int, String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.numToString.delegate(to: self) { (self, number) -> String in
            print(number)
            return String(number)
        }

        numToString.call(3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("")
    }
}
