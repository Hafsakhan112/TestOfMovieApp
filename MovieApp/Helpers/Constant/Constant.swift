//
//  Constant.swift

//
//  Created by Hafsa Khan
//  Copyright © 2019 Hafsa. All rights reserved.

import UIKit


struct Constant {
    static let isSSLEnabled = false
}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X_OR_XS    = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_XR_OR_XSMAX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

struct iOSVersion {
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (iOSVersion.SYS_VERSION_FLOAT < 8.0 && iOSVersion.SYS_VERSION_FLOAT >= 7.0)
    static let iOS8 = (iOSVersion.SYS_VERSION_FLOAT >= 8.0 && iOSVersion.SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (iOSVersion.SYS_VERSION_FLOAT >= 9.0 && iOSVersion.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (iOSVersion.SYS_VERSION_FLOAT >= 10.0 && iOSVersion.SYS_VERSION_FLOAT < 11.0)
    static let iOS11 = (iOSVersion.SYS_VERSION_FLOAT >= 11.0 && iOSVersion.SYS_VERSION_FLOAT < 12.0)
    static let iOS12 = (iOSVersion.SYS_VERSION_FLOAT >= 12.0 && iOSVersion.SYS_VERSION_FLOAT < 13.0)
    static let iOS13 = (iOSVersion.SYS_VERSION_FLOAT >= 13.0 && iOSVersion.SYS_VERSION_FLOAT < 14.0)
}

enum SocialLogin: String {
    case Facebook
    case Google
}

enum ImageType: String {
    case png
    case jpeg
}


/// Configuration
struct WebServicesConstant {
   // static let baseUrl = Bundle.value(.baseurl_qa) as? String ?? ""
  //  static let mediaUrl = Bundle.value(.mediaurl) as? String ?? ""
 //   static let imageUrl = Bundle.value(.imageurl) as? String ?? ""
    static let countries = "/GetAllCountries"
    static let getSearchFilters = "/GetSearchFilters"


}

/// All type of keys susceptible to security breach have to be defined under user-defined
struct SocialKeys {
    static let fireBase = "" //define in bunble
    static let azure = ""
    static let faceBook = ""
}


enum FirebaseSubscriptions: String {
    case push = "push_ios"
}

enum CertName: String {
    case sslNeomads = "SSLMovies"
}
