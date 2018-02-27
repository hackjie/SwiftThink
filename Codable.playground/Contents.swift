//: Playground - noun: a place where people can play

import UIKit

let sample1Json = """
{
    "id": 1000,
    "name": "基金1",
    "review": null,
}
"""

let sample2Json = """
[
    {
        "id": 1000,
        "name": "基金1",
        "review": "收益高+期限短"
    },
    {
        "id": 1001,
        "name": "基金2",
        "review": "适合短期投资"
    }
]
"""

let sample3Json = """
{
    "text": "Agree!Nice weather!",
    "user": {
        "name": "Jack",
        "icon": "lufy.png"
    },
    "retweetedStatus": {
        "text": "nice weather",
        "user": {
            "name": "Rose",
            "icon": "nami.png"
        }
    }
}
"""

let sample4Json = """
{
    "check0": true,
    "check1": 1,
}
"""

let sample5Json = """
{
    "date": "2017-11-16T02:02:55.000-08:00"
}
"""

class Sample: Codable {
    var id: Int?
    var name: String?
    var review: String?
}

let data = sample1Json.data(using: .utf8)
do {
    let x: Sample = try JSONDecoder().decode(Sample.self, from: data!)
    print(x.id!)
} catch {
    print(error)
}

// 自定义 key
class SampleDefine: Codable {
    var id: Int32?
    var re_name: String?
    var review: String?

    enum CodingKeys: String, CodingKey {
        case id
        case re_name = "name"
        case review
    }
}

// 嵌套模型解析
class Status: Codable {
    var text: String?
    var user: User?
    var retweetedStatus: Status?
}

class User: Codable {
    var name: String?
    var icon: String?
}

let wrapData = sample3Json.data(using: .utf8)
do {
    let x = try JSONDecoder().decode(Status.self, from: wrapData!)
    print(x)
} catch {
    print(error)
}

// 模型数组
let dataArray = sample2Json.data(using: .utf8)
do {
    // decode 解码
    let x: [Sample] = try JSONDecoder().decode([Sample].self, from: data!)
    print(x)
} catch {
    print(error)
}

// 自定义编码解码方法
class SampleEnDe: Codable {
    var id: Int?
    var name: String?
    var review: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case review
    }

    // 自定义编码方法
    public func encode(to encoder: Encoder) throws {
        // 使用 CodingKeys 创建编码器
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(name, forKey: CodingKeys.name)
        try container.encode(review, forKey: CodingKeys.review)
    }

    // 自定义解码方法
    public required init(from decoder: Decoder) throws {
        // 使用 CodingKeys 创建解码器
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: CodingKeys.id)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        review = try container.decode(String.self, forKey: CodingKeys.review)
    }
}

// 日期解析
class SampleDate: Codable {
    var date: String?

    enum CodingKeys: String, CodingKey {
        case date
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: CodingKeys.date)
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let tempDate = format.date(from: dateString)
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date = format.string(from: tempDate!)
    }
}

let dataDate = sample5Json.data(using: .utf8)
do {
    let decoder = JSONDecoder()
    let x: SampleDate = try decoder.decode(SampleDate.self, from: dataDate!)
    print(x)
} catch {
    print(error)
}

// Bool 值解析
// codable 只能解析 true/false, 其他类型如 1/0 会报类型不匹配错误, 返回数据可能需要特殊处理
class SampleBool: Codable {
    var check0: Bool?
    var check1: Bool?

    enum CodingKeys: String, CodingKey {
        case check0
        case check1
    }

    /// 自定义解码方法，处理Bool值为1/0的情况
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        check0 = try container.decode(Bool.self, forKey: CodingKeys.check0)
        check1 = (try container.decode(Int.self, forKey: CodingKeys.check1) == 1) ? true : false
    }
}

// 继承的类使用 Codable 解析
// 注意：继承的类使用codable解析，子类的属性无法正确赋值，通过自定义子类的解码方法可实现继承的类也能使用codable正确解析
class Dog: Codable {
    var name: String?
    var age: Int?
}

class HSQ: Dog {
    var IQ: Int?

    private enum CodingKeys: String, CodingKey {
        case IQ
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        IQ = try container.decode(Int.self, forKey: CodingKeys.IQ)
        try super.init(from: decoder)
    }
}



















