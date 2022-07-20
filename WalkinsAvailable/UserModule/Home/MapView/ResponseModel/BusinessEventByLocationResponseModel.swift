//
//  BusinessEventByLocationResponseModel.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/20/22.
//


import Foundation


class BusinessEventByLocationResponseModel : Codable {
	var code : Int?
	var status : Int?
	var message : String?
	var allBusinesses : [BusinessData]?
	var allEvents : [EventDetail]?
}

