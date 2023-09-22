//Created by chizztectep on 22.09.2023 

import Foundation

public struct AvatarInfo: Codable {
    public var id: Int
    public var image: String
    
    public init(id: Int, image: String) {
        self.id = id
        self.image = image
    }
}
