//
//  SceneDelegate.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/3.
//

import UIKit
import DeviceActivity

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        print("Quick Start")
//        
//        var list = [65, 58, 95, 10, 57, 62, 13, 106, 78, 23, 85]
//        Algorithm.QuickSort(list: &list, low: 0, high: list.count - 1)
//        print("Quick End")
//        
//        print("Insert Start")
//        var list2 = [65, 58, 95, 10, 57, 62, 13, 106, 78, 23, 85]
//        print(Algorithm.InsertSort(list: list2))
//        print("Insert End")
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

