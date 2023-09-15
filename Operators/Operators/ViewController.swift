//Created by chizztectep on 12.09.2023 

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var subscriptions = Set<AnyCancellable>()
    private var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // публикация коллекции чисел от 1 до 100
        let values = Array(0...100)
        let publisher = values.publisher
        
//        Пропустите первые 50 значений, выданных вышестоящим издателем.
//        Возьмите следующие 20 значений после этих первых 50.
//        Берите только чётные числа.
        publisher
            .dropFirst(50)
            .prefix(20)
            .filter({ $0 % 2 == 0 })
            .sink { print($0) }
            .store(in: &subscriptions)
        
        // Создайте пример, который собирает коллекцию строк, преобразует её в коллекцию чисел и вычисляет среднее арифметическое этих значений.
           let stringCollection = ["1","2","0","555"]
           let sc_publisher = stringCollection.publisher
           
           sc_publisher
            .tryMap { Int($0)  }
            .compactMap{ $0 }
            .collect()
            .sink { print($0)
            } receiveValue: { value in
                self.count = value.count
            }

           
           sc_publisher
            .tryMap { Double($0) ?? 0.0 }
            .reduce(0.0) { $0 + $1/Double(self.count)}
            .sink { print($0) }
                    receiveValue: { print($0) }
            .store(in: &subscriptions)

    }
    
   
      
    


}

