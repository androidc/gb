import UIKit

// Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

let katet1:Double = 2.0
let katet2:Double = 3.0

// гипотенуза
let hypotenuse = sqrt(katet1*katet1+katet2*katet2)
// площадь
let square = (katet1 + katet2) / 2
// периметр
let perimeter = katet1 + katet2 + hypotenuse

print("гипотенуза : \(hypotenuse)")
print("площадь: \(square)")
print("периметр: \(perimeter)")






