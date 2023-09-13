//
//  Observable.swift
//  SeSAC3Week4
//
//  Created by 서승우 on 2023/09/13.
//

import Foundation

final class Observable<T> {

    private var listener: ((T) -> ())?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> ()) {
        listener = closure
    }
}
