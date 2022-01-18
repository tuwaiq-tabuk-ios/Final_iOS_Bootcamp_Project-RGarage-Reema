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

  let db = Firestore.firestore()
  
  var selectedConversation: ChatRoom?

  var messages :[Messages] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(selectedConversation?.usersIds)
    
    loadData()

  }
  
  
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    messageTextFeild.resignFirstResponder()
  }

  @IBAction func sendButtonPressed(_ sender: UIButton) {
    if let messageText = messageTextFeild.text {
      let message = Messages(senderID: user.uid, body: messageText)
      selectedConversation?.message.append(message)
      
      do {
        try db.collection("conversations").document(selectedConversation!.docID!).setData(from: selectedConversation, merge: true) { error in
          if let error = error {
            fatalError(error.localizedDescription)
          }
          //
          self.messageTextFeild.text = ""
        }
      } catch {
        fatalError(error.localizedDescription)
      }

    }
    
  }

//  فنكشن تجيب البانات من قاعدة البيانات
  func loadData(){
    db.collection("conversations").document(selectedConversation!.docID!).addSnapshotListener { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      if let snapshot = snapshot {
        do {
          self.selectedConversation = try snapshot.data(as: ChatRoom.self)!
          self.messageTableView.reloadData()
        } catch {
          fatalError(error.localizedDescription)
        }
      }
      
    }

  }
}

extension ChatViewController : UITableViewDataSource , UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (selectedConversation?.message.count)!
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = messageTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
    

    guard let message = selectedConversation?.message[indexPath.row] else { return cell }
    cell.messageLabel.text = message.body
    cell.backgroundColor = .clear
    if message.senderID == user.uid {
      cell.getMessageDesign(sender: .me)
    }else{
      cell.getMessageDesign(sender: .other)
    }

    return cell
  }
}

