//: Playground - noun: a place where people can play

import UIKit

while let line = readLine(), !line.isEmpty {
    print(line)
}

let stringNumbers = ["1", "2", "three"]
let maybeInts = stringNumbers.map { Int($0) }

for case let Optional.some(i) in maybeInts {
    print(i)
}

func aa() -> Never {
    fatalError("hahaha")
}

extension Array {
    func reduce(_ nextPartialResult: (Element, Element) -> Element) -> Element? {
        guard let fst = first else {
            return nil
        }
        return dropFirst().reduce(fst, nextPartialResult)
    }
}

let a = [1, 2, 3, 4].reduce { (a, b) -> Int in
    a+b
}

func ==<T: Equatable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case (nil, nil):
        return true
    case let (x?, y?):
        return x == y
    case (_?, nil),(nil, _?):
        return false
    }
}

infix operator ^^

func ^^(aaa: String, sss: String) {

}



