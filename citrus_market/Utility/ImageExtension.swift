import UIKit

extension UIImageView {
    func downloadImage(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
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
            }
            }.resume()
    }
    func downloadImage(fromUrl url: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: url) else { return }
        downloadImage(from: url, contentMode: mode)
    }
}
