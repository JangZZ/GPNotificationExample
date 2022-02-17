//
//  NotificationProvider.swift
//  NotificationExample
//
//  Created by TruongGiang on 15/02/2022.
//

import Foundation
import RxSwift

protocol NotificationProviding {
    func getAllNotification() -> Single<[GPNotification]>
}

class NotificationProvider {
    /// Singleton
    static let shared = NotificationProvider()

    // MARK: - Properties
    var factory: NotificationProviding

    private init(factory: NotificationProviding = NotificationAPIFactory()) {
        self.factory = factory
    }
}

extension NotificationProvider: NotificationProviding {

    func getAllNotification() -> Single<[GPNotification]> {
        factory.getAllNotification()
    }
}
