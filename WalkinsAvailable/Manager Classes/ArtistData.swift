//
//  ArtistData.swift
//  WalkinsAvailable
//
//  Created by MyMac on 6/21/22.
//

import Foundation

// MARK: - ArtistDataResponseModel
class ArtistDataResponseModel: Codable {
    var code, status: Int?
    var message: String?
    var data: ArtistData?

}

class ArtistData: Codable {
    var artistImages: [ArtistImage]?
    var artistDetails: UserData?
}

// MARK: - ArtistImage
class ArtistImage: Codable {
    var artistImageID, artistID: String?
    var image: String?
    var created, updatedAt, disable: String?
}


// MARK: - BusinessDataResponseModel
class BusinessDataResponseModel: Codable {
    var code, status: Int?
    var message: String?
    var data: BusinessData?

}
// MARK: - DataClass
class BusinessData: Codable {
    var businessDetails: UserData?
//    var artistsList: [ArtistsList]?
    var inviteEventDetail: [InviteEventDetail]?
    var nearByEvent: [NearByEvent]?
}



// MARK: - InviteEventDetail
class InviteEventDetail: Codable {
    var eventDetail: NearByEvent?
}


// MARK: - NearByEvent
class NearByEvent: Codable {
//    var eventID, businessID: String?
//    var eventName: EventName?
//    var eventDate: String?
//    var startTime: StartTime?
//    var endTime: EndTime?
//    var nearByEventDescription: Description?
//    var eventLocation: EventLocation?
//    var latitude, longitude, created, updatedAt: String?
//    var eventImage: String?
//    var distance: String?

}



// MARK: -  UserDataResponseModel.swift


// MARK: - UserDataResponseModel
class UserDataResponseModel: Codable {
    var code, status: Int?
    var message: String?
    var data: DataUser?
}


// MARK: - DataClass
class DataUser: Codable {
    var businessDetails: [BusinessDetails]?
    var userDetails: UserData?

}


// MARK: - BusinessDetail
class BusinessDetails: Codable {
    var businessID, userID, artistID, businessName: String?
    var businessTypeID: String?
    var image: String?
    var businessAddress, businessDescription, latitude, longitude: String?
    var logInTime, emailVerified, verificationCode, created: String?
    var updatedAt, disable, distance: String?
//    var eventDetail: [JSONAny]?
//    var isFav: String?
//    var businessAvailability: JSONNull?
//    var artistsList: [ArtistsList]?
}


// MARK: - ArtistsList
//class ArtistsList: Codable {
//    var artistID, userID, businessID, ownerName: String?
//    var businessTypeID, artistDescription: String?
//    var image: String?
//    var available, userToken, logInTime, created: String?
//    var updatedAt: String?
//    var artistAvailability: JSONNull?
//}

