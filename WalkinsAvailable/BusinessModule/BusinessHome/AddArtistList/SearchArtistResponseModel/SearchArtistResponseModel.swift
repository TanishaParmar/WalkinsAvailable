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
