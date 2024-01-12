//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Hafsa Khan on 27/12/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    static let shared = UIApplication.shared.delegate as? AppDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        setRoot()
       
        return true
    }
    
    //MARK:- Set Movie as a root view Controller
    func setRoot() {
        // Instantiate the Main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // Instantiate the MovieNavigationViewController using its storyboard ID
            if let onboardingViewController = storyboard.instantiateViewController(withIdentifier: "MovieNavigationViewController") as? MovieNavigationViewController {
                
                // Set the Movie as the rootViewController
                self.window?.rootViewController = onboardingViewController
                self.window?.makeKeyAndVisible()
            }
    }


}


