//
//  QRCodeDetailViewController.swift
//  ios-qr-scanner
//
//  Created by James Chen on 21/10/25.
//

import UIKit

class QRCodeDetailViewController: UITableViewController {

    var qrCode: QRCode?
    
    private let qrCodeImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.magnificationFilter = .nearest 
            return imageView
        }()
        
        private let urlLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            label.textColor = .label
            label.numberOfLines = 0
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let dateLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textColor = .secondaryLabel
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 16
            stackView.alignment = .center
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
        configure()
    }

    private func setupUI() {
        // Add subviews
        stackView.addArrangedSubview(qrCodeImageView)
        stackView.addArrangedSubview(urlLabel)
        stackView.addArrangedSubview(dateLabel)
        view.addSubview(stackView)
        
        // Set constraints
        NSLayoutConstraint.activate([
            // Constrain the stack view to the center with padding
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Give the QR code image a size (e.g., 200x200)
            qrCodeImageView.widthAnchor.constraint(equalToConstant: 200),
            qrCodeImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configure() {
            guard let qrCode = qrCode else { return }
            
            urlLabel.text = qrCode.url
            
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            dateLabel.text = "Scanned: \(formatter.string(from: qrCode.date))"
            
            qrCodeImageView.image = qrCode.generatedImage
        }
}
