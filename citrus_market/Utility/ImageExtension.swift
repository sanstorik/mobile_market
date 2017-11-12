import UIKit
import Alamofire

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func downloadImage(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        
        contentMode = mode
        image = nil
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            image = cachedImage
            return
        }
        
        Alamofire.request(url).responseData { response in
            guard
                let mimeType = response.response?.mimeType, mimeType.hasPrefix("image"),
                let data = response.data, response.error == nil,
                let image = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async() {
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                self.image = image
            }
            }
    }
    
    func downloadImage(fromUrl url: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: url) else { return }
        downloadImage(from: url, contentMode: mode)
    }
}
