//
//  SignUpAsUserModel.swift
//  WalkinsAvailable
//
//  Created by MyMac on 6/13/22.
//

import Foundation

// MARK: - SignUpResponseModel
struct SignUpResponseModel: Codable {
    var code, status: Int?
    var message: String?
    var data: DataClass?
}


// MARK: - DataClass
struct DataClass: Codable {
    var userID, businessID, artistID, userName: String?
    var email, password, image, googleToken: String?
    var facebookToken, instaToken, appleToken, type: String?
    var emailVerified, verificationCode, created, updatedAt: String?
    var isDisable: String?
}
