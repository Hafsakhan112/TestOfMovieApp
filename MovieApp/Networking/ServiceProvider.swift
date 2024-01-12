//
//  ServiceProvider.swift

//
//  Created by Hafsa Khan 
//

import Foundation
import Moya
import Alamofire

struct ServiceProvider {
    
    private init() {}
    
    static func service<T: TargetType>(_ service: ServiceProviderMode = .default) -> MoyaProvider<T> {
        switch service {
        case .default:
            return MoyaProvider<T>(plugins: [Plugin.networkPlugin])
        case .background:
            return MoyaProvider<T>(plugins: [Plugin.networkPluginBackground])
        case .verbose:
            return MoyaProvider<T>(plugins: [Plugin.networkPlugin, Plugin.loggerPlugin])
        }
    }
}
