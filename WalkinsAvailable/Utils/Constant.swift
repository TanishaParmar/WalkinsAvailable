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
    static let enterServiceProviderName = "Please enter service provider name."
    static let enterBusinessName = "Please enter business name."
    static let enterBusinessType = "Please enter business type."
    static let enterAddress = "Please enter address."
    static let enterDescription = "Please enter description."
    static let enterUserName = "Please enter user name."
    static let chooseImage = "Please choose profile image."
    static let enterOldPassword = "Please enter old password."
    static let enterNewPassword = "Please enter new password."
    static let enterConfirmPassword = "Please enter confirm password."
    static let enterEventName = "Please enter event name."
    static let enterStartTime = "Please select start time."
    static let enterEndTime = "Please select end time."
    static let enterDate = "Please select date."
    static let chooseLocation = "Please choose location."
    static let deleteImage = "Are you sure you want to remove this image ?"
    static let deleteServiceProvider = "Are you sure you want to remove this Service Provider ?"
    static let deleteBusinessShop = "Are you sure you want to leave this job ?"

}

struct HEIGHT {
    static let errorMessageHeight: CGFloat = 43.0
    static let navigationHeight: CGFloat = 190 + getTopInsetofSafeArea + UIApplication.shared.statusBarFrame.height
    static let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
    
    
    static var getTopInsetofSafeArea: CGFloat {
        guard let topInset = Self.window?.safeAreaInsets.top else {return 0}
        if topInset > 0 {
            return topInset - 20
        }
        return topInset
    }
    
    static var getBottomInsetofSafeArea:CGFloat {
        let topInset = Self.window?.safeAreaInsets.bottom ?? 0
        return topInset
    }
}
