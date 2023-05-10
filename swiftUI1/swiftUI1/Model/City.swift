//Created by chizztectep on 10.05.2023 

import Foundation

class City: Identifiable {
internal init(name: String, imageName: String) {
    self.name = name
    self.imageName = imageName
}
    let id: UUID = UUID()
    let name: String
    let imageName: String
}
