//
//  PushModel.swift
//  WalkinsAvailable
//
//  Created by MyMac on 6/13/22.
//

import Foundation

//MARK: PUSH MODEL
class PushModel: NSObject {
    var pushType: PUSH_TYPE?
    var title: String?
    var post_id: String?
    var user_id: String?
    var chat_id: String?
    var message: String?
    var message_id: String?
    var name: String?
    var notificationId: String?
    var silent: Bool?
    var last_seen: String?
    var status: String?
    var userId: String?
    var order_id: String?
    var device_id: String?
    var device_name: String?
    var location: String?
    
    var timezone: String?
    var file_name: String?
    var file_size: String?
    var message_type: String?
    var sent_date: String?
    var profile_pic: String?
    var local_id: String?
    
    var json: [String:Any]!
}

extension PushModel {
    
    convenience init(json: [String: Any]) {
        self.init()
        self.json = json
        if let pushType = json["pushType"] as? Int {
            self.pushType = PUSH_TYPE(rawValue: pushType)
            print("push type int \(pushType)")
        }
//        else if let pushType = (json["pushType"] as? String)?.toInt {
//            self.pushType = PUSH_TYPE(rawValue: pushType)
//            print("push type string \(pushType)")
//        }
    }
    
}

enum PUSH_TYPE: Int {
    case newMeetingInvitation    = 1  // tested
    case meetingReminder         = 2  // tested
    case meetingStatusChanged    = 3  // tested
    case pingParticipants        = 4  // tested
    case newTaskInvitation       = 5  // tested
    case newPollInvitation       = 6  // tested
    case newChatMessage          = 7  // tested
    case newEventInvitation      = 8  // tested
    case eventReminder           = 9  // tested
    case eventStatusChanged      = 10  // tested
    case commentFeed             = 11  // tested
    case likeFeed                = 12  // tested
    case followUser              = 13  // tested
    case unfollowUser            = 14  // tested
    case viewProfile             = 15  // tested
    case newFeed                 = 16  // tested
    case userStatusUpdated       = 17  // tested
    case groupCreated            = 18  // tested
    case birthdayMessage         = 19  // tested
    case newOrder                = 20  // tested
    case orderStatusChanged      = 21  // tested
    case contactGroupCreated     = 22  // tested
    case cancelOrder             = 23  // tested
//    case callEnded               = 24
    case webLogin                = 25  // tested
    case chatMessageDelete       = 26  // tested
    case someOneBlocedMe         = 27
    case callStarted             = 28
    case callEnded               = 29
    
    
}
