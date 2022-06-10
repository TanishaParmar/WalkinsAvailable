//
//  Constant.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/4/22.
//

import Foundation
import UIKit

struct Color {
    static let appColor = #colorLiteral(red: 0.2052752674, green: 0.5205030441, blue: 0.3850464225, alpha: 1)
    static let pinkBorderColor = #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1)
    static let blackBorderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
}
enum AppAlertTitle : String {
    case appName = "WALK-INS AVAILABLE"
    case connectionError = "Connection Error"

}


struct AppAlertMessage {
    static let appName = "WALK-INS AVAILABLE"
    static let connectionError = "Connection Error"
    static let enterEmail = "Please enter email."
    static let validEmail = "Please enter vaild email."
    static let enterPassword = "Please enter password."
    static let enterArtistName = "Please enter artist name."
    static let enterBusinessName = "Please enter business name."
    static let enterBusinessType = "Please enter business type."
    static let enterAddress = "Please enter address."
    static let enterDescription = "Please enter description."
    static let enterUserName = "Please enter user name."
    static let ChooseStage = "Please choose stage."
    static let selectDate = "Please select date."
    static let enterNote = "Please enter note."
    static let actionType = "Please choose action type."
    static let enterDes = "Please enter description."
    static let noRepeat = "Please choose repeat method."
    static let forever = "Please select Forever or Until date"
    static let enterDate = "Please enter date."
    static let addedNutrient = "Already added this nutrient."

}

