//
//  UpdateAccount.swift
//  FinalReema
//
//  Created by Reema Mousa on 13/05/1443 AH.
//

import UIKit

class UpdateAccount: UIViewController,UIImagePickerControllerDelegate , UINavigationControllerDelegate {
  @IBOutlet weak var updateUserPhoto: UIImageView!
  
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
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
}
