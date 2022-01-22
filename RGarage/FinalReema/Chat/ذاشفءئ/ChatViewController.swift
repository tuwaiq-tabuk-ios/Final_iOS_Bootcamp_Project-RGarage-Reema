//
//  ChatViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 23/05/1443 AH.
//

import UIKit
import Firebase
import Foundation
import CoreMIDI

class ChatViewController: UIViewController {
  
  @IBOutlet weak var messageTableView: UITableView!
  @IBOutlet weak var messageTextFeild: UITextField!
  
  var selectedConversation: ChatRoom?
  var messages :[Message] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
   //MARK: Kayboard  up in caht
    NotificationCenter.default.addObserver(self
                                           , selector: #selector(ChatViewController.keyboardWillShow)
                                           , name: UIResponder.keyboardWillShowNotification, object: nil)

    NotificationCenter.default.addObserver(self
                                           , selector: #selector(ChatViewController.keyboardWillHide)
                                           , name: UIResponder.keyboardWillHideNotification, object: nil)
    loadData()
  }

  @objc func keyboardWillShow(notification: NSNotification) {
     guard let keyboardSize = (notification
                                .userInfo?[UIResponder
                                            .keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
       return
    }
         self.view.frame.origin.y = 20 - keyboardSize.height
  }

  
  @objc func keyboardWillHide(notification: NSNotification) {
     self.view.frame.origin.y = 10
  }
  
  // MARK: dismiss Keyboard
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    messageTextFeild.resignFirstResponder()
  }
  
  
  // MARK: send Button Chat Pressed
  @IBAction func sendButtonPressed(_ sender: UIButton) {
    
    if let messageText = messageTextFeild.text {
      let message = Message(senderID: user.uid, body: messageText, date: Date())
      selectedConversation?.message.append(message)
      do {
        try db
          .collection("conversations")
          .document(selectedConversation!.docID!)
          .setData(from: selectedConversation, merge: true) { error in
            
          if let error = error {
            fatalError(error.localizedDescription)
          }
          self.messageTextFeild.text = ""
        }
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  //MARK: loadData
  func loadData(){
    db
      .collection("conversations")
      .document(selectedConversation!.docID!)
      .addSnapshotListener { snapshot, error in
        
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


//MARK: extention
extension ChatViewController : UITableViewDataSource ,
                               UITableViewDelegate{
  
  func tableView(_ tableView: UITableView
                 , numberOfRowsInSection section: Int) -> Int {
    return (selectedConversation?.message.count)!
  }

  func tableView(_ tableView: UITableView
                 , cellForRowAt indexPath: IndexPath)
                                   -> UITableViewCell {

    let cell = messageTableView
                              .dequeueReusableCell(withIdentifier: "messageCell"
                                                    , for: indexPath) as! MessageCell
    
    guard let message = selectedConversation?
                            .message[indexPath.row] else { return cell }

    cell.messageLabel.text = message.body
    cell.backgroundColor = .clear
    cell.timeSendMsg.text = message.date
                                       .getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
                                     
    if message.senderID == user.uid {
      cell.getMessageDesign(sender: .me)

    }else {
      cell.getMessageDesign(sender: .other)
    }
    return cell
  }
}

