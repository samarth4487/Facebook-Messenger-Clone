//
//  FriendCell.swift
//  Demo Messenger
//
//  Created by Samarth Paboowal on 13/01/17.
//  Copyright © 2017 Junkie Labs. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    var message: Message? {
        didSet{
            
            nameLabel.text = message?.friend?.name
            profileImageView.image = UIImage(named: (message?.friend?.profileImageName)!)
            recentMessageLabel.text = message?.text
            seenMessageImageView.image = UIImage(named: (message?.friend?.profileImageName)!)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            
            let elapsedTime = NSDate().timeIntervalSince(message?.date as! Date)
            let secondsInDay: TimeInterval = 60 * 60 * 24
            
            if elapsedTime > secondsInDay * 7 {
                dateFormatter.dateFormat = "MM/dd/yy"
            } else if elapsedTime > secondsInDay {
                dateFormatter.dateFormat = "EEE"
            }
            
            timeLabel.text = dateFormatter.string(from: (message?.date)! as Date)
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? UIColor(red: 0, green: 134/255, blue: 249/255, alpha: 1) : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            timeLabel.textColor = isHighlighted ? UIColor.white : UIColor.gray
            recentMessageLabel.textColor = isHighlighted ? UIColor.white : UIColor.lightGray
        }
    }
    
    let profileImageView = UIImageView()
    let containerView = UIView()
    let nameLabel = UILabel()
    let timeLabel = UILabel()
    let recentMessageLabel = UILabel()
    let seenMessageImageView = UIImageView()
    let bottomBorderView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        //backgroundColor = UIColor.blue
        
        profileImageView.image = UIImage(named: "profileImage")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 25.0
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        //containerView.backgroundColor = UIColor.red
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameLabel)
        nameLabel.text = "Samarth Paboowal"
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -80).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/2).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(timeLabel)
        timeLabel.text = "12.05 am"
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.gray
        timeLabel.textAlignment = .right
        timeLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        
        recentMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(recentMessageLabel)
        recentMessageLabel.text = "Hi Samarth, How are you doing lately?"
        recentMessageLabel.textColor = UIColor.lightGray
        recentMessageLabel.font = UIFont.systemFont(ofSize: 14)
        recentMessageLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        recentMessageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        recentMessageLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor , constant: -40).isActive = true
        recentMessageLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/2).isActive = true
        
        seenMessageImageView.image = UIImage(named: "profileImage")
        seenMessageImageView.contentMode = .scaleAspectFill
        containerView.addSubview(seenMessageImageView)
        seenMessageImageView.translatesAutoresizingMaskIntoConstraints = false
        seenMessageImageView.layer.masksToBounds = true
        seenMessageImageView.layer.cornerRadius = 10.0
        seenMessageImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        seenMessageImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        seenMessageImageView.leftAnchor.constraint(equalTo: recentMessageLabel.rightAnchor, constant: 10).isActive = true
        seenMessageImageView.centerYAnchor.constraint(equalTo: recentMessageLabel.centerYAnchor).isActive = true
        
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.backgroundColor = UIColor.lightGray
        addSubview(bottomBorderView)
        bottomBorderView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        bottomBorderView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        bottomBorderView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
