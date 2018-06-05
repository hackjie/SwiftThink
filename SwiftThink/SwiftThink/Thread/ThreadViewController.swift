//
//  ThreadViewController.swift
//  SwiftThink
//
//  Created by leoli on 2018/6/5.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

// GCD 死锁的充分条件是：向当前串行队列中同步派发一个任务
// 从原理来看，死锁的原因是提交的 block 阻塞了队列，而队列阻塞后永远无法执行完 dispatch_sync()，可见这里完全和代码所在的线程无关。

// 在主线程中执行的代码，也很可能不是运行在主队列中，反之则必然

class ThreadViewController: BaseViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect.init(x: 40, y: 80, width: 200, height: 200)
        view.addSubview(imageView)
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//         simpleQueues()

//         queuesWithQoS()

//         concurrentQueues()
//         if let queue = inactiveQueue {
//            queue.activate()
//         }

//         queueWithDelay()

//        globalQueue()

//         fetchImage()

         useWorkItem()
    }



    func simpleQueues() {
        let queue = DispatchQueue(label: "com.leoli")
        queue.sync {
            for i in 0..<10 {
                print("😍 ", i)
            }
        }

        for i in 100..<110 {
            print("Ⓜ️", i)
        }

    }


    func queuesWithQoS() {
        let queue1 = DispatchQueue(label: "com.leoli.queue1", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.leoli.queue2", qos: DispatchQoS.utility)

        queue1.async {
            print(Thread.current)
            for i in 0..<10 {
                print("😍 ", i)
            }
        }

        queue2.async {
            print(Thread.current)
            for i in 100..<110 {
                print("Ⓜ️", i)
            }
            // 死锁
//            queue2.sync {
//                print("")
//            }
        }

        print(Thread.current)


//        DispatchQueue.main.sync {
//            for i in 1000..<1010 {
//                print("😎", i)
//            }
//        }

        for i in 1000..<1010 {
            print("😎", i)
        }
    }


    var inactiveQueue: DispatchQueue!
    func concurrentQueues() {
        print(Thread.current)
//        let anotherQueue = DispatchQueue(label: "com.leoli.anotherQueue", qos: .utility, attributes: .initiallyInactive)
        let anotherQueue = DispatchQueue(label: "com.leoli.anotherQueue", qos: .utility, attributes: [.initiallyInactive, .concurrent])
        inactiveQueue = anotherQueue

        anotherQueue.async {
//            print(Thread.current)
            for i in 0..<10 {
                print("😍 ", i)
            }
        }

        anotherQueue.async {
//            print(Thread.current)
            for i in 100..<110 {
                print("Ⓜ️", i)
            }
        }

        anotherQueue.async {
//            print(Thread.current)
            for i in 1000..<1010 {
                print("😎", i)
            }
        }
    }


    func queueWithDelay() {
        let delayQueue = DispatchQueue(label: "com.leoli.delayQueue", qos: .userInitiated)

        print(Date())

        let additionalTime: DispatchTimeInterval = .seconds(2)

        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print(Date())
        }
    }

    func globalQueue() {
        // GCD 提供一个主队列（线性队列）和 四个全局队列（并发队列）
        let globalQueue = DispatchQueue.global() // qos: default
        globalQueue.async {
            print(Thread.current)
            for i in 0..<10 {
                print("😍", i)
            }
        }
    }


    func fetchImage() {
        let imageURL: URL = URL(string: "http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png")!

        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            if let data = imageData {
                print("Did download image data")
                print(Thread.current)
                DispatchQueue.main.sync {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }


    func useWorkItem() {
        var value = 10

        let workItem = DispatchWorkItem {
            value += 5
        }

        workItem.perform()

        let queue = DispatchQueue.global(qos: .utility)

        queue.async(execute: workItem)

        workItem.notify(queue: DispatchQueue.main) {
            print("value = ", value)
        }
    }

}
