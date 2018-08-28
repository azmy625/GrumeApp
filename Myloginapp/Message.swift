//
//  Message.swift
//  Myloginapp
//
//  Created by aokijun on 2018/08/28.
//  Copyright © 2018年 aokijun. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class Message : NSObject, JSQMessageData {
    func senderId() -> String! {
        <#code#>
    }
    
    func senderDisplayName() -> String! {
        <#code#>
    }
    
    func isMediaMessage() -> Bool {
        <#code#>
    }
    
    func messageHash() -> UInt {
        <#code#>
    }
    
    var text_: String
    var sender_: String
    var date_: NSDate
    var imageUrl_: String?
    
    convenience init(text: String?, sender: String?) {
        self.init(text: text, sender: sender, imageUrl: nil)
    }
    
    init(text: String?, sender: String?, imageUrl: String?) {
        self.text_ = text!
        self.sender_ = sender!
        self.date_ = NSDate()
        self.imageUrl_ = imageUrl
    }
    
    func text() -> String! {
        return text_;
    }
    
    func sender() -> String! {
        return sender_;
    }
    
    func date() -> Date! {
        return date_ as Date!;
    }
    
    func imageUrl() -> String? {
        return imageUrl_;
    }
}
