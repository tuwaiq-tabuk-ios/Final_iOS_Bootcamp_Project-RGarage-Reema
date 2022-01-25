//
//  GlobalVariables.swift
//  FinalReema
//
//  Created by Reema Mousa on 14/06/1443 AH.
//

import Foundation
import Firebase
//import FirebaseFirestore


let db = Firestore.firestore()
let storage = Storage.storage()
let storageImage = Storage.storage().reference()
var user: UserModel!
