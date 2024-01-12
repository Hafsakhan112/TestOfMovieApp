//
//  MoyaPlugins.swift

//
//  Created by Hafsa Khan
//

import Foundation
import Moya
import Kingfisher

struct Plugin {
    private init() {}
    static var activityInd: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        // Set up further configurations if necessary
        return indicator
    }()
    
    static let networkPlugin = NetworkActivityPlugin(networkActivityClosure: { (changeType, target) in
        switch changeType {
        case .began:
            DispatchQueue.main.async {
                // Indicator.sharedInstance().show()
                activityInd.startAnimating()
            }
            print("🟡🟡🟡🟡🟡 \(target.method) ---> \(target.path) ---> \(target.task)  -->> Network Call Started... Data & Time -->> ⌛️⌛️\(Date()) <<--")
        case .ended:
            DispatchQueue.main.async {
                //Indicator.shared.hide()
                activityInd.stopAnimating()
            }
            print("🟢🟢🟢🟢🟢 \(target.method) ---> \(target.path) ---> \(target.task) -->> Network Call Ended... Data & Time -->> ⌛️⌛️\(Date()) <<--")
        }
    })
    
    static let loggerPlugin = NetworkLoggerPlugin()
    
    static let networkPluginBackground = NetworkActivityPlugin(networkActivityClosure: { (changeType, target) in
        switch changeType {
        case .began:
            print("🟡🟡🟡🟡🟡 \(target.method) ---> \(target.path) ---> \(target.task)  -->> Network Call Started... Data & Time -->> ⌛️⌛️\(Date()) <<--")
        case .ended:
            print("🟢🟢🟢🟢🟢 \(target.method) ---> \(target.path) ---> \(target.task) -->> Network Call Ended... Data & Time -->> ⌛️⌛️\(Date()) <<--")
        }
    })
}
