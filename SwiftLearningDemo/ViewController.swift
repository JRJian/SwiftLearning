//
//  ViewController.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/3.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let observable = Observable { obs in
            obs.next(value: "cjt")
        }
        
        let closure: EventHandler = { value in
            print(value)
        }
        
        observable.subscribe(eventHandler: closure)
        
        map(source: observable) { value in
            return "hi " + value
        }.subscribe(eventHandler: closure)
        
        let disposeBag = DisposeBag()
        let sv: UIScrollView = UIScrollView()
    }

}

