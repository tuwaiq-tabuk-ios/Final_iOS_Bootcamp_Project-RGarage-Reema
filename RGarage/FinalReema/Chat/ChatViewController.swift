//
//  ChatViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 23/05/1443 AH.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
  
  @IBOutlet weak var messageTableView: UITableView!
  @IBOutlet weak var messageTextFeild: UITextField!
  @IBOutlet weak var sendarName: UILabel!
  
  let db = Firestore.firestore()
  var messages :[Messages] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    messageTableView.delegate = self
    messageTableView.dataSource = self
    // Do any additional setup after loading the view.
  }
  
  // فنكشن تجيب البانات من قاعدة البيانات
  func loadData(){
    db.collection("messages").order(by:"time").addSnapshotListener { (querySnapshot, erorr) in
      if let snapshotDoc = querySnapshot?.documents{
        self.messages = []
        for doc in snapshotDoc{
          let data = doc.data()
          if let messagSender = data["sender"] as? String ,
             let messagText = data["text"] as? String {
            let newMessage = Messages(sender: messagSender ,
                                      body : messagText)
            self.messages.append(newMessage)
            DispatchQueue.main.async {
              self.messageTableView.reloadData()
            }
            
          }
          
        }
      }
    }
    
  }
  
  @IBAction func sendButtonPressed(_ sender: UIButton) {
    if let messageText = messageTextFeild.text ,
       let messageSender = Auth.auth().currentUser?.email {
      db.collection("messages").addDocument(data:[
        "sender" : messageSender ,
        "text" :messageText,
        "time" :Date().timeIntervalSince1970
      ]){(error) in
        if let err = error {
          print(err)
        }else{
          DispatchQueue.main.async {
            self.messageTextFeild.text = ""
            
          }
        }
      }
    }
  }
}
extension ChatViewController : UITableViewDataSource , UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = messageTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
    cell.messageLabel.text = messages[indexPath.row].body
    cell.backgroundColor = .clear
    
    let messsage = messages[indexPath.row]
    if messsage.sender == Auth.auth().currentUser?.email{
      cell.getMessageDesign(sender: .me)
    }else{
      cell.getMessageDesign(sender: .other)
    }
    return cell
  }
}

