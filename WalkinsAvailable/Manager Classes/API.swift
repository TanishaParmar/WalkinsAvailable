//
//  API.swift
//  CullintonsCustomer
//
//  Created by Rakesh Kumar on 03/04/18.
//  Copyright © 2018 Rakesh Kumar. All rights reserved.
//

import UIKit


//const val TERMS_CONDITIONS ="http://161.97.132.85/CloutLyfe/TermsAndConditions.html"
//const val PRIVACY_POLICY ="http://161.97.132.85/CloutLyfe/Privacy-Policy.html"



class API {
    static let imageHost       = "https://dharmani.com/WalkIns/"
    static let host            = "https://dharmani.com/WalkIns/"
    static let deviceType      = "Ios"
    static let version         = "1.0"
    static let baseUrl:String  = "https://dharmani.com/WalkIns/"

    
    enum DataKey:String {
        case dataKey = "pic"
    }

    
    //MARK: LOGIN AND SOCIAL LOGIN CONSTANT API
    struct Name {
        // User Flow Api's
        static let login                               = "webservice/user/logIn.php"
        static let signUp                              = "webservice/user/userSignup.php"
        static let instagramLogIn                      = "webservice/user/instaLogin.php"
        static let forgetPassword                      = "webservice/user/forgetPassword.php"
        static let changePassword                      = "webservice/user/changePassword.php"
        static let contactUs                           = "webservice/user/contactUs.php"
        static let editProfile                         = "webservice/user/editProfile.php"
        static let categoriesList                      = "webservice/user/categoriesList.php"
        static let businessBySearch                    = "webservice/user/businessBySearch.php"
        static let googleLogIn                         = "webservice/user/googleLogin.php"
        static let appleLogIn                          = "webservice/user/appleLogin.php"
        static let facebookLogIn                       = "webservice/user/facebookLogin.php"
        static let favUnfavEvent                       = "webservice/user/favUnfavEvent.php"
        static let getAllNotificationByRole            = "webservice/user/getAllNotificationByRole.php"
        static let acceptRejectShopRequest             = "webservice/user/acceptRejectShopRequest.php"
        static let getNotificationBadgeCount           = "webservice/user/getNotificationBadgeCount.php"
        static let logOut                              = "webservice/user/logout.php"
        
        
        // Buisness Flow Api's
        static let businessGoogleLogIn                 = "webservice/business/googleLogin.php"
        static let businessAppleLogIn                  = "webservice/business/appleLogin.php"
        static let businessFacebookLogIn               = "webservice/business/facebookLogin.php"
        static let businessSignUp                      = "webservice/business/businessSignUp.php"
        static let editBusinessProfile                 = "webservice/business/editBusinessProfile.php"
        static let businessHomeDetail                  = "webservice/business/businessHomeDetail.php"
        static let ongoingPastMycreateEvent            = "webservice/business/ongoingPastMycreateEvent.php"
        static let addEvent                            = "webservice/business/addEvent.php"
        static let eventDetails                        = "webservice/business/eventDetails.php"
        static let addArtist                           = "webservice/business/addArtist.php"
        static let artistBySearch                      = "webservice/business/artistBySearch.php"
        static let viewArtistDetail                    = "webservice/business/viewArtistDetail.php"

        
        // Artist Flow Api's
        static let artistGoogleLogIn                   = "webservice/artist/googleLogin.php"
        static let artistAppleLogIn                    = "webservice/artist/appleLogin.php"
        static let artistFacebookLogIn                 = "webservice/artist/facebookLogin.php"
        static let artistSignUp                        = "webservice/artist/artistSignUp.php"
        static let artistHomeProfile                   = "webservice/artist/artistHomeProfile.php"
        static let editArtistProfile                   = "webservice/artist/editArtistProfile.php"
        static let addImage                            = "webservice/artist/addImage.php"
        static let removeArtistImages                  = "webservice/artist/removeArtistImages.php"
        static let businessSearch                      = "webservice/artist/businessSearch.php"
        static let businessRequest                     = "webservice/artist/businessRequest.php"
        static let associatedBusiness                  = "webservice/artist/associatedBusiness.php"

        
    }

    


    struct keys {
        static let access_token = "access_token"
        static let country_code = "country_code"
        static let phone_no     = "phone_no"
        static let otp          = "otp"
        static let device_type  = "device_type"
        static let device_token = "device_token"
    }
    
    enum HttpMethod: String {
        case POST   = "POST"
        case GET    = "GET"
        case PUT    = "PUT"
        case DELETE = "DELETE"
    }
    
    
    struct statusCodes {
        static let FAILURE     = 0
        static let SUCCESS     = 1
        static let INVALID_ACCESS_TOKEN     = 2
        static let BAD_REQUEST              = 400
        static let UNAUTHORIZED_ACCESS      = 401
        static let SHOW_MESSAGE             = 201
        static let SHOW_DATA                = 200
        static let SLOW_INTERNET_CONNECTION = 999
    }
    
}

struct AlertMessage {
    static let INVALID_ACCESS_TOKEN        = "Product is being used on another device"
    static let SERVER_NOT_RESPONDING       = "Something went wrong while connecting to server!"
    static let NO_INTERNET_CONNECTION      = "Unable to connect with the server. Check your internet connection and try again."
    
    static let pleaseEnter                 = "Please enter "
    static let invalidEmailId              = "Please enter valid email id."
    static let enterEmailId                = "Please enter email id."
    static let invalidPassword             = "Please enter correct password."
    static let invalidPhoneNumber          = "Please enter valid phone."
    static let invalidPasswordLength       = "Password must contain atleast 6 characters"
    static let logoutAlert                 = "Are you sure you want to logout?"
    static let imageWarning                = "The image we have showed above is for reference purpose. Actual car could be slightly different."
    static let emptyMessage                = " can not be empty."
    static let bookingCreated              = "Booking created successfully"
    static let passwordMismatch            = "New password and confirm password does not match."
    static let passwordChangedSuccessfully = "Password changed successfully."
    static let pleaseEnterValid            = "Please enter valid "
    static let transactionSuccessful       = "Your transaction was successful"
    static let PROFILE_SAVED               = "Profile has been saved successfully"
}

struct ERROR_MESSAGE {
    static let NO_CAMERA_SUPPORT           = "This device does not support camera"
    static let NO_GALLERY_SUPPORT          = "Photo library not found in this device."
    static let REJECTED_CAMERA_SUPPORT     = "Need permission to open camera"
    static let REJECTED_GALLERY_ACCESS     = "Need permission to open Gallery"
    static let SOMETHING_WRONG             = "Something went wrong. Please try again."
    static let NO_INTERNET_CONNECTION      = "Unable to connect with the server. Check your internet connection and try again."
    static let SERVER_NOT_RESPONDING       = "Something went wrong while connecting to server!"
    static let INVALID_ACCESS_TOKEN        = "Invalid Access Token"
    static let ALL_FIELDS_MANDATORY        = "All Fields Mandatory"
    static let CALLING_NOT_AVAILABLE       = "Calling facility not available on this device."
}
