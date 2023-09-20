import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

//Создайте первый издатель, производный от Subject, который испускает строки.
let publisher = PassthroughSubject<String, Never>()
//Используйте .collect() со стратегией .byTime для группировки данных через каждые 0.5 секунд.
let queue = DispatchQueue(label: "Collect")
let subscription = publisher
    .collect(.byTime(queue, .seconds(0.5)))
    .sink(receiveCompletion: { completion in
        print("received the completion", String(describing: completion))
    }, receiveValue: { responseValue in
        print(responseValue)
    })
    .store(in: &subscriptions)

queue.asyncAfter(deadline: .now() + 0.1, execute: {
    publisher.send("1")
})
queue.asyncAfter(deadline: .now() + 0.2, execute: {
    publisher.send("2")
})
queue.asyncAfter(deadline: .now() + 1, execute: {
    publisher.send("3")
})
queue.asyncAfter(deadline: .now() + 6, execute: {
    publisher.send("6")
})
queue.asyncAfter(deadline: .now() + 3.1, execute: {
    publisher.send("4")
})
queue.asyncAfter(deadline: .now() + 3.2, execute: {
    publisher.send("5")
})
