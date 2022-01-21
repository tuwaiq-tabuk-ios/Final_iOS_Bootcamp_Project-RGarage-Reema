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
  var selectedConversation: ChatRoom?
  
  
  @IBOutlet weak var tableChatsBetweenUsers: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "ChatsRoom"
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    loadData()
  }


  func loadData() {
    self.startLoading()
    db.collection("conversations").whereField("usersIds", arrayContains: user!.uid).getDocuments() { (snapshot, error) in
      self.conversations.removeAll()
      if let error = error {
        fatalError(error.localizedDescription)
        
      } else {
        if let docs = snapshot?.documents {
          for doc in docs {
            do {
              try self.conversations.append(doc.data(as: ChatRoom.self)!)
            } catch {
              fatalError(error.localizedDescription)
            }
          }
          self.tableChatsBetweenUsers.reloadData()
          self.stopLoading()
        }
      }
    }
  }
}


extension ChatsUsersTVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return conversations.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier:"ChatusersCell") as! ChatuserCell
    
    let conversation = conversations[indexPath.row]
    let oUser = conversation.users.first { usr in usr.id != user.uid
    }!
    //load name,last message
    cell.userName.text = oUser.name
    if let lastMessage = conversation.message.last {
      cell.lastmessageLabel?.text = lastMessage.body
    }
    //loadImage
    if let imgURL = oUser.imgURL
    {
      if imgURL != "" {
        cell.imageUser.load(url: URL(string: imgURL)!)
      }
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
    controller.selectedConversation = conversations[indexPath.row]
    self.navigationController?.pushViewController(controller, animated: true)
  }
}
