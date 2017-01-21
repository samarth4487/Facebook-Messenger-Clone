//
//  ChatLogController.swift
//  Demo Messenger
//
//  Created by Samarth Paboowal on 15/01/17.
//  Copyright © 2017 Junkie Labs. All rights reserved.
//

import UIKit
import CoreData

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var friend: Friend? {
        didSet{
            
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            
            messages = messages?.sorted(by: {$0.date!.compare($1.date as! Date) == .orderedAscending})
        }
    }
    
    var messages: [Message]?
    let cellID = "cellID"
    
    let containerView = UIView()
    let topBorderView = UIView()
    let inputTextView = UITextField()
    let sendButton = UIButton(type: .system)
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatLogCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
        collectionView?.alwaysBounceVertical = true
        tabBarController?.tabBar.isHidden = true
        
        setupViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotificationShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotificationHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardNotificationShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect
    
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { 
                
                (self.bottomConstraint?.constant = -(keyboardFrame?.height)!)!
                self.view.layoutIfNeeded()
                
            }, completion: { (completed) in
                
                let indexPath = NSIndexPath(item: (self.messages?.count)! - 1, section: 0)
                self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
            })
        }
    }
    
    func keyboardNotificationHide(notification: NSNotification) {
        
        UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.bottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: { (completed) in
            
            
        })
    }
    
    func setupViews() {
        
        view.addSubview(containerView)
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint?.isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        containerView.addSubview(topBorderView)
        topBorderView.translatesAutoresizingMaskIntoConstraints = false
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        topBorderView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topBorderView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        topBorderView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topBorderView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        containerView.addSubview(inputTextView)
        inputTextView.placeholder = "Enter message..."
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        inputTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        inputTextView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -60).isActive = true
        inputTextView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        
        containerView.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle("Send", for: .normal)
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        sendButton.setTitleColor(titleColor, for: .normal)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func handleSend() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let message = Message(context: context)
        message.friend = friend!
        message.text = inputTextView.text!
        message.isSender = NSNumber(booleanLiteral: true) as Bool
        message.date = NSDate()
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        inputTextView.text = nil
        
        messages?.append(message)
        let insertionIndexPath = NSIndexPath(item: (messages?.count)! - 1, section: 0)
        collectionView?.insertItems(at: [insertionIndexPath as IndexPath])
        collectionView?.scrollToItem(at: insertionIndexPath as IndexPath, at: .bottom, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (messages?.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatLogCell
        
        cell.messageTextView.text = messages?[indexPath.item].text
        
        if let message = messages?[indexPath.item].text, let profileImage = messages?[indexPath.item].friend?.profileImageName, let isSender = messages?[indexPath.item].isSender {
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimateFrame = NSString(string: message).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
            cell.profileImageView.image = UIImage(named: profileImage)
            
            if !isSender {
                
                cell.messageTextView.frame = CGRect(x: 44, y: 0, width: estimateFrame.width + 26, height: estimateFrame.height + 20)
                cell.messageBubbleView.frame = CGRect(x: 40, y: 0, width: estimateFrame.width + 26, height: estimateFrame.height + 20)
                cell.messageBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
                cell.messageTextView.textColor = UIColor.black
                cell.profileImageView.isHidden = false
            } else {
                
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimateFrame.width - 26, y: 0, width: estimateFrame.width + 26, height: estimateFrame.height + 20)
                cell.messageBubbleView.frame = CGRect(x: view.frame.width - estimateFrame.width - 34, y: 0, width: estimateFrame.width + 26, height: estimateFrame.height + 20)
                cell.messageBubbleView.backgroundColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                cell.messageTextView.textColor = UIColor.white
                cell.profileImageView.isHidden = true
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let message = messages?[indexPath.item].text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimateFrame = NSString(string: message).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
            
            return CGSize(width: view.frame.width, height: estimateFrame.height + 20)
        }
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        inputTextView.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        inputTextView.resignFirstResponder()
    }
}
