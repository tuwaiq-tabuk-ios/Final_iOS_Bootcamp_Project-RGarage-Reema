//
//  TableDetails.swift
//  FinalReema
//
//  Created by Reema Mousa on 11/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
class  TableDetails : UITableViewCell {
  
  
  let db = Firestore.firestore()
  let storage = Storage.storage()
// item home srcren item
  
  @IBOutlet weak var address: UILabel!
  @IBOutlet weak var data: UILabel!
  @IBOutlet weak var price: UILabel!
  @IBOutlet weak var imageTabel : UIImageView!
  
 }
 

