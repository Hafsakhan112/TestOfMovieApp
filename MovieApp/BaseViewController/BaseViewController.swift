//
//  BaseViewController.swift
//  ASMA
//
//  Created by Hafsa Khan on 17/09/2020.
//  Copyright © 2020 Hafsa Khan. All rights reserved.
//

import Foundation
import UIKit

#if DEV
import FLEX
#elseif STAGING
//import FLEX
#endif

class BaseViewController: UIViewController {
    let viewBGLoder: UIView = UIView()
    var loader: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        swipe.direction = .left
        swipe.delaysTouchesBegan = true
        self.view.addGestureRecognizer(swipe)
        
    }
    
    @objc func swipeGesture(_ recognizer: UISwipeGestureRecognizer?) {
        let touches = recognizer?.numberOfTouches
        switch touches {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        default:
            break
        }
    }
    
}

