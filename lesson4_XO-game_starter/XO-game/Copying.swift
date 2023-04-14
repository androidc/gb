//Created by chizztectep on 10.04.2023

// v 1.0 -  State, Prototype, command

import Foundation

protocol Copying {
    init(_ prototype: Self)
}

extension Copying {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}
