//
//  chatsRoom.swift
//  FinalReema
//
//  Created by Reema Mousa on 10/06/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

//user inside  conversation
struct ChatRoomUser: Codable {
  var id: String
  var name: String
  var imgURL: String?
}



//conversation
struct ChatRoom: Codable {
  @DocumentID var docID: String?
  var users :[ChatRoomUser]
  var usersIds: [String]
  var id : String? //for wh
  var message : [Messages]
  
}
