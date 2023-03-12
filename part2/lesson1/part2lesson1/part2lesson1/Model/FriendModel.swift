//
//  FriendModel.swift
//  part2lesson1
//
//  Created by Артем  on 19.12.2022.
//

import UIKit

class FriendModel {
    let image: UIImage?
    let name: String
    
    init(image: UIImage? = nil, name: String) {
        self.image = image
        self.name = name
    }
}

