//
//  UpdateAccount.swift
//  FinalReema
//
//  Created by Reema Mousa on 13/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
class UpdateAccount: UIViewController,UIImagePickerControllerDelegate , UINavigationControllerDelegate {
  @IBOutlet weak var updateUserPhoto: UIImageView!
  
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  //for updat user photo but not complit
  @IBAction func updateUserPhotoButton(_ sender: Any) {
    let addImge = UIImagePickerController()
    addImge.sourceType = .photoLibrary
    addImge.delegate = self
    addImge.allowsEditing = true
    present(addImge, animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    updateUserPhoto.image = image
    self.dismiss(animated: true, completion: nil)
  }
  
  
  // button for user logout from the system
  @IBAction func logoutUserPressed(_ sender: Any) {
   try! Auth.auth().signOut()
    //when user logout go to this page
            let wellcome = self.storyboard?.instantiateViewController(identifier: "Wellcome") as? Wellcome
            
            self.view.window?.rootViewController = wellcome
            self.view.window?.makeKeyAndVisible()
        }
    
    
//  }
  
}

