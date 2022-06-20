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



class UserModel: Codable {
    var code: Int?
    var status: Int?
    var message: String?
    var data: UserData?
}

class UserData: Codable{
    
    var userId, tokenId, userToken, latitude: String?
    var longitude, deviceType, deviceToken, loginTime: String?
    var businessId, artistId, name, email: String?
    var password, image, googleToken, facebookToken: String?
    var instaToken, appleToken, type, emailVerified: String?
    var verificationCode, created, updatedAt, isDisable: String?
    
    var businessAddress, businessTypeId, businessDescription: String? // 

//      enum CodingKeys: String, CodingKey {
//          case userID = "userId"
//          case tokenID = "tokenId"
//          case userToken, latitude, longitude, deviceType, deviceToken, loginTime
//          case businessID = "businessId"
//          case artistID = "artistId"
//          case userName, email, password, image, googleToken, facebookToken, instaToken, appleToken, type, emailVerified, verificationCode, created, updatedAt, isDisable
//      }

    
    
//    var userID, businessID, artistID, userName: String?
//    var email, password, image, googleToken: String?
//    var facebookToken, instaToken, appleToken, type: String?
//    var emailVerified, verificationCode, created, updatedAt: String?
//    var isDisable: String?
//
//    var auth_token:String?
//    var device_type:String?
//    var device_token:String?
//    var facebook_id:String?
//    var twitter_id:String?
//    var google_id:String?
//    var status:String?
}
