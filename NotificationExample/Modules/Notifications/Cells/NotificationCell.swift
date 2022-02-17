//
//  NotificationCellTableViewCell.swift
//  NotificationExample
//
//  Created by TruongGiang on 15/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class NotificationCell: UITableViewCell {

    // MARK: - Properties
    var bag = DisposeBag()

    // MARK: - Private Properties
    private var _viewModel: ViewModel!

    // MARK: - IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var feelingIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 12
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        bag = DisposeBag()
    }

    func bind(_ notification: GPNotification) {
        _viewModel = ViewModel(notification: notification)

        _viewModel.feelingIcon.drive(feelingIconImageView.rx.image).disposed(by: bag)
        _viewModel.avatar.drive(avatarImageView.rx.image).disposed(by: bag)
        _viewModel.message.drive(messageLabel.rx.attributedText).disposed(by: bag)
        _viewModel.createdDate.drive(createdDateLabel.rx.text).disposed(by: bag)
        _viewModel.backgroundColor.drive(rx.backgroundColor).disposed(by: bag)
    }
}

// MARK: - Constants
extension NotificationCell {
    static let ID = "NotificationCell"
}
