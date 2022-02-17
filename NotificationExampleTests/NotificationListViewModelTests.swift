//
//  NotificationListViewModelTests.swift
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

class NotificationListViewModelTest: XCTestCase {

    var viewModel: NotificationListViewModel!

    override func setUp() {
        super.setUp()

        let mockFactory = MockNotificationFactory()
        let mockNotifications = prepareMockNotifications()
        mockFactory.mockNotifications = mockNotifications

        NotificationProvider.shared.factory = mockFactory

        viewModel = NotificationListViewModel()
    }

    func testTransformInputToOutputWithViewDidLoadTrigger() throws {
        let input = NotificationListViewModel.Input(
            viewDidLoad: .just(()),
            searchKeyword: .just(nil),
            itemSelected: .just(IndexPath(row: 0, section: 0))
        )

        let output = viewModel.transform(input: input)

        XCTAssertFalse(
            try output.notifications
            .toBlocking(timeout: 2).first()!.isEmpty
        )
    }

    func testTransformInputToOutputWithSearchKeywordMatching() throws {
        let input = NotificationListViewModel.Input(
            viewDidLoad: .just(()),
            searchKeyword: .just("Expected Value"),
            itemSelected: .just(IndexPath(row: 0, section: 0))
        )

        let output = viewModel.transform(input: input)

        XCTAssertFalse(
            try output.notifications
                .toBlocking().first()!.isEmpty
        )
    }

    func testTransformInputToOutputWithSearchKeywordNotMatching() throws {
        let input = NotificationListViewModel.Input(
            viewDidLoad: .just(()),
            searchKeyword: .just("Should Not Matching"),
            itemSelected: .just(IndexPath(row: 0, section: 0))
        )

        let output = viewModel.transform(input: input)

        XCTAssertTrue(
            try output.notifications
                .toBlocking().first()!.isEmpty
        )
    }

    func testTransformInputToOutputWithItemSelectedTrigger() throws {

        let input = NotificationListViewModel.Input(
            viewDidLoad: .just(()),
            searchKeyword: .just(nil),
            itemSelected: .just(IndexPath(row: 0, section: 0))
        )

        let output = viewModel.transform(input: input)

        XCTAssertTrue(
            try output.notifications
            .toBlocking().first()!.first!.isReaded
        )
    }
}
