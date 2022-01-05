//
//  ChatVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 30/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore
class ChatVC: UIViewController {
  
  
  @IBOutlet weak var messageTableView: UITableView!
  @IBOutlet weak var sendButton: UIButton!
  
  @IBOutlet weak var messageTextfield: UITextField!
  
  var messages: [Message] = []
  //1
  let db = Firestore.firestore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    messageTextfield.layer.cornerRadius = 25
    messageTextfield.clipsToBounds = true
    
    //  register the xnib file
    messageTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    loadMessages()
  }
  
  // MARK: - load data from the cloud
  func loadMessages(){

    db.collection("Messages").getDocuments{ (querySnapshot, error) in

//        self.messages = []
//
//        if let e = error {
//          print(e)
//        }else {

          if let snapshotDocuments = querySnapshot?.documents{
            for doc in snapshotDocuments {
              let data = doc.data()
              if let Messagesender = data["sender"] as? String,
                 let messageBody = data["body"] as? String{

                let newMessage = Message(sender: Messagesender, body: messageBody)

                self.messages.append(newMessage)
                DispatchQueue.main.async {
                  self.messageTableView.reloadData()

                  let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                  self.messageTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
              }
            }
          }
        }
      }
  }
  
//
//  @IBAction func sendPressed(_ sender: UIButton) {
//    
//    if let messageBody = messageTextfield.text,
//       let messageSender = Auth.auth().currentUser?.email {
//
//      db.collection("messages").addDocument(data: [
//        "sender": messageSender,
//        "body": messageBody,
//        "date" : Date().timeIntervalSince1970
//
//      ]) { (error) in
//        if let err = error {
//          print(err)
//        }else {
//          print("messages successfuly save!")
//
//          DispatchQueue.main.async {
//            self.messageTextfield.text = ""
//          }
//        }
//      }
//    }
//
//  }
  
//}

extension ChatVC: UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = messageTableView.dequeueReusableCell(withIdentifier: "ReusableCell") as! MessageTableViewCell
    
//    cell.messageBody.text = messages[indexPath.row].body
//    cell.backgroundColor = .clear
//    let message = messages[indexPath.row]
//
//    // if the current user is the sender
//    if message.sender == Auth.auth().currentUser?.email {
//      DispatchQueue.main.async {
//        cell.getMessageDesign(sender: ".me")
//      }
//
//    } else {
//      DispatchQueue.main.async {
//        cell.getMessageDesign(sender: ".other")
//      }
//    }

    return cell
  }

}
