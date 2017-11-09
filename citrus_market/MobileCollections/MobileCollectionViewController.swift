import UIKit

class MobileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "mobile"
    private var _mobiles = [Mobile!]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mobile = Mobile(id: "onetwo", title: "iPhone X (Silver 64 GB)",
                            price: 2500, oldPrice: 1400, image: UIImage(named: "mobile"))
        let mobileSecond = Mobile(id: "onetwo", title: "iPhone 8Plus (Black 64 GB)",
                            price: 2500, image: UIImage(named: "mobile"))
        
        _mobiles += [mobile, mobileSecond, mobile]
        
        collectionView?.backgroundColor = UIColor(red: 239, green: 239, blue: 243)
        collectionView?.register(MobileCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationBar()
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
                    as! MobileCell
        
        cell.mobile = _mobiles[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _mobiles.count
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
