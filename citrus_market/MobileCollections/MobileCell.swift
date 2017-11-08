import UIKit
import os.log

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
    
    let mobileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mobile")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Doogee X5 Max (Black)"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 161, green: 161, blue: 165)
        label.numberOfLines = 2
        
        return label
    }()
    
    let oldPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "1 999"
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
        label.text = " 1 899$"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.numberOfLines = 1
        
        return label
    }()
    
    private var _redEyeButton: UIButton!
    private var _addToShoppingListButton: UIButton!
    private var _addToFavouriteButton: UIButton!
    
    
    private func setupViews() {
        _redEyeButton = createButton(imageName: "ic_remove_red_eye",
                                     action: #selector(redEyeButtonClick))
        _addToFavouriteButton = createButton(imageName: "ic_favorite",
                                             action: #selector(addToFavoriteButtonClick))
        _addToShoppingListButton = createButton(imageName: "ic_add_shopping_card",
                                                imageColor: UIColor(red: 228, green: 85, blue: 0),
                                                action: #selector(addToShoppingListButtonClick))
        
        var height = 7 + frame.height / 1.7
        
        mobileImageView.frame = CGRect(x: 0, y: 7, width: frame.width, height: height)
        addSubview(mobileImageView)
        
        nameLabel.frame = CGRect(x: 12, y: height + 4,
                                 width: frame.width * 0.9, height: 45)
        addSubview(nameLabel)
        height += 49
        
        oldPriceLabel.frame = CGRect(x: 12, y: height + 4,
                                     width: 40, height: 20)
        addSubview(oldPriceLabel)
        
        actualPriceLabel.frame = CGRect(x: 52, y: height - 8,
                                        width: frame.width / 3, height: 40)
        addSubview(actualPriceLabel)
        height += 24
        
        _redEyeButton.frame = CGRect(x: 0, y: frame.height - 50,
                                     width: frame.width / 3,
                                     height: 50)
        
        _addToFavouriteButton.frame = CGRect(x: frame.width / 3, y: frame.height - 50,
                                            width: frame.width / 3,
                                            height: 50)
        
        _addToShoppingListButton.frame = CGRect(x: frame.width - (frame.width / 3),
                                                y: frame.height - 50,
                                                width: frame.width / 3,
                                                height: 50)
        
        addSubview(_redEyeButton)
        addSubview(_addToFavouriteButton)
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
        os_log("red eye")
    }
    
    @objc private func addToFavoriteButtonClick() {
        os_log("favorite click")
    }
    
    @objc private func addToShoppingListButtonClick() {
        os_log("shopping list")
    }
}
