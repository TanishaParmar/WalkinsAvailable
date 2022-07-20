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




// MARK: - UserModel
class UserModel: Codable {
    var code, status: Int?
    var loginRole: String?
    var userToken: String?
    var email: String?
    var message: String?
//    var message: String?
    var userData: UserData?
    var businessData: BusinessData?
    var artistData: ArtistData?
}


// MARK: - ArtistData
class ArtistData: Codable {
    var userId: String?
    var artistId: String?
    var businessId: String?
    var ownerName: String?
    var email: String?
    var artistDescription: String?
    var image: String?
    var available: String?
    var logInTime: String?
    var emailVerified: String?
    var created: String?
    var updatedAt: String?
    var isAvialable : String?
}

// MARK: - BusinessData
class BusinessData: Codable {
    var userId: String?
    var businessId: String?
    var artistId: String?
    var businessName: String?
    var email: String?
    var businessTypeId: String?
    var image: String?
    var businessAddress: String?
    var businessDescription: String?
    var latitude: String?
    var longitude: String?
    var logInTime: String?
    var emailVerified: String?
    var verificationCode: String?
    var created: String?
    var updatedAt: String?
    var disable: String?
    
    var name : String?
    var userToken : String?
    var typeId : String?
    var address : String?
    var description : String?
    
    var distance: String?
    var eventDetail : [String]?
    var isFav : String?
    var businessAvailability : String?
    var artistsList : [ArtistData]?
    
}


// MARK: - UserData
class UserData: Codable {
    var userId: String?
    var tokenId: String?
    var userToken: String?
    var latitude: String?
    var longitude: String?
    var deviceType: String?
    var deviceToken: String?
    var loginTime: String?
    var businessId: String?
    var artistId: String?
    var userName: String?
    var email: String?
    var password: String?
    var image: String?
    var googleToken: String?
    var facebookToken: String?
    var instaToken: String?
    var appleToken: String?
    var loginRole: String?
    var type: String?
    var emailVerified: String?
    var verificationCode: String?
    var created: String?
    var updatedAt: String?
    var isDisable: String?
}

