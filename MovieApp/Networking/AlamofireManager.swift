//
//  AlamofireManager.swift

//
//  Created by Hafsa Khan 
//̊

import Alamofire
import Moya

class AlamofireManager {
    
    static let sharedManager: Session = {
        let headers = HTTPHeaders.default
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers.dictionary
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        // MARK:- SSL Pinning Support
        if Constant.isSSLEnabled, let certificates = Bundle.getCertificate(.sslNeomads) {
            let serverTrustPolicies: [String: ServerTrustEvaluating] = [
                "********": PinnedCertificatesTrustEvaluator(certificates: certificates)
            ]
            
            return Session(configuration: configuration, serverTrustManager: ServerTrustManager(evaluators: serverTrustPolicies))
        } else {
           return Session(configuration: configuration)
        }
    }()
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
}

