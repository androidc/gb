import UIKit

/*1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.*/

struct Queue<T> {
    var array: [T] = []
    
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    mutating func pop() -> T? {
        guard !array.isEmpty else {
            print("array is empty")
            return nil
        }
        
        print(array[0])
        return array.remove(at:0)
    }
    
    subscript(index: Int) -> T? {
        guard !array.isEmpty, index>=0 , index <= array.count - 1 else { return nil}
        return array[index]
    }
    
    func filter (predicate: (T) -> Bool) -> [T] {
        var result = [T]()
        for i in array {
            if predicate(i) {
                result.append(i)
            }
        }
        return result
    }
}

var testQueue = Queue<Int> ()

testQueue.push(1)
testQueue.push(2)
testQueue.push(3)
print(testQueue[1])
let filtered = testQueue.filter {
    $0 % 2 == 0
}
print(filtered)
testQueue.pop()
testQueue.pop()
testQueue.pop()

