//Created by chizztectep on 25.03.2023

import Foundation

class RecordsCareTaker {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let key = "records"
    
    func save(_ records: [Record]) throws {
        let data = try encoder.encode(records)
        UserDefaults.standard.set(data,forKey: key)
    }
    
    func retrieveRecords()  -> [Record] {
        guard let data = UserDefaults.standard.data(forKey: key) else {return []}
        
        do {
            return try decoder.decode([Record].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
}
