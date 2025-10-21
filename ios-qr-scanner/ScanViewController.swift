//
//  ScanViewController.swift
//  ios-qr-scanner
//
//  Created by Xufeng Zhang on 21/10/25.
//


import UIKit
import AVFoundation
import QRScanner

final class ScanViewController: UIViewController {

    var onCodeScanned: ((String) -> Void)?

    private var qrScannerView: QRScannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCloseButton()
        setupQRScanner()
    }

    private func setupCloseButton() {
        let close = UIButton(type: .system)
        close.setTitle("Close", for: .normal)
        close.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        close.translatesAutoresizingMaskIntoConstraints = false
        close.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(close)
        NSLayoutConstraint.activate([
            close.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            close.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    @objc private func dismissSelf() { dismiss(animated: true) }

    private func setupQRScanner() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupQRScannerView()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self else { return }
                DispatchQueue.main.async { granted ? self.setupQRScannerView() : self.showAlert() }
            }
        default:
            showAlert()
        }
    }

    private func setupQRScannerView() {
        qrScannerView = QRScannerView(frame: view.bounds)
        qrScannerView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(qrScannerView, at: 0)

        NSLayoutConstraint.activate([
            qrScannerView.topAnchor.constraint(equalTo: view.topAnchor),
            qrScannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            qrScannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            qrScannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        qrScannerView.configure(delegate: self)
        qrScannerView.startRunning()
    }

    private func showAlert() {
        let alert = UIAlertController(
            title: "Camera Required",
            message: "Please allow camera access to scan QR codes.",
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        qrScannerView?.startRunning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        qrScannerView?.stopRunning()
    }
}

extension ScanViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print("Scan error:", error)
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        onCodeScanned?(code)
        dismiss(animated: true)
    }
}
