//
//  UserModel.swift
//  FinalReema
//
//  Created by Reema Mousa on 14/06/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel: Codable {
  
  @DocumentID var docID: String?
  
  var uid: String
  var email: String
  var fullName: String
  var phoneNumber: String
  var imgURL: String?
}

