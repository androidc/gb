import UIKit

// задание 1. решить квадратное уравнение
// Уравнение вида a⋅x2 + b⋅x + c = 0 — квадратное уравнение.

// a, b, c — действительные числа, a ≠ 0.

let a:Double = 1.0
let b:Double = 2.0
let c:Double = -3.0
print("start program")
// вычисляем дискриминант
let d:Double = b*b - 4*a*c
if d<0 {
    print("уравнение не имеет корней")
} else if d == 0 {
    print("уравнение имеет два одинаковых корня")
    print("x1,x2 = \(-b/(2*a))")
} else {
    print("уравнение имеет два разных корня")
    let x1 = (-b + sqrt(d)) / (2*a)
    let x2 = (-b - sqrt(d)) / (2*a)
    print("x1 = \(x1)")
    print("x2 = \(x2)")
}
print("end program")
