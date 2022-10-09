import UIKit

var greeting = "Hello, playground"

//Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

var vklad:Double = 500.0
let percent:Double = 5.0

func income(vklad:Double,percent:Double) -> Double {
    return vklad*percent/100
}

for year in 1...5 {
    vklad = vklad + income(vklad: vklad, percent: percent)
   // print(vklad)
}

print(vklad)
