//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 结构体可以被直接持有及访问, 类的实例只能通过引用来间接访问

//let mutableArray: NSMutableArray = [1, 2, 3]
//for _ in mutableArray {
//    mutableArray.removeLastObject()
//}

var mutableArray = [1, 2, 3]
for _ in mutableArray {
//    mutableArray.removeAll() // 3 times
    mutableArray.removeLast() // 3 times
}

class BinaryScanner {
    var position: Int
    let data: Data
    init(data: Data) {
        self.position = 0
        self.data = data
    }
}

extension BinaryScanner {
    func scanByte() -> UInt8? {
        guard position < data.endIndex else {
            return nil
        }
        position += 1
        return data[position - 1]
    }
}

func scanRemainingBytes(scanner: BinaryScanner) {
    while let byte = scanner.scanByte() {
        print(byte)
    }
}

let scanner = BinaryScanner.init(data: Data.init("hi你".utf8))
scanRemainingBytes(scanner: scanner)


struct Point {
    var x: Int
    var y: Int
}

var origin = Point.init(x: 2, y: 3) {
    didSet {
        print("\(origin)")
    }
}
origin.x = 4










