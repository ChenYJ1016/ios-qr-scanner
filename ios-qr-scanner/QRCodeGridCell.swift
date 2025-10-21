//
//  QRCodeGridCell.swift
//  ios-qr-scanner
//
//  Created by James Chen on 21/10/25.
//

import UIKit

class QRCodeGridCell: UICollectionViewCell{
    
    static let reuseIdentifier = "GridCell"
    
    private let qrCodeImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(systemName: "qrcode")
            imageView.tintColor = .white
            return imageView
        }()
    
    private let urlLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.backgroundColor = .systemTeal
        contentView.layer.cornerRadius = 8
        
        cellStackView.addArrangedSubview(qrCodeImageView)
        cellStackView.addArrangedSubview(urlLabel)
        cellStackView.addArrangedSubview(dateLabel)
        
        contentView.addSubview(cellStackView)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
                    cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                    cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                    cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                    cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                    
                    qrCodeImageView.heightAnchor.constraint(equalTo: qrCodeImageView.widthAnchor)
                ])
    }
    
    func configure(with qrCode: QRCode){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        urlLabel.text = qrCode.url
        dateLabel.text = formatter.string(from: qrCode.date)

        qrCodeImageView.image = UIImage(systemName: "qrcode")
        qrCodeImageView.tintColor = .white

    }
}

