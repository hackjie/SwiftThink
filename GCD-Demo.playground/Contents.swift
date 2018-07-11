import UIKit

// 参考：https://swift.gg/2016/11/30/grand-central-dispatch/

// GCD 死锁的充分条件是：向当前串行队列中同步派发一个任务
// 从原理来看，死锁的原因是提交的 block 阻塞了队列，而队列阻塞后永远无法执行完 dispatch_sync()，可见这里完全和代码所在的线程无关。

// 在主线程中执行的代码，也很可能不是运行在主队列中，反之则必然

func currentQueueName() -> String {
    let label = __dispatch_queue_get_label(.none)
    return String(cString: label)
}


// 串行队列

func simpleQueue() {
    let queue = DispatchQueue(label: "com.leoli")

//    queue.sync {
//        // 主线程中执行同步，不会新开线程
//        print(Thread.current)
//        for i in 0..<10 {
//            print("😍 ", i)
//        }
//    }

    queue.async {
        // 主线程中执行异步，会开新线程
        print(Thread.current)
        for i in 0..<10 {
            print("😍 ", i)
        }
    }

    for i in 100..<110 {
        print("Ⓜ️", i)
    }
}

func queueWithQos() {
    // QOS 只是保证了一个队列里的所有任务相对提前完成

//    let queue1 = DispatchQueue(label: "com.leoli.queue1", qos: .userInitiated)
    let queue1 = DispatchQueue(label: "com.leoli.queue1", qos: .background)
//    let queue2 = DispatchQueue(label: "com.leoli.queue2", qos: .userInitiated)
    let queue2 = DispatchQueue(label: "com.leoli.queue2", qos: .utility)

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
    }

    for i in 1000..<1010 {
        print("😎", i)
    }
}

// 串行队列 end


// 并发队列

func concurrentQueue() {
//    let anotherQueue = DispatchQueue(label: "com.leoli.anotherQueue", qos: .utility)
    let anotherQueue = DispatchQueue(label: "com.leoli.anotherQueue", qos: .utility, attributes: .concurrent)

    // 异步
    anotherQueue.async {
        print(Thread.current)
        for i in 0..<10 {
            print("😍", i)
        }
    }

    anotherQueue.async {
        print(Thread.current)
        for i in 100..<110 {
            print("Ⓜ️", i)
        }
    }

    anotherQueue.async {
        print(Thread.current)
        for i in 1000..<1010 {
            print("😎", i)
        }
    }


    // 同步
//    anotherQueue.sync {
//        print(Thread.current)
//        for i in 0..<10 {
//            print("😍", i)
//        }
//    }
//
//    anotherQueue.sync {
//        print(Thread.current)
//        for i in 100..<110 {
//            print("Ⓜ️", i)
//        }
//    }
//
//    anotherQueue.sync {
//        print(Thread.current)
//        for i in 1000..<1010 {
//            print("😎", i)
//        }
//    }
}

func queueWithDelay() {
    let delayQueue = DispatchQueue(label: "com.leoli.delayqueue", qos: .userInitiated)

    print(Date())

    let additionalTime: DispatchTimeInterval = .seconds(2)
    delayQueue.asyncAfter(deadline: .now() + additionalTime) {
        print("---")
        print(Date())
    }
}

func globalQueue() {
    // 全局队列都是并发队列，看结果两步异步操作都创建新的线程了
    let queue = DispatchQueue.global()
    print(queue.description)
    queue.async {
        print(Thread.current)
    }
    queue.async {
        print(Thread.current)
    }

    let queue2 = DispatchQueue.global(qos: .userInteractive)
    print(queue2.description)
}

func useWorkItem() {
    var value = 10
    let workItem = DispatchWorkItem {
        value += 5
    }
    workItem.perform()

    let queue = DispatchQueue.global()
    queue.async(execute: workItem)
    workItem.notify(queue: DispatchQueue.main) {
        print("value = ", value)
    }
}

// 串行队列 执行 异步 操作，不同操作会在同一个新的 线程
// 串行队列 执行 同步 操作，不会创建新的         线程

// 并发队列 执行 异步 操作，不同操作会创建新的不同 线程
// 并发队列 执行 同步 操作，不会创建新的         线程

//simpleQueue()
//queueWithQos()
//concurrentQueue()
//queueWithDelay()
//useWorkItem()
globalQueue()




