//
//  Message.swift
//  NotificationExample
//
//  Created by TruongGiang on 15/02/2022.
//

import Foundation
import SwiftyJSON

extension GPNotification {
    struct Message: Equatable {
        let text: String
        var highlights: [String]

        init(json: JSON) {
            text = json["text"].stringValue
            highlights = (json["highlights"].arrayObject as? [String]) ?? []
        }
    }
}

extension GPNotification.Message {
    var highlightText: NSAttributedString {
        return text.highlight(for: highlights)
    }
}
