//: Playground - noun: a place where people can play

import UIKit

public protocol NamespaceWrappable {
    // 协议里面只能有声明不能有实现
    associatedtype WrapperType
    var td: WrapperType { get }
    static var td: WrapperType.Type { get }
}

public extension NamespaceWrappable {
    var td: NamespaceWrapper<Self> {
        get {
            return NamespaceWrapper(value: self)
        }
    }

    static var td: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

public struct NamespaceWrapper<Base> {
    public var wrappedValue: Base
    public init(value: Base) {
        self.wrappedValue = value
    }
}

extension String: NamespaceWrappable {}
extension NamespaceWrapper where Base == String {
    func hello() -> String {
        return wrappedValue
    }

    // 需要进行 set 改变值时，因为 get set 只是计算属性，所以这里应该在
    // 方法内部进行 copy 字符串得到另一个 String A, 然后对 A 进行处理返回
    func setHello() -> String {
        var hh = String.init(repeating: wrappedValue, count: 1)
        hh = "hello"
        return hh
    }

    public func reverse() -> String {
        return String(wrappedValue.reversed())
    }
}

var name = "lijie"
print(name.td.setHello())
print(name.td.reverse())
