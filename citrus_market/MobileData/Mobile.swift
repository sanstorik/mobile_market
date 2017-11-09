import UIKit

class Mobile {
    let id: String
    var title: String
    var price: Float
    var oldPrice: Float
    var imageURL: String?
    var image: UIImage?
    
    required init?(id: String, title: String, price: Float,
                  oldPrice: Float = 0, imageURL: String?) {
        if id.isEmpty {
            return nil
        }
        
        self.id = id
        self.title = title
        self.price = price
        self.oldPrice = oldPrice
        self.imageURL = imageURL
    }
}
