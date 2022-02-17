//
//  Message.swift
//  NotificationExample
//
//  Created by TruongGiang on 15/02/2022.
//

import Foundation
import SwiftyJSON

protocol Readable {
    mutating func read()
}

extension GPNotification {
    mutating func read() {
        isReaded = true
    }
}

struct GPNotification: Readable, Equatable {
    var message: Message
    var isReaded: Bool
    var friend: Friend
    var createdDate: String
    var subIcon: String
}

extension GPNotification {
    init(json: JSON) {
        message = Message(json: json["message"])
        isReaded = json["isReaded"].boolValue
        friend = Friend(json: json["friend"])
        createdDate = json["createdDate"].stringValue
        subIcon = json["subIcon"].stringValue
    }
}

extension GPNotification {

    func constant(_ keyword: String) -> Bool {
        let lowercaseVersion = keyword.lowercased()
        return message.text.lowercased().contains(lowercaseVersion)
        || createdDate.lowercased().contains(lowercaseVersion)
    }
}
