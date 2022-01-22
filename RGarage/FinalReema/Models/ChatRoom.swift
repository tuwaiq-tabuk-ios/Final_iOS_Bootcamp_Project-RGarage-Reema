//
//  ChatRoom.swift
//  FinalReema
//
//  Created by Reema Mousa on 19/06/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct ChatRoom: Codable {
  @DocumentID var docID: String?
   var users :[ChatRoomUser]
   var usersIds: [String]
   var id : String?
   var message : [Message]
  
}
