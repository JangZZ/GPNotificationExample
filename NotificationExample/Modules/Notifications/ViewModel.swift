//
//  ViewModel.swift
//  NotificationExample
//
//  Created by TruongGiang on 15/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Nested Input/Output
extension NotificationListViewModel {
    struct Input {
        let viewDidLoad: Observable<Void>
        let searchKeyword: Observable<String?>
        let itemSelected: Observable<IndexPath>
    }

    struct Output {
        var notifications: Driver<[GPNotification]>
    }
}

final class NotificationListViewModel {

    // MARK: - Private properties
    private var _provider: NotificationProviding
    private var _bag = DisposeBag()

    init(provider: NotificationProviding = NotificationProvider.shared) {
        self._provider = provider
    }

    func transform(input: Input) -> Output {
        let allNotifications = BehaviorRelay<[GPNotification]>(value: [])

        /// Get all notifications
        input.viewDidLoad
            .flatMapLatest(_provider.getAllNotification)
            .bind(to: allNotifications)
            .disposed(by: _bag)

        /// Search local notifications
        let searchResult = input.searchKeyword
            .debounce(
                .milliseconds(200),
                scheduler: ConcurrentDispatchQueueScheduler(qos: .background)
            )
            .flatMapLatest { optionalKeyword -> Observable<[GPNotification]> in
                if let keyword = optionalKeyword,
                   !keyword.isEmpty {
                    return .just(allNotifications.value.filter { $0.constant(keyword) })
                } else {
                    return .just(allNotifications.value)
                }
            }

        /// Handle select item
        input.itemSelected
            .map { var currentValue = allNotifications.value
                currentValue.read(at: $0)
                return currentValue
            }
            .bind(to: allNotifications)
            .disposed(by: _bag)


        let displayNotifications = Observable.merge(
            searchResult,
            allNotifications.asObservable()
        )
        /// This example doesn't include handle the `error` or `retrying`
        /// To keep it simple, just return empty value when an error comes in
        .asDriver(onErrorJustReturn: [])

        return Output(
            notifications: displayNotifications
        )
    }
}
