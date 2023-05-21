import UIKit

//class MyClass {
//    var myProperty = Logged<Int>(0)
//}


//struct Logged<Value> {
//    private var value: Value
//
//    init(_ value: Value) {
//        self.value = value
//    }
//
//    public func get() -> Value {
//        print("\(Date()). myProperty read: \(value)")
//        return value
//    }
//
//    public mutating func set(_ newValue: Value) {
//        print("\(Date()). myProperty set to: \(newValue)")
//        value = newValue
//    }
//
//}

//class MyClass{
//    @Logged var myProperty = 0
//}
//
//@propertyWrapper
//struct Logged<Value> {
//    private var value: Value
//
//    init(wrappedValue: Value) {
//        self.value = wrappedValue
//    }
//
//    private func get() -> Value {
//        print("\(Date()). myProperty read: \(value)")
//        return value
//        }
//    private mutating func set(_ newValue: Value) {
//        print("\(Date()). myProperty set to: \(newValue)")
//        value = newValue
//    }
//    public var wrappedValue: Value {
//    get {
//        get()
//    }
//    set {
//        set(newValue)
//    }
//    }
//
//}
//
//
//let myClass = MyClass()
//let property = myClass.myProperty
//myClass.myProperty = 1

class MyClass {
    @Logged(formatString: "HH:mm dd.MM.yyyy") var myProperty = 0
}

@propertyWrapper
struct Logged<Value> {
    private var value: Value
    private let dateFormatter: DateFormatter

    init(wrappedValue: Value, formatString: String) {
        self.value = wrappedValue
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = formatString
    }

    private func get() -> Value {
        let dateString = dateFormatter.string(from: Date())
        print("\(dateString). myProperty read: \(value)")
        return value
        }
    private mutating func set(_ newValue: Value) {
        let dateString = dateFormatter.string(from: Date())
        print("\(dateString). myProperty set to: \(newValue)")
        value = newValue
    }
    public var wrappedValue: Value {
    get {
        get()
    }
    set {
        set(newValue)
    }
    }

}

let myClass = MyClass()
let property = myClass.myProperty
myClass.myProperty = 1
