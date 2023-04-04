//Created by chizztectep on 01.04.2023
// v.1.0.1 - hw pattern l2 strategy, facade, observer, builder

import Foundation

class QuestionsCareTaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let key = "questions"
    
    func save(_ records: QuestionsForCareTaker) throws {
        let data = try encoder.encode(records)
        UserDefaults.standard.set(data,forKey: key)
    }
    
    func retrieveRecords()  -> QuestionsForCareTaker {
        guard let data = UserDefaults.standard.data(forKey: key) else {return QuestionsForCareTaker()}
        
        do {
            return try decoder.decode(QuestionsForCareTaker.self, from: data)
        } catch {
            print(error)
            return QuestionsForCareTaker()
        }
    }
    
}
