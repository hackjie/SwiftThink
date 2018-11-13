//: Playground - noun: a place where people can play

import UIKit

public protocol SortedSet: BidirectionalCollection, CustomStringConvertible, CustomPlaygroundDisplayConvertible where Element: Comparable {
    init()
    func contains(_ element: Element) -> Bool
    mutating func insert(_ newElement: Element) -> (inserted: Bool, memberAfterInsert: Element)
}

extension SortedSet {
    public var description: String {
        let contents = self.lazy.map { "\($0)" }.joined(separator: ", ")
        return "[\(contents)]"
    }
}
