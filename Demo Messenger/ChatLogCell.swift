//
//  ChatLogCell.swift
//  Demo Messenger
//
//  Created by Samarth Paboowal on 15/01/17.
//  Copyright © 2017 Junkie Labs. All rights reserved.
//

import UIKit

class ChatLogCell: UICollectionViewCell {
    
    let messageTextView = UITextView()
    let messageBubbleView = UIView()
    let profileImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(messageBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        messageBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        messageBubbleView.layer.masksToBounds = true
        messageBubbleView.layer.cornerRadius = 15
        messageTextView.backgroundColor = UIColor.clear
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.isEditable = false
        messageTextView.font = UIFont.systemFont(ofSize: 16)
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 15
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
}
