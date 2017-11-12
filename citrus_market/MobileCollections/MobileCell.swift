import UIKit
import os.log

class MobileCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        setupBorder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let mobileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 161, green: 161, blue: 165)
        label.numberOfLines = 2
        
        return label
    }()
    
    let oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 161, green: 161, blue: 165)
        label.numberOfLines = 1
        
        let attributedText = NSMutableAttributedString(string: label.text ?? "")
        attributedText.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                    value: 1, range: NSMakeRange(0, label.text?.count ?? 0))
        
        label.attributedText = attributedText
        
        return label
    }()
    
    let actualPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.numberOfLines = 1
        
        return label
    }()
    
    private var _redEyeButton: UIButton!
    private var _addToShoppingListButton: UIButton!
    private var _addToFavoriteButton: UIButton!
    
    var eventHolder: ((_ mobile: Mobile?) -> Void)?
    
    var mobile: Mobile? {
        didSet {
            removeViews()
            setupViews()
            updateViewsOnDataChange(mobile: mobile)
        }
    }
    
    private func removeViews() {
        if _redEyeButton == nil {
            return
        }
        
        _redEyeButton.removeFromSuperview()
        _addToFavoriteButton.removeFromSuperview()
        _addToFavoriteButton.removeFromSuperview()
        actualPriceLabel.removeFromSuperview()
        oldPriceLabel.removeFromSuperview()
        nameLabel.removeFromSuperview()
        mobileImageView.removeFromSuperview()
    }

    private func setupViews() {
        _redEyeButton = createButton(imageName: "ic_remove_red_eye",
                                     action: #selector(redEyeButtonClick))
        _addToFavoriteButton = createButton(imageName: "ic_favorite",
                                             action: #selector(addToFavoriteButtonClick))
        _addToShoppingListButton = createButton(imageName: "ic_add_shopping_card",
                                                imageColor: UIColor(red: 228, green: 85, blue: 0),
                                                action: #selector(addToShoppingListButtonClick))
        
        var height = 10 + frame.height / 1.66
        
        mobileImageView.frame = CGRect(x: 20, y: 10,
                                       width: frame.width - 40,
                                       height:  height)
        addSubview(mobileImageView)
        
        nameLabel.frame = CGRect(x: 12, y: height + 5,
                                 width: frame.width * 0.9, height: 45)
        addSubview(nameLabel)
        height += 49
        
        var xOffset: CGFloat = 12
        if mobile?.oldPrice != 0 {
            oldPriceLabel.frame = CGRect(x: 12, y: height + 4,
                                     width: 50, height: 20)
            xOffset = 62
            addSubview(oldPriceLabel)
        }
        
        actualPriceLabel.frame = CGRect(x: xOffset, y: height - 8,
                                        width: frame.width / 3, height: 40)
        addSubview(actualPriceLabel)
        
        _redEyeButton.frame = CGRect(x: 0, y: frame.height - 50,
                                     width: frame.width / 3,
                                     height: 50)
        
        _addToFavoriteButton.frame = CGRect(x: frame.width / 3, y: frame.height - 50,
                                            width: frame.width / 3,
                                            height: 50)
        
        _addToShoppingListButton.frame = CGRect(x: frame.width - (frame.width / 3),
                                                y: frame.height - 50,
                                                width: frame.width / 3,
                                                height: 50)
        addSubview(_redEyeButton)
        addSubview(_addToFavoriteButton)
        addSubview(_addToShoppingListButton)
    }
    
    private func setupBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 212, green: 213, blue: 216).cgColor
    }
    
    private func createButton(imageName: String,
                              imageColor: UIColor = UIColor(red: 204, green: 204, blue: 204),
                              action: Selector) -> UIButton {
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        
        let button = UIButton()
        button.setImage(tintedImage, for: .normal)
        button.contentMode = UIViewContentMode.center
        button.tintColor = imageColor
        
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 212, green: 213, blue: 216).cgColor
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
    
    @objc private func redEyeButtonClick() {
        eventHolder?(mobile)
    }
    
    @objc private func addToFavoriteButtonClick() {
        NSLog("Favorite button clicked, mobile id = \(mobile!.id)")
    }
    
    @objc private func addToShoppingListButtonClick() {
        NSLog("Shopping list clicked, mobile id = \(mobile!.id)")
    }
    
    private func updateViewsOnDataChange(mobile: Mobile?) {
        guard let nonNullMobile = mobile else {
            return
        }
        
        nameLabel.text = nonNullMobile.title
        actualPriceLabel.text = nonNullMobile.price.asCurrency() + "₴"
        
        if nonNullMobile.oldPrice != 0 {
            let value = nonNullMobile.oldPrice.asCurrency()
            
            let attributedText = NSMutableAttributedString(string: value)
            attributedText.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                        value: 1, range: NSMakeRange(0, value.count))
            oldPriceLabel.attributedText = attributedText
        }
        
        if let url = nonNullMobile.imageURL {
            mobileImageView.downloadImage(fromUrl: url)
        }
    }
}
