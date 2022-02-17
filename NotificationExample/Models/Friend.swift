//
//  Friend.swift
//  NotificationExample
//
//  Created by TruongGiang on 15/02/2022.
//

import Foundation
import SwiftyJSON

struct Friend: Equatable {
    let name: String
    let avatar: String

    init(json: JSON) {
        name = json["name"].stringValue
        avatar = json["avatar"].stringValue
    }
}
