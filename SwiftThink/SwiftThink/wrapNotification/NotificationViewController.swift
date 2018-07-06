//
//  NotificationViewController.swift
//  SwiftThink
//
//  Created by leoli on 2018/1/23.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

class NotificationViewController: BaseViewController {

    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        token = NotificationCenter.default.observe(name: UIApplication.didBecomeActiveNotification, object: nil, queue: nil, using: { [weak self] (note) in
            self?.hello()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func hello() {
        print("hello")
    }

}
