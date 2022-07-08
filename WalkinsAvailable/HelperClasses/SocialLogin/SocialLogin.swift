//
//  SocialLoginVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 6/24/22.
//

import Foundation
import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FacebookLogin
import AuthenticationServices







class SocialLoginVC: UIViewController {
    
    var type: USER_TYPE = .user
    let current = LocationManager.shared.currentLocation?.coordinate
    
    func observeSuccessGoogleLogin() {
    }
    func observeSuccessAppleLogin() {
    }
    func observeSuccessFacebookLogin() {
    }
    
    
    
    @IBAction func googleLogin(_ sender: UIButton) {
        GoogleManager.shared.googleSignIn(controller: self) { userId, fullName, email, idToken, profilePicture in
            
            self.generatingGoogleLogInParameters(userId: userId, fullName: fullName, email: email, idToken: idToken, profilePicture: profilePicture)
        } failure: { error in
            print(error)
        }
    }
    
    @IBAction func facebookLogin(_ sender: UIButton) {
        facebookLogIN()
    }
    
    @IBAction func appleLogIn(_ sender: UIButton) {
        actionAppleSignin()
    }
    
    func actionAppleSignin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
    func facebookLogIN() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self, handler: { result, error in
            if error != nil {
                print("ERROR: Trying to get login results")
            } else if result?.isCancelled != nil {
                print("The token is \(result?.token?.tokenString ?? "")")
                if result?.token?.tokenString != nil {
                    print("Logged in")
                    self.getUserProfile(token: result?.token, userId: result?.token?.userID)
                } else {
                    print("Cancelled")
                }
            }
        })
    }
    
    func getUserProfile(token: AccessToken?, userId: String?) {
        let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, middle_name, last_name, name, picture, email"])
        graphRequest.start { _, result, error in
            if error == nil {
                let data: [String: AnyObject] = result as! [String: AnyObject]
                // Facebook Id
                let facebookId = data["id"] as? String ?? ""
                let facebookName = data["name"] as? String ?? ""
                let facebookProfilePicURL = "https://graph.facebook.com/\(userId ?? "")/picture?type=large"
                let facebookEmail = data["email"] as? String ?? ""
                self.hitFacebookLogInApi(with: facebookEmail, userName: facebookName, facebookToken: facebookId, facebookImage: facebookProfilePicURL)
            } else {
                print("Error: Trying to get user's info")
            }
        }
    }
    
//    func generatingGoogleLogInParameters(userId: String?, fullName: String?, email: String?, idToken: String?, profilePicture: URL?) {
//        var params : [String:Any] = [:]
//        switch self.type {
//        case .user:
//            params = ["userName":fullName ?? "","email":email ?? "","image": profilePicture?.absoluteString ?? "" ,"googleToken":userId ?? "","latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
//        case .business:
//            params = ["businessName":fullName ?? "","email":email ?? "","image": profilePicture?.absoluteString ?? "" ,"googleToken":userId ?? "","deviceType":"1"] as [String:Any]
//        case .serviceProvider:
//            params = ["artistName":fullName ?? "","email":email ?? "","image": profilePicture?.absoluteString ?? "" ,"googleToken":userId ?? "","latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
//        }
//        print("params ****** \(params)")
//        self.hitGoogleLogInApi(dict: params)
//    }
    
    
    func generatingGoogleLogInParameters(userId: String?, fullName: String?, email: String?, idToken: String?, profilePicture: URL?) {
        
        var params : [String:Any] = [:]
        params["userName"] = fullName ?? ""
        params["email"] = email ?? ""
        params["image"] = profilePicture?.absoluteString ?? ""
        params["googleToken"] = userId ?? ""
        params["latitude"] = current?.latitude // "30.7110585"
        params["longitude"] = current?.longitude //"76.6913124"
        params["deviceType"] = "1"
        params["deviceToken"] = UserDefaultsCustom.getDeviceToken()

        switch self.type {
        case .user:
            params["role"] = "1"
        case .business:
            params["role"] = "2"
        case .serviceProvider:
            params["role"] = "3"
        }
        
        print("params ****** \(params)")
        self.hitGoogleLogInApi(dict: params)
    }

    
    
    //MARK: Hit Google Log In API
    func hitGoogleLogInApi(dict: [String:Any]) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        var apiName: String = API.Name.googleLogIn
