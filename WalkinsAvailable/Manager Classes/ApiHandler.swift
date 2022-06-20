//
//  ApiHandler.swift
//  CullintonsCustomer
//
//  Created by Rakesh Kumar on 03/04/18.
//  Copyright © 2018 Rakesh Kumar. All rights reserved.
//

import UIKit

class ApiHandler {

    static public func call(apiName:String, params: [String : Any]?, httpMethod:API.HttpMethod, receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.requestToServer(apiName, params: params!, httpMethod: httpMethod, isZipped: false, receivedResponse: { (isSucceeded, response, data) in
                DispatchQueue.main.async {
                    print("apiHandler responce:- \(response)")
                    print("params:-     \(params)")
                    if(isSucceeded) {
                        if let status = response["status"] as? Int {
                            switch (status) {
                            case 1:
                                receivedResponse(true, response, data)
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                if let message = response["message"] as? String {
                                    if message == "invalid access token" {
                                        Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                        Singleton.shared.logoutFromDevice()
                                        receivedResponse(false, [:], nil)
                                    } else {
                                        receivedResponse(false, ["statusCode": status, "message": message], nil)
                                    }
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                    Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                    Singleton.shared.logoutFromDevice()
                                    receivedResponse(false, [:], nil)
                                }
                            default:
                                if response["data"] != nil, let message = response["message"] as? String {
                                    receivedResponse(true, ["statusCode": 1, "message": message, "data": []], nil)
                                } else
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode": status, "message": message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            })
        } else {
            receivedResponse(false, ["statusCode": 0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
    }
    
    static public func uploadImage(apiName:String, dataArray:[PickerData]?,  imageKey:[String], params: [String : Any]?, isImage:Bool = true, receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.uploadingMultipleTask(apiName, params: params!, isImage: isImage, dataArray:dataArray,  imageKey: imageKey) { (isSucceeded, response, data) in
                DispatchQueue.main.async {
                    print(response)
                    if(isSucceeded){
                        if let status = response["status"] as? Int {
                            switch(status) {
                            case 1:
                                receivedResponse(true, response, data)
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.gotoSplash()
                                receivedResponse(false, [:], nil)
                            default:
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode":status, "message":message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode":status, "message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            }
        } else {
            receivedResponse(false, ["statusCode":0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
    }
    
    static public func updateProfile(apiName: String, params: [String:Any], profilePhoto: PickerData? = nil, receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        print("api name is *** \(apiName) **** \(params)")
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.uploadingMultipleTask(apiName, params: params, profilePhoto: profilePhoto) { (isSucceeded, response, data) in
               
                DispatchQueue.main.async {
                    print(response)
                    if(isSucceeded){
                        if let status = response["status"] as? Int {
                            switch(status) {
                            case 1:
                                receivedResponse(true, response, data)
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.gotoSplash()
                                receivedResponse(false, [:], nil)
                            default:
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode":status, "message":message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode":status, "message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            }
        } else {
            receivedResponse(false, ["statusCode":0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
        
    }
    
    static public func uploadDocument(apiName:String, dataArray:[Data]?, dataKey:String, params: [String : Any]?, receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            
            HttpManager.uploadingDocuments(apiName, params: params ?? [:], dataArray: dataArray, dataKey: dataKey) { (isSucceeded, response, data) in
                DispatchQueue.main.async {
                    print(response)
                    if(isSucceeded){
                        if let status = response["code"] as? Int {
                            switch(status) {
                            case API.statusCodes.SHOW_DATA:
                                receivedResponse(true, response, data)
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.gotoSplash()
                                receivedResponse(false, [:], nil)
                            default:
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode":status, "message":message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode":status, "message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            }
        } else {
            receivedResponse(false, ["statusCode":0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
        
    }
}



class DataDecoder: NSObject {
    
    class func decodeData<T>(_ data: Data?, type: T.Type) -> T? where T : Decodable {
        guard let data = data else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(type.self, from: data)
            print("decodedData:-\(decodedData) **** \(data.count)")
            return decodedData
        } catch {
            print("error***** \(error)")
            return nil
        }
    }
    
//    class func decodeData<T>(_ data: Data?, type: T.Type) -> T? where T : Decodable {
//        guard let data = data else {
//            return nil
//        }
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(type.self, from: data)
//            return decodedData
//        } catch {
//            return nil
//        }
//    }
    

}
