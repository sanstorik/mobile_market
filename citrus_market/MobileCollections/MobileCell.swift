import UIKit

class MobileCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        setupViews()
        setupBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        
    }
    
    private func setupBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 212, green: 213, blue: 216).cgColor
    }
}
