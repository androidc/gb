//Created by chizztectep on 06.05.2023 

import Foundation

enum logLevel {
    case Debug
    case Info
    case Error
}

struct Log {
    let day: Int
    let floor: Int
    let status: Status
    let message: String
    let level: logLevel
    let hungry: Int
}

//class Logger {
//    static let shared = Logger()
//
//    func createLog(day: Int, victim: Victim, message: String) -> Log {
//        Log(day: day, victim: victim, message: <#T##String#>)
//    }
//}
