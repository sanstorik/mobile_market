import UIKit

class Mobile {
    let id: String
    var title: String
    var price: Float
    var oldPrice: Float?
    var image: UIImage?
    
    required init?(id: String, title: String, price: Float,
                  oldPrice: Float? = nil, image: UIImage?) {
        if id.isEmpty {
            return nil
        }
        
        self.id = id
        self.title = title
        self.price = price
        self.oldPrice = oldPrice
        self.image = image
    }
}
