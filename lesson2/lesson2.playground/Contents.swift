import UIKit

//Написать функцию, которая определяет, четное число или нет.



func isOdd(_ number: Int) -> Bool {
    return (number % 2 == 0) ? true : false
}

print(isOdd(2))
print(isOdd(3))

//Написать функцию, которая определяет, делится ли число без остатка на 3.

func isDiv3(_ number: Int) -> Bool {
    return (number % 3 == 0) ? true : false
}

print(isDiv3(2))
print(isDiv3(3))
print(isDiv3(33))

// 3. Создать возрастающий массив из 100 чисел.

var arr = Array(stride(from:0,to:100,by:1))
print(arr)

//Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

for value in arr {
    if ((value % 2 ) == 0) || (value % 3 != 0) {
    arr.remove(at: arr.firstIndex(of: value)!)
}
}
print(arr)

// * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.

//5. Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
//func fibonachi(_ n:Int) -> Int {
//    if n==1 || n==2 {return 1}
//    return fibonachi(n - 1) + fibonachi(n-2)
//}
//
//var fibonachiArray : [Int] = []
//
//// iterate from i = 1 to 1 = 3
//for i in 1...30 {
//    fibonachiArray.append(fibonachi(i))
//}
//
//print(fibonachiArray)
let start = CFAbsoluteTimeGetCurrent()

func fibonachi(_ n:Int) -> [Int] {
    var arr:[Int] = [1,1]
    for i in 2...n {
        arr.append(arr[i-1] + arr[i-2])
    }
    return arr
}

print(fibonachi(50))
let diff = CFAbsoluteTimeGetCurrent() - start
print("Took \(diff) seconds")

//6. Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу.
var counter: Int = 0
var i: Int = 0
var resultArray: [Int] = []

func primeNumber(_ number: Int) -> Bool {
    guard number>=2 else {return false}
    
    for i in 2 ..< number {
        if number % i == 0 {
            return false
        }
    
    }
    return true
}

let start1 = CFAbsoluteTimeGetCurrent()
while counter < 100 {
    if primeNumber(i) {
        resultArray.append(i)
        counter+=1
        i+=1
    } else {
        i+=1
    }
}

print(resultArray)
let diff1 = CFAbsoluteTimeGetCurrent() - start1
print("Took \(diff1) seconds")

