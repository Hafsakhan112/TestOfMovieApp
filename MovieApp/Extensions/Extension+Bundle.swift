//
//  Extension+Bundle.swift

//
//  Created by Hafsa Khan 
//

import Foundation

extension Bundle {
    enum Key: String {
        case baseurl = "BASE_URL"
        case mediaurl = "MEDIA_URL"
        case imageurl = "IMG_URL"
        case baseurl_qa = "BASE_URL_QA"
    }
    class func value(_ key: Key) -> Any? {
        return Bundle.main.object(forInfoDictionaryKey: key.rawValue)
    }
    
    class func getStringFromBundle(_ fileName: String,
                                   _ ext: String) -> String? {
        if let filepath = Bundle.main.path(forResource: fileName, ofType: ext) {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    class func getCertificate(_ certName: CertName) -> [SecCertificate]? {
        let url = Bundle.main.url(forResource: certName.rawValue,
                                  withExtension: "pem")!
        let localCertificate = try! Data(contentsOf: url) as CFData
        guard let certificate = SecCertificateCreateWithData(nil, localCertificate)
            else {
                return nil
        }
        return [certificate]
    }
}
