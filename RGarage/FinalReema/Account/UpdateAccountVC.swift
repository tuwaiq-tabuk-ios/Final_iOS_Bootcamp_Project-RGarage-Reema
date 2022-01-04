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
  
  //variabls
let db = Firestore.firestore()
//  var userInfo : UserInfo?
 
  
  var userFullNameUPdate : String = ""
  var userEmailUPdate : String = ""
  var userPasswordUPdate: String = ""
  var userConfirmPasswordUPdate : String = ""
  var userImageUPdate = UIImage()


  @IBOutlet weak var nameUpdate: UITextField!
  @IBOutlet weak var emailUpdate: UITextField!
  @IBOutlet weak var passwordUpdate: UITextField!
  @IBOutlet weak var confirmPasswordUpdate: UITextField!
  @IBOutlet weak var updateUserPhoto: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    let email = Auth.auth().currentUser!.email
//    let user = email
//     emailUpdate.text = user
   }
  
//    override func viewWillAppear(_ animated: Bool) {
//          super.viewWillAppear(animated) // call super
//
//          getName { (name) in
//              if let name = name {
//                  self.nameUpdate.text = name
//                  print("great success")
//              }
//          }
//      }
//  func getName(completion: @escaping (_ name: String?) -> Void) {
//    guard let uid = Auth.auth().currentUser?.uid else {return}
//    let userRef = Firestore.firestore().collection("users").document(uid)
//    userRef.getDocument { (documentSnapshot, error) in guard
//        let document = documentSnapshot?.data() else {
//            print(error)
//            return
//        }
//        print(document)
//    }
//     }
    //rawbi
//    print(user?.uid)
//    if let currentUser  = user {
//    db.collection("users").document(currentUser.uid).getDocument { doc , err in
//      if err != nil {
//        print(err)
//      }
//      else{
//        let data = doc!.data()!
//        self.userInfo?.fullName = data["fulNmae"] as! String
//        self.userInfo?.email = data["email"] as! String
////        self.userInfo.avatar = data["email"] as! String
//
//      }
//    }
//
//    }
    
    //rawaboi
    
    
//
//    if  let user = user {
//      let email = user.email
//      emailUpdate.text = email
//
//
//    }
    
//      let db = Firestore.firestore()

    
    //let userCollection = db.collection("users")
//
//    let name = db.collection("users").document().collection("fulNmae")
//    print("\n\n\n\n******NAME: \(name)")
      
      //     nameUpdate.text = userFullNameUPdate
      //     emailUpdate.text = userEmailUPdate
      //     passwordUpdate.text = userPasswordUPdate
      //     confirmPasswordUpdate.text = userConfirmPasswordUPdate
      //     updateUserPhoto.image = userImageUPdate
      
  

  
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
  @IBAction func logoutUserPressed(_ sender: Any)
//  {
//      do {
//          try  Auth.auth().signOut()
//          dismiss(animated: true, completion: nil)
//      } catch let signOutError as NSError {
//          print ("Error signing out: %@", signOutError)
//      }
//  }
  
  {
    try! FirebaseAuth.Auth.auth().signOut()
    //when user logout go to this page
    let wellcome = self.storyboard?.instantiateViewController(identifier: "Wellcome") as? Wellcome

    self.view.window?.rootViewController = wellcome
    self.view.window?.makeKeyAndVisible()
  }
  
}



