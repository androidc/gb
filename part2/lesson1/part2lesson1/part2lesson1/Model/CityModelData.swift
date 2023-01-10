//
//  CityModelData.swift
//  part2lesson1
//
//  Created by Артем Солохин on 10.12.2022.
//

import UIKit

class CityModelData {
    let image: UIImage?
    let name: String
    
    init(image: UIImage? = nil, name: String) {
        self.image = image
        self.name = name
    }
}
