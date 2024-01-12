//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Hafsa Khan on 28/12/2023.
//

import UIKit

class SplashViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Simulate some delay (e.g., showing splash screen for a few seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            print("Inside asyncAfter closure")
            self?.setRootViewController()
        }
        print("Async code scheduled")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}

extension SplashViewController {
    
    // MARK:- Set Movie View as a Root view Controller
    func setRootViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let onboardingViewController: MovieNavigationViewController = storyboard.instantiateInitialViewController()  as? MovieNavigationViewController,
           let movieVC: MovieViewController = storyboard.instantiateInitialViewController() as? MovieViewController {
            onboardingViewController.pushViewController(movieVC, animated: true)
            UIApplication.rootViewController = onboardingViewController
        }
    }
    
}
