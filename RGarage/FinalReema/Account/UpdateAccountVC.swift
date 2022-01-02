//
//  UpdateAccountVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 13/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth


class UpdateAccountVC: UIViewController,
                       UIImagePickerControllerDelegate ,
                       UINavigationControllerDelegate {
  
  @IBOutlet weak var nameUpdate: UITextField!
  @IBOutlet weak var emailUpdate: UITextField!
  @IBOutlet weak var passwordUpdate: UITextField!
  @IBOutlet weak var confirmPasswordUpdate: UITextField!
  
  @IBOutlet weak var updateUserPhoto: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    handle = Auth.auth().addStateDidChangeListener { auth, user in
//
//    }
//    if Auth.auth().currentUser != nil {
//      // User is signed in.
//      // ...
//    } else {
//      // No user is signed in.
//      // ...
//    }
//    Auth.auth().currentUser?.updateEmail(to: email) { error in
//      let email = user?.email
//
//    }
//
//    Auth.auth().currentUser?.updatePassword(to: password) { error in
//      // ...
//    }
  }
  
  
  //for update user photo but not complet
  @IBAction func updateUserPhotoButton(_ sender: Any) {
    let addImge = UIImagePickerController()
    addImge.sourceType = .photoLibrary
    addImge.delegate = self
    addImge.allowsEditing = true
    present(addImge, animated: true)
  }
  
  
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
  ) {
    let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    updateUserPhoto.image = image
    self.dismiss(animated: true, completion: nil)
  }
  
  
// button for user logout from the system
  @IBAction func logoutUserPressed(_ sender: Any) {
    try! FirebaseAuth.Auth.auth().signOut()
    //when user logout go to this page
    let wellcome = self.storyboard?.instantiateViewController(identifier: "Wellcome") as? Wellcome
    
    self.view.window?.rootViewController = wellcome
    self.view.window?.makeKeyAndVisible()
  }
   
  
  
 
//  
//  func getUserInfo(){
//    let db = Firestore.firestore()
//    
//    db.collection("users").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("------------------ Error getting documents: \(err)")
//      } else {
//        for document in querySnapshot!.documents {
//          print("\n\n**********")
//          print(" - \(document.documentID) => \(document.data())")
//          //                  self.userFullName = document.data()["fulNmae"] as! String
//        }
//        
//        let user = db.collection("users")
//        let query = user.whereField("Email", isEqualTo: "zahra@gmail.com")
//        print("\nquery: \(query.)")
//        
//        if query != nil {
//          
//        }
//        
//      }
//      
//      
//    }
//    
//    
//   
//    
//    
//    
//    //    guard let userUid = Auth.auth().currentUser?.uid else { return }
//    //    db.collection("users").document(userUid).getDocument { (snapshot, error) in
//    //      if let data = snapshot?.data() {
//    //        print("**********\n\n\n=> \(snapshot?.data())")
//    ////        print("**********\n\n\n(name)=> \(snapshot?.data()) ")
//    //
//    //      }
//    
//    //    func userRoleListener() {
//    //    guard let userUid = Auth.auth().currentUser.uid else { return } .
//    //    Firestore.firestore().collection("users").document(userUid).getDocument { (snapshot, error) in
//    //     if let data = snapshot?.data() {
//    //     guard let isAdmin = data["isAdmin"] as? Bool else { return }
//    //       if isAdmin {
//    //    // And I believe here the true and false values should be switched as you are checking if the user IS an admin, if they are an admin, shouldn't you show the button?
//    //        self.applyButton.isHidden = false
//    //       } else {
//    //         self.applyButton.isHidden = true
//    //       }
//    //      }
//    //     }
//    //    }
//    //
//    //
//    
//  }
}

//}
