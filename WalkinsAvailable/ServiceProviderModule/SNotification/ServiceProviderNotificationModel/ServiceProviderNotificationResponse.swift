//
//  ServiceProviderNotificationResponse.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/13/22.
//

import Foundation

struct ServiceProviderNotificationResponse : Codable {
    let code : Int?
    let status : Int?
    let message : String?
    let data : [ServiceProviderNotificationData]?
}

struct ServiceProviderNotificationData : Codable {
    let notificationId : String?
    let userId : String?
    let artistId : String?
    let businessId : String?
    let notificationType : String?
    let actionId : String?
    let title : String?
    let description : String?
    let seen : String?
    let created : String?
    let image : String?
}
