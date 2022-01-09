//
//  Add advertisingViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 11/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class AddAdvertising : UIViewController
,UIImagePickerControllerDelegate
, UINavigationControllerDelegate {
  

  // Database
  let db = Firestore.firestore()
  let user = Auth.auth().currentUser
  let storage = Storage.storage().reference()
  let profileImagesRef = Storage.storage().reference().child("imagesAD/")
  
  @IBOutlet weak var imageView: UIView!
  @IBOutlet weak var addImageAD: UIImageView!
  @IBOutlet weak var addressAD: UITextField!
  @IBOutlet weak var priceAD: UITextField!
  @IBOutlet weak var btnAddAdvertising: UIButton!
  @IBOutlet weak var BasicView: UIView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.layer.cornerRadius = imageView.frame.height/5
    addImageAD.layer.cornerRadius =  addImageAD.frame.height/5
    //shadow
    BasicView.layer.shadowOpacity = 10
    BasicView.layer.cornerRadius = 10
    BasicView.layer.shadowOffset = .zero
    BasicView.layer.shadowRadius = 150
    BasicView.layer.shouldRasterize = true
    

  }

  
  @IBAction func btnAddAdvertising(_ sender: Any) {
    
    if let addressUserD = addressAD.text,
       let priceUserD = priceAD.text,
//       let imageUserD = addImageAD.image ,
       let  userLogin = Auth.auth().currentUser?.email {
      
      db.collection("Advertising").addDocument(data: [
        "lessor": userLogin,
        "lessorAddress" : addressUserD ,
        "pricelessor" : priceUserD
//         "imageADlesso": imageUserD,
      ]){(error)in
        if let err = error {
          print(err)
        }
        else{
          DispatchQueue.main.async {
            self.addressAD.text = ""
            self.priceAD.text = ""
//            self.addImageAD.image = 
              }
        }
      }
      
    }
    let tapbar = storyboard?.instantiateViewController(withIdentifier: "tapbarVC") as! tapbarVC

    present(tapbar, animated: true, completion: nil)
     
    }
  
  
  
  @IBAction func addphotoButon(_ sender: Any) {
    
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
    guard let selectedImage =
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
      return
    }
    
    let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    addImageAD.image = image
    
    self.addImageAD.image  = selectedImage
    guard let imagData = selectedImage.pngData() else {
      return
    }
    guard let currentUser  = user else  {return}
    let imageName = currentUser.uid
    
    storage.child("imagesAD/\(imageName).png").putData(imagData,
                                             metadata: nil,
                                             completion: { _, error in
      
      guard error == nil else {
        print ("Fieled")
        return
      }

      self.dismiss(animated: true, completion: nil)

    })
  }
  
}
