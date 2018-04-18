//
//  Repeater.swift
//  SwiftThink
//
//  Created by leoli on 2018/4/18.
//  Copyright © 2018年 leoli. All rights reserved.
//

import Foundation

open class Repeater: Equatable {

    public enum State: Equatable, CustomStringConvertible {
        case paused
        case running
        case executing
        case finished

        public static func ==(lhs: Repeater.State, rhs: Repeater.State) -> Bool {
            switch (lhs, rhs) {
            case (.paused, .paused),
                 (.running, .running),
                 (.executing, .executing),
                 (.finished, .finished):
                return true
            default:
                return false
            }

        }


        public var description: String {
            switch self {
            case .paused: return "paused"
            case .running: return "running"
            case .executing: return "executing"
            case .finished: return "finished"
            }
        }


    }


    public static func ==(lhs: Repeater, rhs: Repeater) -> Bool {
        return lhs === rhs
    }


}
