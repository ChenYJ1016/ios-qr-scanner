//
//  QRListCell.swift
//  ios-qr-scanner
//
//  Created by Xufeng Zhang on 21/10/25.
//

import UIKit

final class QRListCell: UICollectionViewCell {
    static let reuseID = "QRListCell"

    private let container = UIView()
    private let iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "qrcode.viewfinder"))
        iv.contentMode = .scaleAspectFit
        iv.setContentHuggingPriority(.required, for: .horizontal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 17, weight: .semibold)
        l.textColor = .label
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let dateLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .regular)
        l.textColor = .secondaryLabel
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 16
        container.layer.masksToBounds = true

        let textStack = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.translatesAutoresizingMaskIntoConstraints = false

        let hStack = UIStackView(arrangedSubviews: [iconView, textStack])
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.spacing = 12
        hStack.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(hStack)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            hStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 14),
            hStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            hStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14),
            hStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -14),

            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    func configure(title: String, dateText: String) {
        titleLabel.text = title
        dateLabel.text = dateText
    }
}
