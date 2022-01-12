//
//  CatsUsersTVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 08/06/1443 AH.
//

import UIKit
struct InfoChat {
    var NameLosser: String
    var lessorImage = UIImage()
 
}
class ChatsUsersTVC: UITableViewController {
var infoChat = [InfoChat]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    // MARK: - Table view data source

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return   infoChat.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
      let infoChatAD = infoChat[indexPath.row]
      
    let cell = tableView.dequeueReusableCell(withIdentifier:"ChatusersCell") as! ChatusersCell
      
      cell.imageUser.image = infoChatAD.lessorImage
      cell.userName.text = infoChatAD.NameLosser
        
      return cell
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      
    storyboard.instantiateViewController(withIdentifier: "ChatusersCell") as! ChatusersCell
      
      
      
//      self.navigationController?.pushViewController(vc, animated: true)
      
    }

}
