//
//  String+Extensions.swift
//  NotificationExample
//
//  Created by TruongGiang on 17/02/2022.
//

import UIKit

extension String {
    var toImage: UIImage? {
        return UIImage(named: self)
    }

    func highlight(for subStrings: [String]) -> NSAttributedString {
        let currentAttributeString = NSMutableAttributedString(string: self)

        subStrings.forEach { subString in
            if let range = self.range(of: subString) {
                currentAttributeString.addAttributes([
                    NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
                ],
                range: NSRange(range, in: subString))
            }
        }

        return currentAttributeString as NSAttributedString
    }
}
