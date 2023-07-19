//Created by chizztectep on 18.07.2023 

import Foundation

struct CatalogData {
    var productId: Int
    var price: Int
    var name: String
}

class CatalogDataDirectory {
    static let shared = CatalogDataDirectory()
    var catalog:[CatalogData] = []
    
    private init() {
        catalog.append(CatalogData(productId: 123, price: 45600, name: "Ноутбук"))
        catalog.append(CatalogData(productId: 456, price: 1000, name: "Мышка"))
    }
    
    func getPriceById(id: Int) -> Int{
        return catalog.filter{ $0.productId == id }.first?.price ?? -1
    }
    
    func getNameById(id:Int) -> String {
        return catalog.filter{ $0.productId == id }.first?.name ?? ""
    }
}
