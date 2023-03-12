//
//  WeatherModel.swift
//  part2lesson1
//
//  Created by Артем  on 01.02.2023.
//

import Foundation

func createDateTime(timestamp: String) -> String {
    var strDate = "undefined"
        
    if let unixTime = Double(timestamp) {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //Specify your format that you want
        strDate = dateFormatter.string(from: date)
    }
        
    return strDate
}

struct WeatherRoot:Decodable {
    var current: Current
}

struct Current:Decodable {
    var temp: Double
    var weather: [Weather]
    var dt: Date
    
    enum CodingKeys: String , CodingKey {
        //case current
        case temp,weather,dt
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
 
        let t_temp = try container.decode(Double.self, forKey: .temp)

//
        self.temp = t_temp - 273.15 ?? 0.0
    
        
        self.weather = try container.decode([Weather].self, forKey: .weather)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dt = try container.decode(Int.self, forKey: .dt)
        self.dt = formatter.date(from: createDateTime(timestamp: String(dt))) ?? Date()
        
   
        
        
    }
}

struct Weather:Decodable {
    var main: String
    
    enum CodingKeys: String , CodingKey {
        case main
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.main = try container.decode(String.self, forKey: .main)
    }
}
