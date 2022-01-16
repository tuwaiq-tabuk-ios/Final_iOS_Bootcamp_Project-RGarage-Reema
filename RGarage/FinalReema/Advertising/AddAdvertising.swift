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
, UINavigationControllerDelegate {
  
  
  // Database
  let db = Firestore.firestore()
  let user = Auth.auth().currentUser
  let storage = Storage.storage().reference()
   
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
  
  // MARK: dismissKeyboard
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    priceAD.resignFirstResponder()
    addressAD.resignFirstResponder()
  }
  
  @IBAction func btnAddAdvertising(_ sender: Any) {
    if let addressUserD = addressAD.text,
       let priceUserD = priceAD.text,
       let  userLogin = Auth.auth().currentUser?.email {
       let id = Auth.auth().currentUser?.uid

      var dataInfo :DocumentReference? = nil
      dataInfo =  db.collection("Advertising").addDocument(data: [

        "lessor": userLogin,
        "lessorAddress" : addressUserD ,
        "pricelessor" : priceUserD,
        "lessorID" : id! ,
        "Date" : (DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .medium))  as String   ]) {(error)in
          
        if let err = error {
          print(err)
        }
        else{
          guard let imagData = self.addImageAD?.image?.pngData() else {
            return
          }
          let imageName = dataInfo!.documentID
          self.storage.child("imagesAD/\(imageName).png").putData(imagData,
                                                             metadata: nil,
                                                             completion: { _, error in
            guard error == nil else {
              print ("Fieled")
              return
            }
            
            DispatchQueue.main.async {
              self.addressAD.text = ""
              self.priceAD.text = ""
            }
          })
        }
      }
    }
    
    
    let tapbar = storyboard?.instantiateViewController(withIdentifier: "tapbarVC") as! tapbarVC
    present(tapbar, animated: true, completion: nil)
  }
  

  @IBAction func addphotoButon(_ sender: Any) {
    
    presentPhotoActionSheet()
  }
}


extension AddAdvertising : UIImagePickerControllerDelegate {
  func presentPhotoActionSheet(){
    
    let actionSheet = UIAlertController(
      title: "Advertising Picture",
      message: "How would you like to select a picture",
      preferredStyle: .actionSheet)
     actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: {[weak self] _ in
      self?.presenCamera()
    } ))
    actionSheet.addAction(UIAlertAction(title: "Chose Photo", style: .default, handler: {[weak self ] _ in
      self?.presentPhotoPicker()
    }))
    present(actionSheet , animated: true)
  }
  
  func presenCamera (){
    let addImge = UIImagePickerController()
    addImge.sourceType = .camera
    addImge.delegate = self
    addImge.allowsEditing = true
    present(addImge, animated: true)
  }
  
  
  func presentPhotoPicker(){
    let addImge = UIImagePickerController()
    addImge.sourceType = .photoLibrary
    addImge.delegate = self
    addImge.allowsEditing = true
    present(addImge, animated: true)
  }
  

  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info:
                             [UIImagePickerController.InfoKey : Any]) {
    
    picker.dismiss(animated: true, completion: nil)
    guard let selectedImage =
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
      return
    }
    self.addImageAD.image  = selectedImage
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
}
