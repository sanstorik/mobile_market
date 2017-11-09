import Foundation

extension Float {
    public func asCurrency() -> String {
        var string = String(describing: Int(self))
        
        if string.count > 3 {
            string.insert(" ", at: string.index(string.endIndex, offsetBy: -3))
        }
        
        return string
    }
}

