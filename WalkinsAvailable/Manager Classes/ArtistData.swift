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
    var data: ArtistHomeData?

}

class ArtistHomeData: Codable {
    var artistImages: [ArtistImage]?
    var artistDetails: UserData?
}

// MARK: - ArtistImage
class ArtistImage: Codable {
    var artistImageID, artistID: String?
    var image: String?
    var created, updatedAt, disable: String?
}

