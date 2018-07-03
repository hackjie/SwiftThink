import UIKit

// What's new in Swift 4.2

// 1. Bool.toggle
var girl = true
girl.toggle()

// 2. Sequence and Collection algorithms
// 2.1 allSatisfy
let digits = 1...9
let areAllSmallerThanTen = digits.allSatisfy { $0 < 10 }
areAllSmallerThanTen

let areAllEven = digits.allSatisfy { $0 % 2 == 0 }
areAllEven

// 2.2 add a last(where:) method to Sequence
let lastEvenDigit = digits.last { $0 % 2 == 0 }
lastEvenDigit

// 2.3 add lastIndex(where:) and lastIndex(of:) methods to Collection
let text = "Vamos a la playa"
let lastWrodBreak = text.lastIndex(where: { $0 == " " })
let lastWord = lastWrodBreak.map { text[text.index(after: $0)...] }
lastWord

text.lastIndex(of: " ") == lastWrodBreak

// 3 Enumerating enum cases
// 3.1 allCases
enum Terrain: CaseIterable {
    case water
    case forest
    case desert
    case road
}

Terrain.allCases
Terrain.allCases.count


extension Optional: CaseIterable where Wrapped: CaseIterable {
    public typealias AllCases = [Wrapped?]
    public static var allCases: AllCases {
        return Wrapped.allCases.map { $0 } + [nil]
    }
}

Terrain?.allCases

// 4 Random number
// 4.1 random(in:)
Int.random(in: 1...1000)
UInt8.random(in: .min ... .max)
Double.random(in: 0..<1)

// 4.2 Bool.random
let boy = Bool.random()

// 4.3 Collections get a randomElement
let emotions = "😀😂😊😍🤪😎😩😭😡"
let randomEmotion = emotions.randomElement()!

// 4.4 shuffled method to shuffle a sequence or collection
let numbers = 1...10
let shuffled = numbers.shuffled()

// 4.5 Custom random number generators
// 4.5.1 一个模仿 `Random.default` 的仿制随机数生成器
struct MyRandomNumberGenerator: RandomNumberGenerator {
    var base = Random.default
    mutating func next() -> UInt64 {
        return base.next()
    }
}

//var customRNG = MyRandomNumberGenerator()
//Int.random(in: 0...100, using: &customRNG)

// 4.5.2 扩展自己的类型
enum Suit: String, CaseIterable {
    case diamonds = "♦"
    case clubs = "♣"
    case hearts = "♥"
    case spades = "♠"

    static func random<T: RandomNumberGenerator>(using generator: inout T) -> Suit {
        // Using CaseIterable for the implementation
        return allCases.randomElement(using: &generator)!
    }

    static func random() -> Suit {
        return Suit.random(using: &Random.default)
    }
}

let randomSuit = Suit.random()
randomSuit.rawValue

// 5 Hashable redesign
struct Point {
    var x: Int
    var y: Int
}

extension Point: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

let p1 = Point(x: 3, y: 4)
p1.hashValue
let p2 = Point(x: 4, y: 3)
p2.hashValue
assert(p1.hashValue != p2.hashValue)

// 6 Conditional conformance enhancements (条件一致性增强)

// 7 #error and #warning
func doSomethingImportant() {
    #warning("TODO: missing implementation")
}
doSomethingImportant()

#if canImport(UIKit)

#elseif canImport(AppKit)

#else
    #error("This playground requires UIKit or AppKit")
#endif

// 8 MemoryLayout.offset
struct Circle {
    var x: Float
    var y: Float
    var z: Float
    var a: Float
}

MemoryLayout<Circle>.offset(of: \Circle.a)

