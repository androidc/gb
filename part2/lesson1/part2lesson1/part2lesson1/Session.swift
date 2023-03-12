//
//  Session.swift
//  part2lesson1
//
//  Created by Артем  on 10.01.2023.
//

import Foundation


class Session {
    private init() {}
    static let sharedInstance = Session()
    var token: String = ""
    var userId: String = ""
}


