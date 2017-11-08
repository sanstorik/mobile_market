import UIKit

class MobileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "mobile"
    private var _mobiles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _mobiles += ["1", "2", "3", "4"]
        collectionView?.backgroundColor = UIColor.brown
        collectionView?.register(MobileCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
                    as! MobileCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _mobiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 32) / 2, height: 250)
    }
}


class MobileCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        
    }
}
