//
//  TestNotificationFactory.swift
//  NotificationExampleTests
//
//  Created by TruongGiang on 16/02/2022.
//

@testable import NotificationExample

import XCTest
import RxSwift
import RxCocoa
import SwiftyJSON
import RxTest
import RxBlocking


class NotificationProviderTest: XCTestCase {

    var provider = NotificationProvider.shared

    override func setUp() {
        super.setUp()

        let mockFactory = MockNotificationFactory()
        let mockNotifications = prepareMockNotifications()
        mockFactory.mockNotifications = mockNotifications

        provider.factory = mockFactory
    }

    func testGetAllNotification() throws {
        XCTAssertFalse(
            try provider.getAllNotification()
                .toBlocking()
                .first()!.isEmpty
        )
    }
}

func prepareMockNotifications() -> [GPNotification] {
    let mockString = """
       {
          "message":{
             "text": "Expected Value",
             "highlights":[
                "Vintage Lab"
             ]
          },
          "isReaded": false,
          "friend":{
             "name":"Vintage Lab",
             "avatar":"ic_user2"
          },
          "subIcon":"ic_bell",
          "createdDate":"20/09/2019, 11:57"
       }
    """
    let mockJSON = JSON(parseJSON: mockString)
    return [GPNotification(json: mockJSON)]
}
