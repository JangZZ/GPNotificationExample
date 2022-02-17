//
//  NotificationAPIFactory.swift
//  NotificationExample
//
//  Created by TruongGiang on 17/02/2022.
//

import Foundation
import RxSwift
import SwiftyJSON

class MockNotificationFactory: NotificationProviding {

    var mockNotifications: [GPNotification] = []

    func getAllNotification() -> Single<[GPNotification]> {
        return .just(mockNotifications)
    }
}

class NotificationAPIFactory: NotificationProviding {

    enum Error: Swift.Error {
        case parserError(String)
        case invalidPath
    }

    func getAllNotification() -> Single<[GPNotification]> {
        return Single.create { promise in
            if let path = Bundle.main.path(
                forResource: Constants.Resources.fileName,
                ofType: Constants.Resources.fileExtension
            ) {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    let jsonObj = try JSON(data: data)

                    promise(.success(jsonObj.arrayValue.map(GPNotification.init(json:))))

                } catch let error {
                    promise(.failure(Error.parserError(error.localizedDescription)))
                }
            } else {
                promise(.failure(Error.invalidPath))
            }

            return Disposables.create()
        }
    }
}
