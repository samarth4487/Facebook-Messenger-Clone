//
//  IncomingMessage.swift
//  Demo Messenger
//
//  Created by Samarth Paboowal on 22/01/17.
//  Copyright © 2017 Junkie Labs. All rights reserved.
//

import UIKit
import CoreData

class IncomingMessage {
    
    static func createFriend(name: String, profileImageName: String) -> Friend {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let newFriend = Friend(context: context)
        newFriend.name = name
        newFriend.profileImageName = profileImageName
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        return newFriend
    }
    
    static func createMessage(newFriend: Friend, text: String, timeAgo: Double, isSender: Bool = false) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let messageSamarth = Message(context: context)
        messageSamarth.friend = newFriend
        messageSamarth.text = text
        messageSamarth.date = NSDate().addingTimeInterval(-timeAgo*60)
        messageSamarth.isSender = NSNumber(booleanLiteral: isSender) as Bool
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
