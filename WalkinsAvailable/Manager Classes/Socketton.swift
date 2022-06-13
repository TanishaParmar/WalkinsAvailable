//////
//////  SocketManager.swift
//////  CoWorkerUser
//////
//////  Created by Rakesh Kumar on 09/05/18.
//////  Copyright © 2018 SevenSkyLander. All rights reserved.
//////
//
//import UIKit
//import SocketIO
//
//enum SocketEvents {
//    case isTyping
//    case isStopTyping
//    case connection
//    case sendMessage
//    case isOffline
//    case isOnline
//    case sendGroupMessage
//    case confirmReadStatus
//
//    func name() -> String {
//        switch self {
//        case .isTyping:
//            return "isTyping"
//        case .connection:
//            return "connection"
//        case .sendMessage:
//            return "sendChatMessage"
//        case .sendGroupMessage:
//            return "sendChatMessage"
//        case .isStopTyping:
//            return "stopTyping"
//        case .isOnline:
//            return "isOnline"
//        case .isOffline:
//            return "isOffline"
//        case .confirmReadStatus:
//            return "confirmReadStatus"
//        }
//    }
//}
//
//enum SocketListeners {
//    case socketErr
//    case socketConnected
//    case sendMessage
//    case sendGroupMessage
//    case isTyping
//    case isTypingStop
//    case isSeen
//    case isOnline
//    case isOffline
//
//    func name() -> String {
//        switch self {
//        case .socketErr:
//            return "socketErr"
//        case .socketConnected:
//            return "socketConnected"
//        case .sendMessage:
//            return "sendMessage"
//        case .sendGroupMessage:
//            return "sendGroupMessage"
//        case .isTyping:
//            return "isTyping"
//        case .isTypingStop:
//            return "stopTyping"
//        case .isSeen:
//            return "isSeen"
//        case .isOnline:
//            return "isOnline"
//        case .isOffline:
//            return "isOffline"
//        }
//    }
//}
//
//class Socketton: NSObject {
//    static let sharedInstance = Socketton()
//    var manager: SocketManager?
//    var socket: SocketIOClient?
//    var chatId:String = ""
//    var userId:String? = UserDefaultsCustom.getUserData()?._id
//    var isConnected:Bool = false
//
//    var isOnlineCallback : (([String:Any]) -> Void)?
//    var isTypingCallback: (([String:Any]) -> Void)?
//    var isTypingStopCallback:(([String:Any]) -> Void)?
//    var isMessageReceivedCallback:(([String:Any]) -> Void)?
//    var isMessageSeenCallback:(([String:Any]) -> Void)?
//    var isGroupMessageReceived:(([String:Any]) -> Void)?
//    var isMessageRecieved:(([String:Any]) -> Void)?
//    var isOffline:(([String:Any]) -> Void)?
//
//    override init() {
//        super.init()
//    }
//
//    func setupSocket() {
//        guard socket == nil else {
//            return
//        }
//        let userId = UserDefaultsCustom.getUserData()?._id ?? "NULL"
//        print("socket user id == \(userId)")
//
//        manager = SocketManager(socketURL: URL(string: API.host + "")!, config: SocketIOClientConfiguration(arrayLiteral: SocketIOClientOption.connectParams(["userId": userId, "userType":"USER"])))
//
//        socket = manager?.defaultSocket
//    }
//
//    func establishConnection() {
//        if let socketConnectionStatus = self.socket?.status {
//            switch socketConnectionStatus {
//            case SocketIOStatus.connected:
//                print("socket connected")
//                self.isConnected = true
//            case SocketIOStatus.connecting:
//                print("socket connecting")
//            case SocketIOStatus.disconnected:
//                print("socket disconnected")
//                self.isConnected = false
//                self.setupConnection()
//            case SocketIOStatus.notConnected:
//                print("socket not connected")
//                self.isConnected = false
//                self.setupConnection()
//            }
//        } else {
//            self.setupConnection()
//        }
//    }
//
//    func setupConnection() {
//        self.setupSocket()
//        manager?.connect()
//        socket?.on(clientEvent: .connect) {data, ack in
//            print("socket connected")
//            self.isConnected = true
//            //            let userId = /UserSingleton.shared.loggedInUser?.data?._id
//            //            print(userId)
//            //            let options = "userId=\(userId)&userType=USER"
//            //            self.socket?.emit("connection", options)
//            //
//        }
//
//        self.socket?.on(SocketListeners.socketErr.name(), callback: {data, ack in
//            print("socket Error = ", data)
//        })
//
//        self.socket?.on(SocketListeners.socketConnected.name(), callback: {data, ack in
//            print("socket connected = ", data)
//        })
//
//        self.socket?.on("isOnline_\(chatId)", callback: {[weak self] data, ack in
//            print(data.jsonString)
//            if let data = data[0] as? [String:Any] {
//                if data.value(forKey: "sender") != self?.userId {
//                    self?.isOnlineCallback?(data)
//                }
//            }
//        })
//
//        self.socket?.on("isTyping_\(chatId)", callback: {[weak self] data, ack in
//            print(data.jsonString)
//            if let data = data[0] as? [String:Any] {
//                print("is typing recieve ****** \(data)")
//                if data.value(forKey: "sender") != self?.userId {
//                    self?.isTypingCallback?(data)
//                }
//            }
//        })
//
//        self.socket?.on("stopTyping_\(chatId)", callback: {[weak self] data, ack in
//            print(data.jsonString)
//            if let data = data[0] as? [String:Any] {
//                if data.value(forKey: "sender") != self?.userId {
//                    self?.isTypingStopCallback?(data)
//                }
//            }
//        })
//
//        self.socket?.on("isOffline_\(chatId)", callback: { data, ack in
//            print("Disconnected = ", data)
//            if let data = data[0] as? [String:Any] {
//                if data.value(forKey: "sender") != self.userId {
//                    self.isOffline?(data)
//                }
//            }
//        })
//
//        self.socket?.on("receiveChatMessage_\(chatId)_\(self.userId ?? "")", callback: {[weak self] data, ack in
//            if let data = data[0] as? [String:Any] {
//                print("is receiveChatMessage_ recieve ****** \(data)")
//                self?.isMessageRecieved?(data)
//            }
//        })
//
//        self.socket?.on("confirmReadStatus_\(chatId)", callback: {[weak self] data, ack in
//            if let data = data[0] as? [String:Any] {
//                print("confirmReadStatus_ ******** \(data)")
//                self?.isMessageSeenCallback?(data)
//            }
//        })
//    }
//
//
//    func isTypingEmit(json:[String:Any]) {
//        print("is typing json \(json)")
//        self.socket?.emit(SocketEvents.isTyping.name(), json)
//    }
//
//    func stopTypingEmit(json:[String:Any]) {
//        print("is stop typing json \(json)")
//        self.socket?.emit(SocketEvents.isStopTyping.name(), json)
//    }
//
//    func offlineEmit(json:[String:Any]) {
//        print("is offline json \(json)")
//        self.socket?.emit(SocketEvents.isOffline.name(), json)
//    }
//
//    func onlineEmit(json:[String:Any]) {
//        print("is online json \(json)")
//        self.socket?.emit(SocketEvents.isOnline.name(), json)
//    }
//
//    func seenEmit(json:[String:Any]) {
//        print("is seen json \(json)")
//        self.socket?.emit(SocketEvents.confirmReadStatus.name(), json)
//    }
//
//    func sendMessage(json:[String:Any]) {
//        if self.socket?.status.active == false {
//            self.establishConnection()
//        }
//        print("send message json  ************** \(json)")
//        self.socket?.emit(SocketEvents.sendMessage.name(), json)
//    }
//
//    //    func sendMessageEvent() {
//    //        sendMessage (Listeners for receiver - sendMessage) {
//    //            senderId : _id of Sender,
//    //            receiverId : _id of Receiver,
//    //            message : Message String,
//    //            sentAt : Date Time (UTC Date Time)
//    //        }
//    //    }
//
//    func closeConnection() {
//        socket?.disconnect()
//    }
//
//}
