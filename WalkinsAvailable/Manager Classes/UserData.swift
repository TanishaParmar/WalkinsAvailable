//
//  UserData.swift
//  NiftyExpert
//
//  Created by MAC on 17/04/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit


class ImageEntity: Codable {
    var statusCode: Int?
    var message: String?
    var data: ResponseData?
}

class ResponseData: Codable {
//    var original:String?
//    var thumbnail:String?
//    var type:String?
    var s3Url: String?
    
}

class ImageModel: NSObject {
//    
//    class func uploadDocument(data:Data, key: API.DataKey, complitionHandler: @escaping(_ image: ResponseData) -> ()) {
//        
//        let params:JSON? = ["access_token": UserDefaultsCustom.getAccessToken()]
//        
//        ActivityIndicator.sharedInstance.showActivityIndicator()
//        ApiHandler.uploadDocument(apiName: API.Name.fileUpload, dataArray: [data], dataKey: key.rawValue, params: params) { (isSucceeded, response, data) in
//            DispatchQueue.main.async {
//                print("responose is ****** \(response)")
//                ActivityIndicator.sharedInstance.hideActivityIndicator()
//                if isSucceeded == true {
//                    guard let data = data else { return }
//                    do {
//                        let decoder = JSONDecoder()
//                        let jsonResponse = try decoder.decode(ImageEntity.self, from: data)
//                        guard let data = jsonResponse.data else {return}
//                        complitionHandler(data)
//                    } catch let err {
//                        print(err)
//                    }
//                } else {
//                    if let message = response["message"] as? String {
//                        Singleton.sharedInstance.showErrorMessage(error: message, isError: .error)
//                    }
//                }
//            }
//        }
//    }
    
}



//class UserModel: Codable {
//    var code: Int?
//    var status: Int?
//    var message: String?
//    var data: UserData?
//}
//
//class UserData: Codable {
//
//    var userId, tokenId, userToken, latitude: String?
//    var longitude, deviceType, deviceToken, loginTime: String?
//    var businessId, artistId, name, email: String?
//    var password, image, googleToken, facebookToken: String?
//    var instaToken, appleToken, type, emailVerified: String?
//    var verificationCode, created, updatedAt, isDisable: String?
//    var address, typeId, description, loginRole : String?
//}






// MARK: - UserModel
class UserModel: Codable {
    var code, status: Int?
    var loginRole, userToken, email, message: String?
//    var message: String?
    var userData: UserData?
    var businessData: BusinessData?
    var artistData: ArtistData?
}


// MARK: - ArtistData
class ArtistData: Codable {
    var userId, artistId, businessId, ownerName, email: String?
    var artistDescription: String?
    var image: String?
    var available, logInTime, emailVerified, created, updatedAt: String?
}

// MARK: - BusinessData
class BusinessData: Codable {
    var userId, businessId, artistId, businessName, email: String?
    var businessTypeId: String?
    var image: String?
    var businessAddress, businessDescription, latitude, longitude: String?
    var logInTime, emailVerified, verificationCode, created: String?
    var updatedAt, disable: String?
}


// MARK: - UserData
class UserData: Codable {
    var userId, tokenId, userToken, latitude: String?
    var longitude, deviceType, deviceToken, loginTime: String?
    var businessId, artistId, userName, email: String?
    var password: String?
    var image: String?
    var googleToken, facebookToken, instaToken, appleToken: String?
    var loginRole, type, emailVerified, verificationCode: String?
    var created, updatedAt, isDisable: String?
}