//        switch type {
//        case .user:
//            apiName = API.Name.googleLogIn
//        case .business:
//            apiName = API.Name.businessGoogleLogIn
//        case .serviceProvider:
//            apiName = API.Name.artistGoogleLogIn
//        }
        ApiHandler.updateProfile(apiName: apiName, params: dict) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                UserDefaultsCustom.saveLogInData(data: data)
                UserDefaultsCustom.saveUserLogin(loginType: self.type.role)
                
                switch self.type {
                case .business:
                    if let data = UserDefaultsCustom.getBusinessData() {
                        if data.businessTypeId == "0" {
//                            self.setHomeView(window: Singleton.window)
                            Singleton.setBusinessEditScreenView()
                        } else {
                            Singleton.setHomeScreenView()
                        }
                    } else {
                        
                    }
                case .user:
                    if let userData = UserDefaultsCustom.getUserData() {
                        if (userData.email == "" || userData.email == nil) || (userData.userName == "" || userData.userName == nil) {
                            Singleton.setUserEditScreenView()
                        } else {
                            Singleton.setHomeScreenView()
                        }
                    }
                case .serviceProvider, .user:
                    if let artistData = UserDefaultsCustom.getArtistData() {
                        if artistData.email == "" || artistData.email == nil {
                            Singleton.setArtistEditScreenView()
                        } else {
                            Singleton.setHomeScreenView()
                        }
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
//    func setHomeView(window: UIWindow? = Singleton.window) {
//        let homeVC = BusinessEditProfile()
////        Singleton.homeTabController = homeVC
//        window?.rootViewController = homeVC
//        window?.makeKeyAndVisible()
//        Singleton.window = window
//    }
    
    
    
    
    //MARK: Hit Apple Log In API
    func hitAppleLogInApi(with email: String, userName: String,appleToken: String, appleImage: String) {
        var params: [String:Any] = [:]
        var apiName: String = API.Name.appleLogIn
        
//        switch type {
//        case .user:
//            apiName = API.Name.appleLogIn
//            params = ["userName":userName,"email":email,"image":appleImage,"appleToken":appleToken,"latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
//            debugPrint("params ****** \(params)")
//        case .business:
//            apiName = API.Name.businessAppleLogIn
//            params = ["businessName":userName,"email":email,"image":appleImage,"businessType":"","businessAddress":"","businessDescription":"","appleToken":appleToken,"latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
//            debugPrint("params ****** \(params)")
//        case .serviceProvider:
//            apiName = API.Name.artistAppleLogIn
//            params = ["artistName":userName,"email":email,"image":appleImage,"appleToken":appleToken,"latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
//            debugPrint("params ****** \(params)")
//        }
        
        params["userName"] = userName
        params["email"] = email
        params["image"] = appleImage
        params["appleToken"] = appleToken
        params["latitude"] = current?.latitude// "30.7110585"
        params["longitude"] = current?.longitude // "76.6913124"
        params["deviceType"] = "1"
        params["deviceToken"] = UserDefaultsCustom.getDeviceToken()

        switch self.type {
        case .user:
            params["role"] = "1"
        case .business:
            params["role"] = "2"
        case .serviceProvider:
            params["role"] = "3"
        }
        print(params)
        
        ApiHandler.updateProfile(apiName: apiName, params: params) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                UserDefaultsCustom.saveLogInData(data: data)
                UserDefaultsCustom.saveUserLogin(loginType: self.type.role)

                switch self.type {
                case .business:
                    if let data = UserDefaultsCustom.getBusinessData() {
                        if data.businessTypeId == "0" {
//                            self.setHomeView(window: Singleton.window)
                            Singleton.setBusinessEditScreenView()
                        } else {
                            Singleton.setHomeScreenView()
                        }
                    }
                case .user:
                    if let userData = UserDefaultsCustom.getUserData() {
                        if userData.email == "" || userData.email == nil {
                            Singleton.setUserEditScreenView()
                        } else {
                            Singleton.setHomeScreenView()
                        }
                    }
                case .serviceProvider:
                    if let artistData = UserDefaultsCustom.getArtistData() {
                        if artistData.email == "" || artistData.email == nil {
                            Singleton.setArtistEditScreenView()
                        } else {
                            Singleton.setHomeScreenView()
                        }
                    }
                }
                
//                switch self.type {
//                case .business:
//                    if let data = UserDefaultsCustom.getBusinessData() {
//                        if data.businessTypeId == "0" {
////                            self.setHomeView(window: Singleton.window)
//                            Singleton.setBusinessEditScreenView()
//                        } else {
//                            UserDefaultsCustom.saveUserLogin(loginType: self.type.role)
//                            Singleton.setHomeScreenView()
//                        }
//                    } else {
//
//                    }
//                case .user, .serviceProvider:
//                    UserDefaultsCustom.saveUserLogin(loginType: self.type.role)
//                    Singleton.setHomeScreenView()
//                }
                
//                UserDefaultsCustom.saveUserLogin(loginType: self.type.role)
//                Singleton.setHomeScreenView()
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    //MARK: Hit Facebook Log In API
    func hitFacebookLogInApi(with email: String, userName: String,facebookToken: String, facebookImage: String) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        var params: [String:Any] = [:]
        var apiName: String = API.Name.facebookLogIn
        
//        switch type {
//        case .user:
//            apiName = API.Name.facebookLogIn
//            params = ["userName":userName,"email":email,"image":facebookImage,"facebookToken":facebookToken,"latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
//            debugPrint("params ****** \(params)")
//        case .business:
//            apiName = API.Name.businessFacebookLogIn
//            params = ["businessName":userName,"email":email,"image":facebookImage,"facebookToken":facebookToken,"businessType":"","businessAddress":"","businessDescription":"","latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
//            debugPrint("params ****** \(params)")
//        case .serviceProvider:
//            apiName = API.Name.artistFacebookLogIn
//            params = ["artistName":userName,"email":email,"image":facebookImage,"facebookToken":facebookToken,"latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
//            debugPrint("params ****** \(params)")
//        }
        
        params["userName"] = userName
        params["email"] = email
        params["image"] = facebookImage
        params["facebookToken"] = facebookToken
        params["latitude"] = current?.latitude // "30.7110585"
        params["longitude"] = current?.longitude // "76.6913124"
        params["deviceType"] = "1"
        params["deviceToken"] = UserDefaultsCustom.getDeviceToken()

        switch self.type {
        case .user:
            params["role"] = "1"
        case .business:
            params["role"] = "2"
        case .serviceProvider:
            params["role"] = "3"
        }


        
        
        ApiHandler.updateProfile(apiName: apiName, params: params) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                UserDefaultsCustom.saveLogInData(data: data)
                UserDefaultsCustom.saveUserLogin(loginType: self.type.role)
                switch self.type {
                case .business:
                    if let data = UserDefaultsCustom.getBusinessData() {
                        if data.businessTypeId == "0" {
//                            self.setHomeView(window: Singleton.window)
                            Singleton.setBusinessEditScreenView()
                        } else {
                            Singleton.setHomeScreenView()
                        }
                    } else {
                        
                    }
                case .user:
                    if let userData = UserDefaultsCustom.getUserData() {
                        if userData.email == "" || userData.email == nil {
                            Singleton.setUserEditScreenView()
                        } else {
                            Singleton.setHomeScreenView()
                        }
                    }
                case .serviceProvider, .user:
                    if let artistData = UserDefaultsCustom.getArtistData() {
                        if artistData.email == "" || artistData.email == nil {
                            Singleton.setArtistEditScreenView()
                        } else {
                            Singleton.setHomeScreenView()
                        }
                    }
                }
                
//                switch self.type {
//                case .business:
//                    if let data = UserDefaultsCustom.getBusinessData() {
//                        if data.businessTypeId == "0" {
////                            self.setHomeView(window: Singleton.window)
//                            Singleton.setBusinessEditScreenView()
//                        } else {
//                            UserDefaultsCustom.saveUserLogin(loginType: self.type.role)
//                            Singleton.setHomeScreenView()
//                        }
//                    } else {
//
//                    }
//                case .user, .serviceProvider:
//                    UserDefaultsCustom.saveUserLogin(loginType: self.type.role)
//                    Singleton.setHomeScreenView()
//                }
//                UserDefaultsCustom.saveUserLogin(loginType: self.type.role)
//                Singleton.setHomeScreenView()
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
}


//MARK: apple login delegates
extension SocialLoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let appleId = appleIDCredential.user ?? ""
            let appleUserFirstName = appleIDCredential.fullName?.givenName ?? ""
            let appleUserLastName = appleIDCredential.fullName?.familyName ?? ""
            let appleUserEmail = appleIDCredential.email ?? ""
            let userName = "\(appleUserFirstName) \(appleUserLastName)"
            //Write your code
            ActivityIndicator.sharedInstance.showActivityIndicator()
            hitAppleLogInApi(with: appleUserEmail, userName: userName, appleToken: appleId, appleImage: "")
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            print("password credentials are =>", passwordCredential)
        }
    }
}

extension SocialLoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
    
    
    
    
    
    
    
    
    
    
/*
    // MARK: VAILDATIONS
    func validate() {
        if ValidationManager.shared.isEmpty(text: emailTextField.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEmail, isError: .error)
        }else if emailTextField.text!.isValidEmail == false {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.validEmail, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: passwordTextField.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterPassword, isError: .error)
        }else {
            hitLogInApi()
            //            Singleton.setHomeScreenView()
        }
    }
    
    //MARK: Actions
    @IBAction func logInButtonAction(_ sender: Any) {
                validate()
//        Singleton.setHomeScreenView()
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        let viewcontroller = ForgotPasswordVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let viewcontroller = SignUpAsVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    
    @IBAction func appleLoginButtonAction(_ sender: Any) {
        actionAppleSignin()
    }
    
    @IBAction func emailLogInButtonAction(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func facebookLogInButtonAction(_ sender: Any) {
        facebookLogIN()
    }
    
    @IBAction func instaLogInButtonAction(_ sender: Any) {
        
    }
    
*/
