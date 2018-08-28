//
//  ChatViewController.swift
//  
//
//  Created by aokijun on 2018/08/28.
//

import UIKit
import JSQMessagesViewController
import Firebase




class ChatViewController: UIViewController,UITextFieldDelegate {

    var messages: [JSQMessage]?
    
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    var incomingAvatar: JSQMessagesAvatarImage!
    var outgoingAvatar: JSQMessagesAvatarImage!
    
    
    
    @IBOutlet weak var inputToolbar: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupFirebase()
        setupChatUi()
        self.messages = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupFirebase() {
        //Firebaseの設定を記述（後述）
        let rootRef = Database.database().reference()
        rootRef.queryLimited(toLast: 100).observe(DataEventType.childAdded, with: { (snapshot) in
            let text = snapshot.value!["text"] as! String
            let sender = snapshot.value!["from"] as! String
            let name = snapshot.value!["name"] as! String
            let message = JSQMessage(senderId: sender, displayName: name, text: text)
            self.messages?.append(message)
            self.finishReceivingMessage()
        })
    }
    
    func setupChatUi() {
        inputToolbar!.contentView!.leftBarButtonItem = nil
        automaticallyScrollsToMostRecentMessage = true
        
        self.senderId = "user1"
        self.incomingAvatar = JSQMessagesAvatarImageFactory.
        avatarImageWithImage(UIImage(named: "icon_default")!, diameter: 64)
        self.outgoingAvatar = JSQMessagesAvatarImageFactory.
        avatarImageWithImage(UIImage(named: "icon_default")!, diameter: 64)
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        self.incomingBubble = bubbleFactory?.incomingMessagesBubbleImage(
            with: UIColor.jsq_messageBubbleLightGray())
        self.outgoingBubble = bubbleFactory?.outgoingMessagesBubbleImage(
            with: UIColor.jsq_messageBubbleGreen())
    }
    
    //メッセージの送信
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        self.finishSendingMessageAnimated(true)
        sendTextToDb(text)
    }
    
    func sendTextToDb(text: String) {
        //データベースへの送信（後述）
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return self.messages?[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = self.messages?[indexPath.item]
        if message?.senderId == self.senderId {
            return self.outgoingBubble
        }
        return self.incomingBubble
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = self.messages?[indexPath.item]
        if message?.senderId == self.senderId {
            return self.outgoingAvatar
        }
        return self.incomingAvatar
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.messages?.count)!
    }
    
    
    func sendTextToDb(text: String) {
        let rootRef = Database.database().reference()
        let post = ["from": senderId,
                    "name": senderDisplayName,
                    "text": text]
        let postRef = rootRef.childByAutoId()
        postRef.setValue(post)
    

}
    
}
