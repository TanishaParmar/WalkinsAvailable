//
//  EventDetailModel.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/2/22.
//

import Foundation

class EventDetailModel : Codable {
    var code : Int?
    var status : Int?
    var message : String?
    var data : EventDetail?
}


class EventDetail : Codable {
    var eventId : String?
    var businessId : String?
    var eventName : String?
    var eventDate : String?
    var startTime : String?
    var endTime : String?
    var description : String?
    var eventLocation : String?
    var latitude : String?
    var longitude : String?
    var created : String?
    var updatedAt : String?
    var image : String?
    var isFav : String?
}

// MARK: - FavUnFavModel
class FavUnFavModel: Codable {
    var code, status: Int?
    var message: String?
    var isFav: String?
}
