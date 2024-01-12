//
//  UIApplicationExtension.swift
//  UAPC
//
//  Created by Hafsa
//  Copyright © 2018 Hafsa Khan. All rights reserved.

import Foundation
import UIKit


extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.connectedScenes
        .filter { $0.activationState == .foregroundActive }
        .compactMap { $0 as? UIWindowScene }
        .first?.windows
        .filter { $0.isKeyWindow }
        .first?.rootViewController) -> UIViewController? {
            
            if let nav = base as? UINavigationController {
                return getTopViewController(base: nav.visibleViewController)
            }
            if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            }
            if let presented = base?.presentedViewController {
                return getTopViewController(base: presented)
            }
            return base
        }
    
    static var rootViewController: UIViewController? {
        set {
            // Fetch the window scene's window and set the navigation controller as the root view controller
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = newValue
                window.makeKeyAndVisible()
            }
        } get {
            // Return the root view controller of the window
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                return window.rootViewController
            }
            return nil
            
        }
    }
    
    func universalOpenUrl(_ url: URL) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:],
                                      completionHandler: {
                (success) in
                print("Open \(url): \(success)")
            })
        } else {
            let success = openURL(url)
            print("Open \(url): \(success)")
        }
    }
}

extension UIApplication {
    static var topSafeAreaHeight: CGFloat {
        var topSafeAreaHeight: CGFloat = 0
        
        if #available(iOS 11.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                let safeFrame = windowScene.windows.first?.safeAreaLayoutGuide.layoutFrame
                topSafeAreaHeight = safeFrame?.minY ?? 0
            }
        }
        
        return topSafeAreaHeight
    }
    
    static var bottomSafeAreaHeight: CGFloat? {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            return windowScene.windows.first?.safeAreaInsets.bottom
        }
        return nil
    }
}
