//
//  ViewController.swift
//  NotificationExample
//
//  Created by TruongGiang on 15/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

/// I prefer `xib` or `Nibless` but for this example to keep it simple, just use a storyboard instead
final class NotificationListViewController: UITableViewController {

    // MARK: - Typealias
    typealias Input = NotificationListViewModel.Input
    typealias Output = NotificationListViewModel.Output

    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var viewModel: NotificationListViewModel = NotificationListViewModel()

    // MARK: - Private properties
    private var _bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
}

// MARK: - Private methods
extension NotificationListViewController {

    private func bindViewModel() {
        let input = Input(
            viewDidLoad: .just(()),
            searchKeyword: searchController.searchBar.rx.text.asObservable(),
            itemSelected: tableView.rx.itemSelected.asObservable()
        )

        let output = viewModel.transform(input: input)

        tableViewBind(output)
    }

    /// Bind data for tableView
    /// - Parameter output: an output from viewModel
    private func tableViewBind(_ output: Output) {
        output.notifications.drive(tableView.rx.items) { tableView, indexPath, notification in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.ID) as? NotificationCell
            else { return .init() }

            cell.bind(notification)

            return cell
        }
        .disposed(by: _bag)
    }
}

// MARK: - Setup UIs
extension NotificationListViewController {

    private func setupUI() {
        setupNavigationBar()
        setupTableView()
        setupSearchBar()
    }

    private func setupTableView() {
        tableView.dataSource = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        definesPresentationContext = true
        searchController.searchBar.placeholder = Constants.searchBarPlaceholder
        tableView.tableHeaderView = searchController.searchBar
    }
}

// MARK: - Constants
extension NotificationListViewController {
    struct Constants {
        static let searchBarPlaceholder = "Search Notifications"
    }
}
