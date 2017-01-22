//
//  ViewController.swift
//  Demo Messenger
//
//  Created by Samarth Paboowal on 12/01/17.
//  Copyright © 2017 Junkie Labs. All rights reserved.
//

import UIKit
import CoreData

class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellID = "cellID"
    var messages = [Message]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        navigationController?.navigationBar.backgroundColor = UIColor.gray
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellID)
        
        setupData()
        //clearData()
    }
    
    func clearData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let entityNames = ["Friend", "Message"]
        
        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            do{
                let objects = try context.fetch(fetchRequest) as! [NSManagedObject]
                for object in objects {
                    context.delete(object)
                }
            } catch let err {
                print(err)
            }
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func setupData() {
        
        clearData()
        
        let sarvesh = IncomingMessage.createFriend(name: "Sarvesh Sharma", profileImageName: "sarveshProfile")
        IncomingMessage.createMessage(newFriend: sarvesh, text: "Hi!", timeAgo: 25)
        IncomingMessage.createMessage(newFriend: sarvesh, text: "Hi!", timeAgo: 24, isSender: true)
        IncomingMessage.createMessage(newFriend: sarvesh, text: "Who is this?", timeAgo: 23, isSender: true)
        IncomingMessage.createMessage(newFriend: sarvesh, text: "I am Sarvesh Sharma", timeAgo: 22)
        IncomingMessage.createMessage(newFriend: sarvesh, text: "Oh!", timeAgo: 21, isSender: true)
        IncomingMessage.createMessage(newFriend: sarvesh, text: "I remember you.", timeAgo: 20, isSender: true)
        
        let rishabh = IncomingMessage.createFriend(name: "Rishabh Sharma", profileImageName: "rishabhProfile")
        IncomingMessage.createMessage(newFriend: rishabh, text: "Hi!", timeAgo: 15)
        IncomingMessage.createMessage(newFriend: rishabh, text: "Hi!", timeAgo: 14, isSender: true)
        IncomingMessage.createMessage(newFriend: rishabh, text: "Who is this?", timeAgo: 13, isSender: true)
        IncomingMessage.createMessage(newFriend: rishabh, text: "I am Rishabh Sharma", timeAgo: 12)
        IncomingMessage.createMessage(newFriend: rishabh, text: "Oh!", timeAgo: 11, isSender: true)
        IncomingMessage.createMessage(newFriend: rishabh, text: "I remember you.", timeAgo: 10, isSender: true)
        
        let shubham = IncomingMessage.createFriend(name: "Shubham Sharma", profileImageName: "profileShubham")
        IncomingMessage.createMessage(newFriend: shubham, text: "Hi!", timeAgo: 19)
        IncomingMessage.createMessage(newFriend: shubham, text: "Hi!", timeAgo: 18, isSender: true)
        IncomingMessage.createMessage(newFriend: shubham, text: "Who is this?", timeAgo: 17, isSender: true)
        IncomingMessage.createMessage(newFriend: shubham, text: "I am Shubham Sharma", timeAgo: 16)
        IncomingMessage.createMessage(newFriend: shubham, text: "Oh!", timeAgo: 15, isSender: true)
        IncomingMessage.createMessage(newFriend: shubham, text: "I remember you.", timeAgo: 14, isSender: true)
        
        let samarth = IncomingMessage.createFriend(name: "Samarth Paboowal", profileImageName: "profileImage")
        IncomingMessage.createMessage(newFriend: samarth, text: "Hi!", timeAgo: 5)
        IncomingMessage.createMessage(newFriend: samarth, text: "Hi!", timeAgo: 4, isSender: true)
        IncomingMessage.createMessage(newFriend: samarth, text: "Who is this?", timeAgo: 3, isSender: true)
        IncomingMessage.createMessage(newFriend: samarth, text: "I am Samarth Paboowal", timeAgo: 2)
        IncomingMessage.createMessage(newFriend: samarth, text: "Oh!", timeAgo: 1, isSender: true)
        IncomingMessage.createMessage(newFriend: samarth, text: "I remember you.", timeAgo: 0, isSender: true)
        
        loadData()
    }
    
    func loadData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let friendFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        do {
            let friends = try context.fetch(friendFetch) as! [Friend]
            
            for friend in friends {
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                fetchRequest.fetchLimit = 1
                
                do{
                    let message = try context.fetch(fetchRequest) as! [Message]
                    messages.append(contentsOf: message)
                } catch let err {
                    print(err)
                }
            }
        } catch let error {
            print(error)
        }
        
        // Sorting messages array in descending order
        messages = messages.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MessageCell
        
        let message = messages[indexPath.item]
        cell.message = message
        
        if !(cell.message?.isSender)! {
            cell.seenMessageImageView.isHidden = true
        } else {
            cell.seenMessageImageView.isHidden = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        let controller = ChatLogController(collectionViewLayout: layout)
        controller.friend = messages[indexPath.item].friend
        navigationController?.pushViewController(controller, animated: true)
    }
}
