//
//  AccountVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 04/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseCore
 
class AccountVC: UIViewController {
 
  @IBOutlet weak var profilePhoto: UIImageView!
  @IBOutlet weak var nameUser: UILabel!
  
//  var loggInUser = AnyObject?(<#AnyObject#>)
////  var databaseRef =
//  var storgeRef = FirebaseStorage.Storage().reference()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  func getUserInfo(){
    let db = Firestore.firestore()
    
    //    db.collection("users").getDocuments() { (querySnapshot, err) in
    //        if let err = err {
    //            print("Error getting documents: \(err)")
    //        } else {
    //            for document in querySnapshot!.documents {
    //                print("**********\n\n\n\(document.documentID) => \(document.data())")
    //              self.userFullName = document.data()["fulNmae"] as! String
    //            }
    //          //self.nameUser.text = self.userFullName
    //        }
    //    }
    
    let docRef = db.collection("users").document("uid")
    
    docRef.getDocument { (document, error) in
      if let document = document, document.exists {
        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
        print("Document data: \(dataDescription)")
      } else {
        print("Document does not exist")
      }
    }
    
  }
  
 }
