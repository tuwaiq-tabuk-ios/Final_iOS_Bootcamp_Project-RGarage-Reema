//
//  CatsUsersTVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 08/06/1443 AH.
//


import UIKit

 class ChatsUsersTVC: UITableViewController {


   var messgae : [Messages] = []

   var ChatRooms = [chatRoom]()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return   ChatRooms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      let infoChatAD = ChatRooms[indexPath.row]

    let cell = tableView.dequeueReusableCell(withIdentifier:"ChatusersCell") as! ChatusersCell


      return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


      let storyboard = UIStoryboard(name: "Main", bundle: nil)

    storyboard.instantiateViewController(withIdentifier: "ChatusersCell") as! ChatusersCell

 
    }

}
