import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let first = PublishSubject<String>()
let second = PublishSubject<String>()

Observable.combineLatest(first, second) { ($0, $1) }
    .subscribe(onNext: { print($0.0, $0.1) })
          .disposed(by: disposeBag)

first.onNext("1")
second.onNext("A")
first.onNext("2")
second.onNext("B")
second.onNext("C")
second.onNext("D")
first.onNext("3")
first.onNext("4")
