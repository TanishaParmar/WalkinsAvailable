//
//  ArtistDetailsModel.swift
//  WalkinsAvailable
//
//  Created by apple on 08/07/22.
//


import Foundation
class ArtistDetailsModel : Codable {
    var code : Int?
    var status : Int?
    var message : String?
	var data : ArtistDetail?
}


class ArtistDetail : Codable {
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
    var artistImages : [ArtistImages]?
}


class ArtistImages : Codable {
    var artistImageId : String?
    var artistId : String?
    var image : String?
    var created : String?
    var updatedAt : String?
    var disable : String?
}
