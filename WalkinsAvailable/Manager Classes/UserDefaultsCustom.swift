//
//  UserDefaultsCustom.swift
//  CullintonsCustomer
//
//  Created by Rakesh Kumar on 04/04/18.
//  Copyright © 2018 Rakesh Kumar. All rights reserved.
//

import UIKit
//import FirebaseMessaging
//import FirebaseCore

struct UserDefaultsCustom {
    static let deviceToken = "deviceToken"
    static let accessToken = "auth_token"
    static let userModel = "model"
    static let userData = "data"
    static let businessData = "businessData"
    static let artistData = "artistData"
    static let logInRole = "logInRole"
    static let userToken = "userToken"
    static let eventFieldsModel = "EventFieldsModel"
    
    
//    static func getDeviceToken() -> String {
//        if let value = UserDefaults.standard.value(forKey: Self.deviceToken) as? String {
//            return value
//        } else {
//            return "auth_token"
//        }
//    }
    
    static var firstTimeOpen: Bool {
        return UserDefaults.standard.value(forKey: "firstTimeOpen") == nil
    }
    
    static func setValue(value: Any?, for key:String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
//        static func getToken() -> String {
//            //        let token = Messaging.messaging().fcmToken
//            //        print("FCM token: \(token ?? "")")
//            //        return token ?? deviceToken
//            if let value = UserDefaults.standard.value(forKey: UserDefaultsCustom.Token) {
//                return value as! String
//            } else {
//                return ""
//            }
//        }
    
//    static func getAccessToken() -> String {
//        if let value = UserDefaults.standard.value(forKey: UserDefaultsCustom.getUserData()?.auth_token ?? "") {
//            print("\(value)")
//            return value as! String
//        } else {
//            return ""
//        }
//    }
    
    static func getValue(forKey: String) -> String? {
        if let value = UserDefaults.standard.value(forKey: forKey) {
            return value as? String
        }
        return nil
    }
    
    static func setValue(value: Any?, forKey:String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
    }
    
    static func saveUserData(userData:UserData) {
        print("save user data")
        UserDefaults.standard.set(try? PropertyListEncoder().encode(userData), forKey: UserDefaultsCustom.userData)
    }
    
    static func saveUserModel(usermodel:UserModel) {
        print("save user data")
        UserDefaults.standard.set(try? PropertyListEncoder().encode(usermodel), forKey: UserDefaultsCustom.userModel)
    }
    
    static func saveLogInData(data: Data?) {
        if let response = DataDecoder.decodeData(data, type: UserModel.self) {
            saveUserModel(usermodel: response)
            
//            if let logInRole = response.loginRole {
//                saveLogInRole(logInRole: logInRole)
//            }
            if let userToken = response.userToken {
                saveUserToken(userToken: userToken)
            }
        }
    }
    
//    static func saveLogInRole(logInRole:String) {
//        print("save Log In Role")
//        UserDefaults.standard.set(logInRole, forKey: UserDefaultsCustom.logInRole)
//    }
    
    static func saveUserToken(userToken:String) {
        print("save user Token")
        UserDefaults.standard.set(userToken, forKey: UserDefaultsCustom.userToken)
    }
    
    static func getUserToken() -> String? {
        if let token = UserDefaults.standard.value(forKey: UserDefaultsCustom.userToken) as? String {
            return token
        } else {
            return nil
        }
    }
    
    static func saveDeviceToken(userToken:String) {
        print("save Device Token  \(userToken)")
        UserDefaults.standard.set(userToken, forKey: UserDefaultsCustom.deviceToken)
    }
    
    static func getDeviceToken() -> String {
        if let token = UserDefaults.standard.value(forKey: UserDefaultsCustom.deviceToken) as? String {
            return token
        }
        return String()
    }
    
    static func saveUserLogin(loginType value: String) {
        if let userId = UserDefaultsCustom.getUserData()?.userId {
            var dict: [String:Any] = [:]
            if let new = UserDefaults.standard.value(forKey: "loginRole") as? [String:Any] {
                dict = new
            }
            dict[userId] = value
            UserDefaults.standard.set(dict, forKey: "loginRole")
        }
    }
    
    static func getLoginRole(key: String) -> USER_TYPE {
        if let loginRole = UserDefaults.standard.value(forKey: "loginRole") as? [String:Any] {
            if let loginType = loginRole[key] as? String {
                return USER_TYPE(rawValue: loginType) ?? .user
            }
        }
        if let data = Self.getUserData()?.loginRole {
            return USER_TYPE(rawValue: data) ?? .user
        }
        return .user
    }

//    static func getLogInRole() -> USER_TYPE {
//        if let logIn = UserDefaults.standard.value(forKey: UserDefaultsCustom.logInRole) as? String {
//            return UserDefaultsCustom.getUserType(id: logIn) ?? .user
//        }
//        return .user
//    }
    
    static func getUserType(id: String) -> USER_TYPE? {
        switch id {
        case "1":
            return .user
        case "2":
            return .business
        case "3":
            return .serviceProvider
        default:
            break
        }
        return nil
    }
    
    
    
//    static func getUserData() -> UserData? {
//        if let data = UserDefaults.standard.value(forKey: UserDefaultsCustom.userData) as? Data {
//            let userData = try? PropertyListDecoder().decode(UserData.self, from: data)
//
//            return userData
//        }
//        return nil
//    }
    
    static func getUserData() -> UserData? {
        if let data = UserDefaults.standard.value(forKey: UserDefaultsCustom.userModel) as? Data {
            let userData = try? PropertyListDecoder().decode(UserModel.self, from: data)
           
            return userData?.userData
        }
        return nil
    }
    
    static func getBusinessData() -> BusinessData? {
        if let data = UserDefaults.standard.value(forKey: UserDefaultsCustom.userModel) as? Data {
            let businessData = try? PropertyListDecoder().decode(UserModel.self, from: data)
           
            return businessData?.businessData
        }
        return nil
    }
    
    static func getArtistData() -> ArtistData? {
        if let data = UserDefaults.standard.value(forKey: UserDefaultsCustom.userModel) as? Data {
            let artistData = try? PropertyListDecoder().decode(UserModel.self, from: data)
           
            return artistData?.artistData
        }
        return nil
    }
    
    static func getUserModel() -> UserModel? {
        if let data = UserDefaults.standard.value(forKey: UserDefaultsCustom.userModel) as? Data {
            let userModel = try? PropertyListDecoder().decode(UserModel.self, from: data)
           
            return userModel
        }
        return nil
    }
    
    
    
//    static func getUserId() -> String {
//        if let data = UserDefaults.standard.value(forKey:UserDefaultsCustom.userData) as? Data {
//            let userData = try? PropertyListDecoder().decode(UserData.self, from: data)
//            return userData?.userId ?? ""
//        }
//        return ""
//    }
    
}


extension UserDefaults {
    class func setValue(value:Any?, for key:String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    class func valueFor(key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
}
