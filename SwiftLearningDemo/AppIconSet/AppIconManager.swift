//
//  AppIconManager.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/10.
//
//  操作流程
//  Add an alternative app icon to the Assets catalog (iOS App Icon)
//  In Build Settings change the option "Include All App Icon Assets" to Yes

import Foundation
import UIKit

enum AppIcon: CaseIterable {
    case classic,
         cookie,
         donut,
         cake,
         iceCream
    
    var name: String? {
        switch self {
        case .classic:
            return nil
        case .cookie:
            return "AppIcon_2"
        case .donut:
            return "AppIcon"
        case .cake:
            return "cakeIcon"
        case .iceCream:
            return "iceCreamIcon"
        }
    }
    
    var preview: UIImage {
        switch self {
        case .classic:
            return #imageLiteral(resourceName: "cake@2x.png")
        case .cookie:
            return #imageLiteral(resourceName: "cookie@2x.png")
        case.donut:
            return #imageLiteral(resourceName: "donut@2x.png")
        case .cake:
            return #imageLiteral(resourceName: "cake@2x.png")
        case .iceCream:
            return #imageLiteral(resourceName: "iceCream@2x.png")
        }
    }
}

struct AppIconManager {
    
    static let shared = AppIconManager()
    
    var current: AppIcon {
        return AppIcon.allCases.first(where: {
            $0.name == UIApplication.shared.alternateIconName
        }) ?? .classic
    }

    func setIcon(_ appIcon: AppIcon, completion: ((Bool) -> Void)? = nil) {
        
        guard current != appIcon,
              UIApplication.shared.supportsAlternateIcons
        else { return }
        
        UIApplication.shared.setAlternateIconName(appIcon.name) { error in
            if let error = error {
                print("Error setting alternate icon \(appIcon.name ?? ""): \(error.localizedDescription)")
            }
            completion?(error != nil)
        }
    }

}
