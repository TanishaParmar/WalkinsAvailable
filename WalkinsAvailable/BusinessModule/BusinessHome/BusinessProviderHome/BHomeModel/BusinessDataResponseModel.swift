//
//  BusinessDataResponseModel.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/11/22.
//

import Foundation

// MARK: - BusinessDataResponseModel
class BusinessDataResponseModel: Codable {
    var code, status: Int?
    var message: String?
    var data: BusinessHomeData?
}

// MARK: - DataClass
class BusinessHomeData: Codable {
    var businessDetails : BusinessData?
    var artistsList : [ArtistData]?
    var inviteEventDetail : [InviteEventDetail]?
    var nearByEvent : [InviteEventDetail]?
}

// MARK: - InviteEventDetail
class InviteEventDetail : Codable {
    var inviteId : String?
    var eventId : String?
    var businessId : String?
    var artistId : String?
    var status : String?
    var created : String?
    var updatedAt : String?
    var eventDetail : EventDetail?
}
