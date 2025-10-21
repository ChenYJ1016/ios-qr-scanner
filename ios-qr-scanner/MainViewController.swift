//
//  ViewController.swift
//  ios-qr-scanner
//
//  Created by James Chen on 21/10/25.
//

import UIKit

class MainViewController: UIViewController {
    
    let segmentedControl = UISegmentedControl(items: ["Grid", "List"])
    let layout = UICollectionViewFlowLayout()
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var gridLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 30) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        return layout
    }()

    private var listLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 20
        layout.itemSize = CGSize(width: width, height: 80)
        layout.minimumLineSpacing = 10
        return layout
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        view.backgroundColor = .systemBackground
        title = "QR Codes"
        navigationItem.largeTitleDisplayMode = .always
        
        setupCollectionView()
        setupNavigationBar()
        setupSegmentedControl()
    }
    
    // MARK: Helper methods
    
    private func setupNavigationBar(){
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blue
        
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 30)]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 30, weight: .semibold)]
        
        navigationItem.titleView = segmentedControl
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    private func setupCollectionView(){
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        //add on for this
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.register(QRListCell.self, forCellWithReuseIdentifier: QRListCell.reuseID)
        collectionView.dataSource = self
    }
    
    private func setupSegmentedControl(){
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(layoutChanged), for: .valueChanged)

    }


    @objc private func layoutChanged() {
        let layout = segmentedControl.selectedSegmentIndex == 0 ? gridLayout : listLayout
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
    
    private func setupUI(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    // add on by xf//
    private struct QRItem {
        let text: String
        let date: Date
    }

    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yy, HH:mm"
        return df
    }()

    private var items: [QRItem] = [
        QRItem(text: "https://www.apple.com", date: Date(timeIntervalSinceNow: -1200)),
        QRItem(text: "WIFI:T:WPA;S:MyNetwork;P:password123;;", date: Date(timeIntervalSinceNow: -3600)),
        QRItem(text: "mailto:hello@example.com", date: Date(timeIntervalSinceNow: -7200)),
        QRItem(text: "tel:+1234567890", date: Date(timeIntervalSinceNow: -10800))
    ]
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QRListCell.reuseID, for: indexPath) as! QRListCell
        cell.configure(title: item.text, dateText: dateFormatter.string(from: item.date))
        return cell
    }
    
}
