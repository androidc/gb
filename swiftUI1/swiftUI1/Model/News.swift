//Created by chizztectep on 10.05.2023

// v 1.0.0

import Foundation

class News: Identifiable {
    internal init(header: String, text: String) {
    self.header = header
    self.text = text
}
    let id: UUID = UUID()
    let header: String
    let text: String
}
