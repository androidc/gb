//Created by chizztectep on 10.05.2023 

import Foundation

class Friend: Identifiable {
internal init(name: String) {
    self.name = name
}
    let id: UUID = UUID()
    let name: String
  
}
