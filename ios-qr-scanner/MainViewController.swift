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
    }
    
    private func setupSegmentedControl(){
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(layoutChanged), for: .valueChanged)

    }


    @objc private func layoutChanged() {
        let layout = segmentedControl.selectedSegmentIndex == 0 ? gridLayout : listLayout
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func setupUI(){
        
    }
}

