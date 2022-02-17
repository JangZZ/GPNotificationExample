//
//  NotificationCell+ViewModel.swift
//  NotificationExample
//
//  Created by TruongGiang on 17/02/2022.
//

import Foundation
import RxCocoa

extension NotificationCell {
    struct ViewModel {
        let message: Driver<NSAttributedString>
        let avatar: Driver<UIImage?>
        let feelingIcon: Driver<UIImage?>
        let createdDate: Driver<String>
        let backgroundColor: Driver<UIColor?>

        init(notification: GPNotification) {
            message = .just(notification.message.highlightText).asDriver()
            avatar = .just(notification.friend.avatar.toImage).asDriver()
            feelingIcon  = .just(notification.subIcon.toImage).asDriver()
            createdDate = .just(notification.createdDate).asDriver()

            backgroundColor = Driver.just(notification.isReaded)
                .map { $0 ? UIColor(named: Constants.Color.readNotifyColor)
                    : UIColor(named: Constants.Color.unreadNotifyColor)
                }
                .asDriver()
        }
    }
}
