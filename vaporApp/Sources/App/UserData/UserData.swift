//Created by chizztectep on 18.07.2023 

import Foundation

struct UserBasket {
    let productId: Int
    let quantity: Int
    let name: String
}

class UserData {
    static let shared = UserData()
    var userBasket:[UserBasket] = []
    
    private init() { }
    
    func getBasket() -> [GetBasketResponse] {
        
        var result: [GetBasketResponse] = []
        
        userBasket.forEach({ item in
            result.append(GetBasketResponse(id_product: item.productId, quantity: item.quantity,
                                            price: CatalogDataDirectory.shared.getPriceById(id: item.productId) * item.quantity, name: item.name
                ))
        })
        
        return result
    }
}
