//
//  ChargerData.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//

import Foundation


// MARK: - Add Charger Data
class ChargerData: Codable {
    var __v: Int?
    var _id, type, publicName: String?
    var countryCode: String? = "+1"
    var phoneNo: String?
    var network, chargerName, amphere: String?
    var output: String?
    var address: String?
    var chargerLevel: String? = "Level 2"
    
    var chargerPhoneNumber: Int?
    var overNightCharger: Double?
    var specialInstruction: String?
    var plugs: String? = "1"
    var chargerPerkwh: String?
    var isDeleted: Bool?
    var createdAt: String?
    var status: String?
    var distance: Double?
    var favourite:Bool?
    
    var lat: Double?
    var lng: Double?
    
}
