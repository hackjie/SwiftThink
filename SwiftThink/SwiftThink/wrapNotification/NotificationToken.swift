//
//  NotificationToken.swift
//  SwiftThink
//
//  Created by leoli on 2018/1/23.
//  Copyright © 2018年 leoli. All rights reserved.
//

import UIKit

final class NotificationToken: NSObject {
    let notificationCenter: NotificationCenter
    let token: Any

    init(notificationCenter: NotificationCenter = .default, token: Any) {
        self.notificationCenter = notificationCenter
        self.token = token
    }

    deinit {
        notificationCenter.removeObserver(token)
    }
}

extension NotificationCenter {
    func observe(name: Notification.Name?, object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> ()) -> NotificationToken {
        let token = addObserver(forName: name, object: obj, queue: queue, using: block)
        return NotificationToken.init(notificationCenter: self, token: token)
    }
}
