import UIKit

extension UIImageView {
    func downloadImage(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit,
                       mobile: Mobile) {
        let cachedMobile = mobile
        if let image = cachedMobile.image {
            self.image = image
            return
        }
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                cachedMobile.image = image
            }
            }.resume()
    }
    func downloadImage(fromUrl url: String, contentMode mode: UIViewContentMode = .scaleAspectFit,
                       mobile: Mobile) {
        guard let url = URL(string: url) else { return }
        downloadImage(from: url, contentMode: mode, mobile: mobile)
    }
}
