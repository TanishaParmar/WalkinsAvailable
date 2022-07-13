//
//  SearchArtistResponseModel.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/11/22.
//

import Foundation


class SearchArtistResponse : Codable {
    var code : Int?
    var status : Int?
    var lastPage : Bool?
    var message : String?
    var data : [SearchArtistData]?
}

class SearchArtistData : Codable {
    var artistId : String?
    var userId : String?
    var businessId : String?
    var ownerName : String?
    var artistDescription : String?
    var image : String?
    var available : String?
    var logInTime : String?
    var created : String?
    var updatedAt : String?
    var isFav : String?
    var isJoin : String?
}



//MARK: Search for business shop response
class SearchBusinessResponse : Codable {
    var code : Int?
    var status : Int?
    var message : String?
    var data : [SearchBusinessData]?
}


class SearchBusinessData : Codable {
    var businessId : String?
    var userId : String?
    var artistId : String?
    var businessName : String?
    var businessTypeId : String?
    var image : String?
    var businessAddress : String?
    var businessDescription : String?
    var latitude : String?
    var longitude : String?
    var logInTime : String?
    var emailVerified : String?
    var verificationCode : String?
    var created : String?
    var updatedAt : String?
    var disable : String?
    var isJoin : String?
    var businessAvailability : String?
}
