//
//  Person.swift
//  SwiftThink
//
//  Created by leoli on 2018/4/9.
//  Copyright © 2018年 leoli. All rights reserved.
//

struct Person: Codable {
    var name: String
    var age: Int
    var ability: Ability

    struct Ability: Codable {
        var math: String
        var physics: String
        var chemistry: String
    }

    enum Appraise: String, Codable {
        case excellent, fine, bad
    }
}

struct CurrencyRate: Codable {
    var base: String
    var date: String
}
