//Created by chizztectep on 21.05.2023 
// v 1.0.1
import Foundation



@propertyWrapper
struct CodingStyle<Value:CamelCasing> {
    private var _value: Value
    private var _codingStyle: CodingStyleType
    
    init(wrappedValue: Value, codingStyle: CodingStyleType) {
       
        _codingStyle = codingStyle
        switch _codingStyle {
        case .camelCase:
            _value = wrappedValue.camelized as! Value
        case .snakeCase:
            let temp:String = wrappedValue as! String
            _value = temp.replacingOccurrences(of: " ", with: "_") as! Value
        case .kebabCase:
            let temp:String = wrappedValue as! String
            _value = temp.replacingOccurrences(of: " ", with: "-") as! Value
        }
    }
    
    var wrappedValue: Value {
        get {
            _value
        } set  {
            // TODO преобразование в зависимости от codingStyle
            switch _codingStyle {
            case .camelCase:
                _value = newValue.camelized as! Value
            case .snakeCase:
                let temp:String = newValue as! String
                _value = temp.replacingOccurrences(of: " ", with: "_") as! Value
            case .kebabCase:
                let temp:String = newValue as! String
                _value = temp.replacingOccurrences(of: " ", with: "-") as! Value
            }
            
        }
    }
    
    public var projectedValue: CodingStyleType {
        return _codingStyle
    }
    
    
}

protocol CamelCasing {
    var camelized: String { get  }
}

extension String: CamelCasing {
    var uppercasingFirst: String {
        return prefix(1).uppercased() + dropFirst()
    }

    var lowercasingFirst: String {
        return prefix(1).lowercased() + dropFirst()
    }

    var camelized: String {
        guard !isEmpty else {
            return ""
        }

        let parts = self.components(separatedBy: " ")

        let first = String(describing: parts.first!).lowercasingFirst
        let rest = parts.dropFirst().map({String($0).uppercasingFirst})

        return ([first] + rest).joined(separator: "")
    }
    
}




    
    


