//
//  TextViewController.swift
//  SwiftThink
//
//  Created by leoli on 2018/4/9.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

class TextViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        correntLineSpace()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// 正确的行间距
    func correntLineSpace() {
        let label1 = UILabel.init(frame: CGRect(x: 20, y: 100, width: 100, height: 200))
        label1.font = UIFont.systemFont(ofSize: 14)
        label1.numberOfLines = 0

        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 10
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let text = """
                   这是个不可能的事情, 我不可能写出 Hello world
                   """
        label1.attributedText = NSAttributedString.init(string: text, attributes: attributes)

        view.addSubview(label1)

        let label2 = UILabel.init(frame: CGRect(x: 130, y: 100, width: 100, height: 200))
        label2.font = UIFont.systemFont(ofSize: 14)
        label2.numberOfLines = 0

        let paragraphStyle2 = NSMutableParagraphStyle.init()
        paragraphStyle2.lineSpacing = 10 - (label2.font.lineHeight - label2.font.pointSize)
        let attributes2 = [NSAttributedString.Key.paragraphStyle: paragraphStyle2]
        let text2 = """
                   这是个不可能的事情, 我不可能写出 Hello world
                   """
        label2.attributedText = NSAttributedString.init(string: text2, attributes: attributes2)

        view.addSubview(label2)
    }
    
    

}
