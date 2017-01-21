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
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let samarth = Friend(context: context)
        samarth.name = "Samarth Paboowal"
        samarth.profileImageName = "profileImage"
        
        
        let messageSamarth = Message(context: context)
        messageSamarth.friend = samarth
        messageSamarth.text = "Hi, this is Samarth Paboowal"
        messageSamarth.date = NSDate().addingTimeInterval(-2*60)
        messageSamarth.isSender = NSNumber(booleanLiteral: false) as Bool
        
        let messageSamarth2 = Message(context: context)
        messageSamarth2.friend = samarth
        messageSamarth2.text = "I know you're gOd."
        messageSamarth2.date = NSDate().addingTimeInterval(-2*60)
        messageSamarth2.isSender = NSNumber(booleanLiteral: true) as Bool
        
        let sarvesh = Friend(context: context)
        sarvesh.name = "Sarvesh Sharma"
        sarvesh.profileImageName = "sarveshProfile"
        
        let messageSarvesh = Message(context: context)
        messageSarvesh.friend = sarvesh
        messageSarvesh.text = "Hi, this is Sarvesh Sharma"
        messageSarvesh.date = NSDate().addingTimeInterval(-3*60)
        messageSarvesh.isSender = NSNumber(booleanLiteral: false) as Bool
        
        let messageSarvesh2 = Message(context: context)
        messageSarvesh2.friend = sarvesh
        messageSarvesh2.text = "Hi"
        messageSarvesh2.date = NSDate().addingTimeInterval(-1*60)
        messageSarvesh2.isSender = NSNumber(booleanLiteral: false) as Bool
        
        let messageSarvesh3 = Message(context: context)
        messageSarvesh3.friend = sarvesh
        messageSarvesh3.text = "Hi, this is Chutiya Channa Hi, this is Chutiya Channa Hi, this is Chutiya Channa Hi, this is Chutiya Channa Hi, this is Chutiya Channa"
        messageSarvesh3.date = NSDate().addingTimeInterval(-0*60)
        messageSarvesh3.isSender = NSNumber(booleanLiteral: false) as Bool
        
        let messageSarvesh4 = Message(context: context)
        messageSarvesh4.friend = sarvesh
        messageSarvesh4.text = "Ha be tu ek number ka chutiya aur lodu hai"
        messageSarvesh4.date = NSDate().addingTimeInterval(-0*60)
        messageSarvesh4.isSender = NSNumber(booleanLiteral: true) as Bool
        
        let messageSarvesh5 = Message(context: context)
        messageSarvesh5.friend = sarvesh
        messageSarvesh5.text = "Ha be tu ek number ka chutiya aur lodu hai"
        messageSarvesh5.date = NSDate().addingTimeInterval(-0*60)
        messageSarvesh5.isSender = NSNumber(booleanLiteral: true) as Bool
        
        let messageSarvesh6 = Message(context: context)
        messageSarvesh6.friend = sarvesh
        messageSarvesh6.text = "Ha be tu ek number ka chutiya aur lodu hai"
        messageSarvesh6.date = NSDate().addingTimeInterval(-0*60)
        messageSarvesh6.isSender = NSNumber(booleanLiteral: true) as Bool
        
        let messageSarvesh7 = Message(context: context)
        messageSarvesh7.friend = sarvesh
        messageSarvesh7.text = "Ha be tu ek number ka chutiya aur lodu hai"
        messageSarvesh7.date = NSDate().addingTimeInterval(-0*60)
        messageSarvesh7.isSender = NSNumber(booleanLiteral: true) as Bool
        
        let messageSarvesh8 = Message(context: context)
        messageSarvesh8.friend = sarvesh
        messageSarvesh8.text = "Ha be tu ek number ka chutiya aur lodu hai"
        messageSarvesh8.date = NSDate().addingTimeInterval(-0*60)
        messageSarvesh8.isSender = NSNumber(booleanLiteral: true) as Bool
        
        let messageSarvesh9 = Message(context: context)
        messageSarvesh9.friend = sarvesh
        messageSarvesh9.text = "Ha be tu ek number ka chutiya aur lodu hai"
        messageSarvesh9.date = NSDate().addingTimeInterval(-0*60)
        messageSarvesh9.isSender = NSNumber(booleanLiteral: true) as Bool
        
        let messageSarvesh10 = Message(context: context)
        messageSarvesh10.friend = sarvesh
        messageSarvesh10.text = "Ha be tu ek number ka chutiya aur lodu hai"
        messageSarvesh10.date = NSDate().addingTimeInterval(-0*60)
        messageSarvesh10.isSender = NSNumber(booleanLiteral: true) as Bool
        
        let rishabh = Friend(context: context)
        rishabh.name = "Rishabh Sharma"
        rishabh.profileImageName = "rishabhProfile"
        
        let messageRishabh = Message(context: context)
        messageRishabh.friend = rishabh
        messageRishabh.text = "Hi, this is Rishabh Sharma"
        messageRishabh.date = NSDate().addingTimeInterval(-60*24*60)
        messageRishabh.isSender = NSNumber(booleanLiteral: false) as Bool
        
        let shubham = Friend(context: context)
        shubham.name = "Shubham Sharma"
        shubham.profileImageName = "profileShubham"
        
        let messageShubham = Message(context: context)
        messageShubham.friend = shubham
        messageShubham.text = "Hi, this is Shubham Sharma"
        messageShubham.date = NSDate().addingTimeInterval(-60*60*24*8)
        messageShubham.isSender = NSNumber(booleanLiteral: false) as Bool
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
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
