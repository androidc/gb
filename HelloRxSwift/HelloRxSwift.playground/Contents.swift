import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

//Observable.of("A","B","C")
//    .subscribe{ event in
//        print(event.element)
//    }
//    .disposed(by: disposeBag)

//Observable.from(["A","B","C"])
//    .subscribe{ event in
//        print(event)
//    }
//    .disposed(by: disposeBag)

//Observable<String>.create { observer in
//    observer.onNext("A")
//    observer.onNext("B")
//    observer.onCompleted()
//    observer.onNext("C")
//    return Disposables.create()
//}.subscribe { element in
//    print(element)
//}
//onError: {error in
//    print(error.localizedDescription)
//}
//onCompleted: {
//    print("completed")
//}
//onDisposed: {
//    print("disposed")
//}.disposed(by: disposeBag)

//let subject = PublishSubject<String>()
//subject.onNext("issue 1")
//subject.onNext("issue 2")
//
//subject.subscribe{ event in
//    print(event)
//}.disposed(by: disposeBag)
//
//subject.onNext("issue 3")
//subject.onNext("issue 24")
