//
//  EventListModel.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/1/22.
//

import Foundation


class EventListModel : Codable {
    var code : Int?
    var status : Int?
    var message : String?
    var data : [EventsList]?
}


class EventsList : Codable {
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
