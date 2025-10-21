import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    let segmentedControl = UISegmentedControl(items: ["Grid", "List"])
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var qrCodes: [QRCode] = [
        QRCode(url: "https://www.apple.com/", date: Date.now)
    ]
    
    private var gridLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()

//    private var listLayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        return layout
//    }()
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "QR Codes"
        
        setupNavigationBar()
        
//        setupSegmentedControl()
        
        setupCollectionView()
        

        collectionView.collectionViewLayout = gridLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - Helper methods
    
    private func setupNavigationBar(){
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemTeal
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 30)]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 30, weight: .semibold)]
                
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    private func setupCollectionView(){

        collectionView.register(QRCodeGridCell.self, forCellWithReuseIdentifier: QRCodeGridCell.reuseIdentifier)
    }
    
    private func setupSegmentedControl(){
        segmentedControl.selectedSegmentIndex = 0
       
        segmentedControl.addAction(UIAction(handler: { _ in
            self.layoutChanged()
        }), for: .touchUpInside)
    }

    private func layoutChanged() {
//        let layout = segmentedControl.selectedSegmentIndex == 0 ? gridLayout : listLayout
        let layout = gridLayout
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.reloadData()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([

            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if qrCodes.count == 0 {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
            noDataLabel.text = "No QR Codes saved yet!"
            noDataLabel.textColor = UIColor.gray
            noDataLabel.textAlignment = .center
            collectionView.backgroundView = noDataLabel
        } else {
            collectionView.backgroundView = nil
        }
        
        return qrCodes.count
    
    }

}

extension MainViewController: UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        if segmentedControl.selectedSegmentIndex == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QRCodeGridCell.reuseIdentifier, for: indexPath) as? QRCodeGridCell else {
                fatalError("Unable to dequeue QRCodeGridCell")
            }
            
            let qrCode = qrCodes[indexPath.item]
            
            cell.configure(with: qrCode)
            

            return cell
//        }
//
//        return UICollectionViewCell()
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {


        let contentWidth = collectionView.bounds.width -
                             collectionView.safeAreaInsets.left -
                             collectionView.safeAreaInsets.right

        if collectionViewLayout == gridLayout {
            let spacing = gridLayout.minimumInteritemSpacing
            let totalPadding = gridLayout.sectionInset.left + gridLayout.sectionInset.right + spacing
            let width = (contentWidth - totalPadding) / 2
            
            let validWidth = max(0, width)
            return CGSize(width: validWidth, height: validWidth)

//        } else if collectionViewLayout == listLayout {
//            let totalPadding = listLayout.sectionInset.left + listLayout.sectionInset.right
//            let width = contentWidth - totalPadding
//            
//            let validWidth = max(0, width)
//            return CGSize(width: validWidth, height: 80)
        }

        return CGSize(width: 50, height: 50)
    }
}
