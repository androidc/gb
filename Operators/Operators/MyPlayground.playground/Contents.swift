import UIKit
import Combine
import Foundation


var subscriptions = Set<AnyCancellable>()

func example(of description: String, active: Bool, completion: ()->Void) {
    if active {
        print("------ Example of: \(description) ------")
        completion() }
}

example(of:"Prepend(Output)..",active: false) {
    let publisher = [3,4].publisher
    
    publisher
        .prepend(-1, 0)
        .prepend(1,2)
        .prepend([3, 4])
        .prepend(Set(1...2))
        .sink { print ($0) }
        .store(in: &subscriptions)
}

//------ Example of: Prepend(Output).. ------
//1
//2
//3
//4
//1
//2
//-1
//0
//3
//4


example(of: "prepend(Publisher)", active: false) {
    let publisher1 = [3, 4].publisher
    let publisher2 = [1, 2].publisher
    publisher1
        .prepend(publisher2)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

//------ Example of: prepend(Publisher) ------
//1
//2
//3
//4

example(of: "prepend(Publisher) #2", active: false) {
    let publisher1 = [3, 4].publisher
    let publisher2 = PassthroughSubject<Int, Never>()
    publisher1
        .prepend(publisher2)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    publisher2.send(1)
    publisher2.send(2)
    
    // без "закрытия" второго паблишера первый не продолжит работу
    // если не закрыть, то будет
    //------ Example of: prepend(Publisher) #2 ------
    //1
    //2
    publisher2.send(completion: .finished)
}

//------ Example of: prepend(Publisher) #2 ------
//1
//2
//3
//4


example(of: "append", active: false) {
    let publisher1 = [3, 4].publisher
    let publisher2 = PassthroughSubject<Int, Never>()
    publisher1
        .append(publisher2)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    publisher2.send(1)
    publisher2.send(2)
    publisher2.send(completion: .finished)
}

//------ Example of: append ------
//3
//4
//1
//2

func getEnvironmentVar(_ name: String) -> String? {
    guard let rawValue = getenv(name) else { return nil }
    return String(utf8String: rawValue)
}

//Следующий оператор объединяет значения издателей одного и того же типа в один поток.
example(of: "merge(with:)",active: false) {
let publisher1 = PassthroughSubject<Int, Never>()
let publisher2 = PassthroughSubject<Int, Never>()
publisher1
.merge(with: publisher2)
.sink(receiveCompletion: { _ in print("Completed") },
      receiveValue: { print($0) })
      
    publisher1.send(1)
    publisher1.send(2)
    publisher2.send(3)
    publisher1.send(4)
    publisher2.send(5)
    publisher1.send(completion: .finished)
    publisher2.send(completion: .finished)
}

//------ Example of: merge(with:) ------
//1
//2
//3
//4
//5
//Completed

//Ещё один оператор, который позволяет объединять разные издатели — combineLatest. Он также
//позволяет объединять издателей значений различных типов, что может быть чрезвычайно полезно.
//Однако вместо того, чтобы чередовать значения всех издателей, он выдаёт кортеж с последними
//значениями всех издателей всякий раз, когда какой-либо из них испускает значение.

example(of: "combineLatest", active: false) {
    let publisher1 = PassthroughSubject<Int, Never>()
    let publisher2 = PassthroughSubject<String, Never>()
    publisher1
        .combineLatest(publisher2)
        .sink(receiveCompletion: { _ in print("Completed") },
              receiveValue: { print("P1: \($0), P2: \($1)") })
        .store(in: &subscriptions)
    
    publisher1.send(1)
    publisher1.send(2)
    publisher2.send("a")
    publisher2.send("b")
    publisher1.send(3)
    publisher2.send("c")
    publisher1.send(completion: .finished)
    publisher2.send(completion: .finished)
}

//------ Example of: combineLatest ------
//P1: 2, P2: a
//P1: 2, P2: b
//P1: 3, P2: b
//P1: 3, P2: c
//Completed

//zip ждет пока все паблишеры отстреляются, после чего выдает кортеж
example(of: "zip", active: false) {
    let publisher1 = PassthroughSubject<Int, Never>()
    let publisher2 = PassthroughSubject<String, Never>()
    publisher1
        .zip(publisher2)
        .sink(receiveCompletion: { _ in print("Completed") },
              receiveValue: { print("P1: \($0), P2: \($1)") })
        .store(in: &subscriptions)
publisher1.send(1)
publisher1.send(2)
publisher2.send("a")
publisher2.send("b")
publisher1.send(3)
publisher2.send("c")
publisher2.send("d")
publisher1.send(completion: .finished)
publisher2.send(completion: .finished)
}

//------ Example of: zip ------
//P1: 1, P2: a
//P1: 2, P2: b
//P1: 3, P2: c
//Completed
example(of: "Collecting", active: false) {
    let queue = DispatchQueue(label: "Collect")
    let passSubj = PassthroughSubject<Int, Error>()
    let subscription = passSubj
        .collect(.byTime(queue, .seconds(1.0)))
        .sink(receiveCompletion: { completion in
            print("received the completion", String(describing: completion))
        }, receiveValue: { responseValue in
            print(responseValue)
        })
        .store(in: &subscriptions)
        queue.asyncAfter(deadline: .now() + 0.1, execute: {
        passSubj.send(1)
        })
        queue.asyncAfter(deadline: .now() + 0.2, execute: {
        passSubj.send(2)
        })
        queue.asyncAfter(deadline: .now() + 1, execute: {
        passSubj.send(3)
        })
        queue.asyncAfter(deadline: .now() + 6, execute: {
                passSubj.send(6)
        })
        queue.asyncAfter(deadline: .now() + 3.1, execute: {
        passSubj.send(4)
        })
        queue.asyncAfter(deadline: .now() + 3.2, execute: {
        passSubj.send(5)
        })
}

//------ Example of: Collecting ------
//[1, 2]
//[3]
//[4, 5]
//[6]

example(of: "Collect Count", active: false) {
    let queue = DispatchQueue(label: "Collect")
    let passSubj = PassthroughSubject<Int, Error>()
    let collectMaxCount = 3
    let subscription = passSubj
        .collect(.byTimeOrCount(queue, .seconds(1.0), collectMaxCount))
        .sink(receiveCompletion: { completion in
            print("received the completion", String(describing: completion))
        }, receiveValue: { responseValue in
            print(responseValue)
        })
        .store(in: &subscriptions)
    
    queue.asyncAfter(deadline: .now() + 0.1, execute: {
        passSubj.send(1)
    })
    queue.asyncAfter(deadline: .now() + 0.2, execute: {
        passSubj.send(2)
    })
    queue.asyncAfter(deadline: .now() + 0.3, execute: {
        passSubj.send(3)
    })
    queue.asyncAfter(deadline: .now() + 0.4, execute: {
        passSubj.send(4)
    })
    queue.asyncAfter(deadline: .now() + 0.5, execute: {
        passSubj.send(5)
    })
}

//------ Example of: Collect Count ------
//[1, 2, 3]
//[4, 5]

example(of: "debounce", active: false) {
    let subject = PassthroughSubject<String, Never>()
    let debounced = subject
                    .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
                    .share()
                    
    let typingHelloWorld: [(TimeInterval, String)] = [
    (0.0, "H"),
    (0.1, "He"),
    (0.2, "Hel"),
    (0.3, "Hell"),
    (0.5, "Hello"),
    (0.6, "Hello "),
    (2.0, "Hello W"),
    (2.1, "Hello Wo"),
    (2.2, "Hello Wor"),
    (2.4, "Hello Worl"),
    (2.5, "Hello World")
    ]
    
    let startDate = Date()
    let deltaFormatter: NumberFormatter = {
        let format = NumberFormatter()
        format.negativePrefix = ""
        format.minimumFractionDigits = 1
        format.maximumFractionDigits = 1
        return format
    }()
    
    var deltaTime: String {
        return deltaFormatter.string(for: Date().timeIntervalSince(startDate))!
    }
    
    subject
        .sink { string in
                    print("+\(deltaTime)s: Subject emitted: \(string)")
               }.store(in: &subscriptions)
    
   debounced
        .sink { string in
                print("+\(deltaTime)s: Debounced emitted: \(string)")
              }
            .store(in: &subscriptions)
    for item in typingHelloWorld {
        DispatchQueue.main.asyncAfter(deadline: .now() + item.0) {
            subject.send(item.1)
        }
    }
}

//------ Example of: debounce ------
//+0.1s: Subject emitted: H
//+0.1s: Subject emitted: He
//+0.2s: Subject emitted: Hel
//+0.3s: Subject emitted: Hell
//+0.5s: Subject emitted: Hello
//+0.6s: Subject emitted: Hello
//+1.6s: Debounced emitted: Hello
//+2.1s: Subject emitted: Hello W
//+2.2s: Subject emitted: Hello Wo
//+2.2s: Subject emitted: Hello Wor
//+2.5s: Subject emitted: Hello Worl
//+2.5s: Subject emitted: Hello World
//+3.5s: Debounced emitted: Hello World

example(of: "Throttle", active: false) {
    let subject = PassthroughSubject<String, Never>()
    let throttleDelay = 1.0
    let throttled = subject
                    .throttle(for: .seconds(throttleDelay), scheduler: DispatchQueue.main,
                              latest: false)
    
    let typingHelloWorld: [(TimeInterval, String)] = [
    (0.0, "H"),
    (0.1, "He"),
    (0.2, "Hel"),
    (0.3, "Hell"),
    (0.5, "Hello"),
    (0.6, "Hello "),
    (2.0, "Hello W"),
    (2.1, "Hello Wo"),
    (2.2, "Hello Wor"),
    (2.4, "Hello Worl"),
    (2.5, "Hello World")
    ]
    
    let startDate = Date()
    let deltaFormatter: NumberFormatter = {
        let format = NumberFormatter()
        format.negativePrefix = ""
        format.minimumFractionDigits = 1
        format.maximumFractionDigits = 1
        return format
    }()
    
    var deltaTime: String {
        return deltaFormatter.string(for: Date().timeIntervalSince(startDate))!
    }
    
    subject
        .sink { string in
                    print("+\(deltaTime)s: Subject emitted: \(string)")
               }.store(in: &subscriptions)
    
    throttled
        .sink { string in
                print("+\(deltaTime)s: Throttled emitted: \(string)")
              }
            .store(in: &subscriptions)
    for item in typingHelloWorld {
        DispatchQueue.main.asyncAfter(deadline: .now() + item.0) {
            subject.send(item.1)
        }
    }
}

//------ Example of: Throttle ------
//+0.1s: Subject emitted: H
//+0.1s: Throttled emitted: H
//+0.1s: Subject emitted: He
//+0.2s: Subject emitted: Hel
//+0.3s: Subject emitted: Hell
//+0.5s: Subject emitted: Hello
//+0.6s: Subject emitted: Hello
//+1.1s: Throttled emitted: He
//+2.1s: Subject emitted: Hello W
//+2.1s: Throttled emitted: Hello W
//+2.2s: Subject emitted: Hello Wo
//+2.2s: Subject emitted: Hello Wor
//+2.5s: Subject emitted: Hello Worl
//+2.5s: Subject emitted: Hello World
//+3.2s: Throttled emitted: Hello Wo

example(of: "output(at:)",active: false) {
let publisher = ["A", "B", "C"].publisher
    publisher
        .print("publisher")
        .output(at: 1)
        .sink(receiveValue: { print("Value at index 1 is \($0)") })
        .store(in: &subscriptions)
}
//------ Example of: output(at:) ------
//publisher: receive subscription: (["A", "B", "C"])
//publisher: request unlimited
//publisher: receive value: (A)
//publisher: request max: (1) (synchronous)
//publisher: receive value: (B)
//Value at index 1 is B
//publisher: receive cancel

example(of: "reduce",active: true) {
    let publisher = ["Hel", "lo", " ", "Wor", "ld", "!"].publisher
    publisher
        .print("publisher")
        .reduce("") { accumulator, value in
            accumulator + value
        }
        .sink(receiveValue: { print("Reduced into: \($0)") })
        .store(in: &subscriptions)
}
//
//------ Example of: reduce ------
//publisher: receive subscription: (["Hel", "lo", " ", "Wor", "ld", "!"])
//publisher: request unlimited
//publisher: receive value: (Hel)
//publisher: receive value: (lo)
//publisher: receive value: ( )
//publisher: receive value: (Wor)
//publisher: receive value: (ld)
//publisher: receive value: (!)
//publisher: receive finished
//Reduced into: Hello World!
