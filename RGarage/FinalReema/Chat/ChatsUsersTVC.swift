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


struct InfoChatLessor {
  var name: String
  var image : UIImage? = nil
  
  var dictionary: [String: Any] {
    return [
      "FullName": name]
  }
  
}
class ChatsUsersTVC: UITableViewController {
  var infoChatLessor = [InfoChatLessor]()
  let db = Firestore.firestore()
  let storage = Storage.storage()
  @IBOutlet weak var tableChatsBetweenUsers: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
  }
  
  func loadData() {

    db.collection("users").getDocuments() { (snapshot, error) in
      
      if let error = error {
        
        print(error.localizedDescription)
        
      } else {
        
        if let snapshot = snapshot {
          
          for document in snapshot.documents {
//            print("****\(document.documentID)")

            let user = Auth.auth().currentUser
            guard let  currentUser  = user  else{return}
            
            let data = document.data()
            let nameLessorInChat = data["FullName"] as? String ?? ""
            let imagePath = "images/\(currentUser.uid).png"
            let pathReference = self.storage.reference(withPath: imagePath)
            print("\(imagePath)")
            pathReference.getData(maxSize: 1000 * 1024 * 1024) { data, error in
              if let error = error {
                print(error)
              }
              
              else {
                let image = UIImage(data: data!)
                Firestore.firestore().collection("Advertising")
                let newAD = InfoChatLessor(name: nameLessorInChat,image: image)
                self.infoChatLessor.append(newAD)
              }
              self.tableChatsBetweenUsers.reloadData()
              
            }
          }
        }
      }
    }
  }
  
  
  // MARK: - Table view data source
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return  infoChatLessor.count

  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier:"ChatusersCell") as! ChatusersCell
    cell.userName.text = infoChatLessor[indexPath.row].name
    cell.imageUser.image = infoChatLessor[indexPath.row].image
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    storyboard.instantiateViewController(withIdentifier: "ChatusersCell") as! ChatusersCell
    
    
  }
  
}
