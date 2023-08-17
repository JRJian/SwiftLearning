//
//  Observer.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/3.
//

import Foundation

typealias EventHandler = (String) -> Void
typealias SubscribeHandler = (Observer) -> Void

class Observer {
    private let _eventHandler: EventHandler
    init(eventHandler: @escaping EventHandler) {
        self._eventHandler = eventHandler
    }
    
    func next(value: String) {
        _eventHandler(value)
    }
}

