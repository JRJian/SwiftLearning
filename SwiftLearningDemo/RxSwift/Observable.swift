//
//  Observable.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/3.
//

import Foundation

class Observable {
    
    private let subscribeHandler: SubscribeHandler
    
    public init(_ subscribeHandler: @escaping SubscribeHandler) {
        self.subscribeHandler = subscribeHandler
    }
    
    public func subscribe(eventHandler: @escaping EventHandler) {
        let observer = Observer(eventHandler: eventHandler)
        subscribeHandler(observer)
    }
}

func map(source: Observable, transform: @escaping (_ value: String) -> String) -> Observable {
    return Observable { observer in
        let closure: EventHandler = { value in
            let tranformedValue = transform(value)
            observer.next(value: tranformedValue)
        }
        source.subscribe(eventHandler: closure)
    }
}
