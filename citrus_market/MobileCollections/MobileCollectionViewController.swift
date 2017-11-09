import UIKit

class MobileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "mobile"
    private lazy var _presenter = MobileCollectionPresenter(collection: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(red: 239, green: 239, blue: 243)
        collectionView?.register(MobileCell.self, forCellWithReuseIdentifier: cellId)
        
        _presenter.loadMobiles(atPage: 1, perPage: 10, completeHandler: {
            [unowned self] () -> Void in
            self.collectionView?.reloadData()
        })
        
        setupNavigationBar()
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
                    as! MobileCell
        
        cell.mobile = _presenter.mobile(at: indexPath.row)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _presenter.mobilesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 32) / 2, height: 350)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Смартфоны"
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 231, green: 125, blue: 62)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
