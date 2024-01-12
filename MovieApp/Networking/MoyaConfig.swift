//
//  MoyaConfigurations.swift

//
//  Created by Hafsa Khan 
//

import Foundation
import Moya

enum APIResult<T> {
    case success(T)
    case failure(String)
}

enum ApiReturnStatus {
    case success
    case knownFailure
    case unknownFailure
    case deviceFailure
}

enum FailureCodes:Int {
    case internalServerError = 500
    case notFound = 404
    case invalidResponse = 403
    
    var value:Int {
        return self.rawValue
    }
}

enum ServiceProviderMode {
    case `default`, background, verbose
}
