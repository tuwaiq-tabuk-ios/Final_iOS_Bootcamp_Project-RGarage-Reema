//
//  CatsUsersTVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 08/06/1443 AH.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


class ChatsUsersTVC: UIViewController {
  
  var conversations: [ChatRoom] = []
  let db = Firestore.firestore()
  var selectedConversation: ChatRoom?
  
  @IBOutlet weak var tableChatsBetweenUsers: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
//    loadData()
  }

//  func loadData() {
//    db.collection("conversations").whereField("usersIds", arrayContains: user.uid).getDocuments() { (snapshot, error) in
//      self.conversations.removeAll()
//      if let error = error {
//        fatalError(error.localizedDescription)
//      } else {
//
//        if let docs = snapshot?.documents {
//
//          for doc in docs {
//            do {
//              try self.conversations.append(doc.data(as: ChatRoom.self)!)
//            } catch {
//              fatalError(error.localizedDescription)
//            }
//          }
//          self.tableChatsBetweenUsers.reloadData()
//        }
//      }
//    }
//  }
//}



}
