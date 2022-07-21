//
//  BusinessComplaintListModel.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/21/22.
//

import Foundation

struct BusinessComplaintListModel : Codable {
    let code : Int?
    let status : Int?
    let message : String?
    let data : [BusinessComplaintData]?
}

struct BusinessComplaintData : Codable {
    let complaintId : String?
    let userId : String?
    let businessId : String?
    let compDescription : String?
    let compNumber : String?
    let complaintReply : String?
    let status : String?
    let created : String?
    let updatedAt : String?
    let lastUpdate : String?
    let userDetails : UserDetails?
    let businessDetails : BusinessDetails?
}


struct UserDetails : Codable {
    let userId : String?
    let userName : String?
    let image : String?
}

struct BusinessDetails : Codable {
    let businessId : String?
    let businessName : String?
    let image : String?
}
