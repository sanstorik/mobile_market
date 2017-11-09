import Foundation

class MobileCollectionPresenter {
    private let _collection: MobileCollectionViewController
    private var _mobiles = [Mobile]()
    
    private let mobileURL = "https://lumenapi.citrus.ua/catalog/api/search"
    
    var mobilesCount: Int {
        return _mobiles.count
    }
    
    required init(collection: MobileCollectionViewController) {
        _collection = collection
    }
    
    func mobile(at index: Int) -> Mobile {
        return _mobiles[index]
    }
    
    func loadMobiles(atPage page: Int, perPage: Int,
                     completeHandler: @escaping () -> ()) {
        if (_mobiles.count > 0) {
            _mobiles.removeAll()
        }
        
        handleJson(fromUrl: completeJsonURL(page: page, perPage: perPage),
                   handler: completeHandler)
    }
    
    private func completeJsonURL(page: Int, perPage: Int) -> String {
        var url = mobileURL
        url += "?page=\(page)&perPage=\(perPage)"
        url += "&filters%5Bcategory%5D%5B%5D=20"
        return url
    }
    
    private func handleJson(fromUrl url: String, handler: @escaping () -> ()){
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [unowned self] (data,response,error) in
            guard let data = data, error == nil else {
                return
            }
   
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    as! [String: Any]
                
                let dataArray = json["data"] as! [String: Any]
                let mobilesArray = dataArray["list"] as! NSArray
                
                for mobileDictionary in mobilesArray {
                    if let mobile = mobileDictionary as? NSDictionary {
                        let newMobile = Mobile(id: String(describing: mobile["id"]),
                                               title: mobile["name"] as! String,
                                               price: mobile["price"] as! Float,
                                               oldPrice: mobile["base_price"] as! Float,
                                               imageURL: mobile["image"] as? String)!
                        
                        self._mobiles.append(newMobile)
                    }
                }
            } catch {
                print("Couln't parse json")
            }

            DispatchQueue.main.async(execute: { handler() })
        }.resume()
    }
}
