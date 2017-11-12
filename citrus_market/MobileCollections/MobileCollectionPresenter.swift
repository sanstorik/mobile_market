import Foundation
import Alamofire

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
        handleJson(fromUrl: completeJsonURL(page: page, perPage: perPage),
                   handler: completeHandler)
    }
    
    func clearAndLoadMobiles(atPage page: Int, perPage: Int,
                             completeHandler: @escaping () -> ()) {
        _mobiles.removeAll()
        loadMobiles(atPage: page, perPage: perPage,
                    completeHandler: completeHandler)
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
        
        Alamofire.request(url).responseJSON { response in
            guard let json = response.result.value as? [String: Any] else {
                return
            }
            
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
            
            DispatchQueue.main.async {
                handler()
            }
        }
    }
}
