//
//  ViewController.swift
//  SwiftThink
//
//  Created by leoli on 2018/1/23.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let button = UIButton.init(frame: CGRect.init(x: 40, y: 80, width: 200, height: 80))
        button.setTitle("跳转", for: .normal)
        button.addTarget(self, action: #selector(jump), for: .touchUpInside)
        button.backgroundColor = UIColor.blue

        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func jump() {
        let vc = AlamofireViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

