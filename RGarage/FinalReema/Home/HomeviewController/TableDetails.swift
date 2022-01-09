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
  
//  func loadImage() {
//    let user = Auth.auth().currentUser
//    print(user?.uid)
//    guard let  currentUser  = user  else{return}
//    let pathReference = storage.reference(withPath: "imagesAD/\(currentUser.uid).png")
//    pathReference.getData(maxSize: 1000 * 1024 * 1024) { data, error in
//      if let error = error {
//        // Uh-oh, an error occurred!
//        print(error)
//      } else {
//        // Data for "images/island.jpg" is returned
//        let image = UIImage(data: data!)
//        self.imageTabel.image = image
//      }
//    }
//  }
 }
 

