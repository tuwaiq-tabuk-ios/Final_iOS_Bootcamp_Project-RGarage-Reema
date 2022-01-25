//
//  Add advertisingViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 11/05/1443 AH.
//

import UIKit
import Firebase

class AddAdvertisingVC : UIViewController
, UINavigationControllerDelegate {

  var uploading  :Bool = false
  var imageURL: String?
  
  @IBOutlet weak var imageView: UIView!
  @IBOutlet weak var addImageAD: UIImageView!
  @IBOutlet weak var addressAD: UITextField!
  @IBOutlet weak var priceAD: UITextField!
  @IBOutlet weak var btnAddAdvertising: UIButton!
  @IBOutlet weak var BasicView: UIView!
  @IBOutlet weak var AddPhotoForGarage:UIButton!
  
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
    //buttons
    btnAddAdvertising.layer.cornerRadius = 10
    AddPhotoForGarage.layer.cornerRadius = 10
    
  }
  
  // MARK: dismissKeyboard
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    priceAD.resignFirstResponder()
    addressAD.resignFirstResponder()
  }
  
  @IBAction func btnAddAdvertising(_ sender: Any) {
    
    if let addressUserD = addressAD.text,
       let priceUserD = priceAD.text, let price = Double(priceUserD) {
      
      let adModel = AdModel(id: UUID().uuidString,
                            userID: user.uid,
                            price: price,
                            address: addressUserD,
                            date: Date(),
                            imageURL: imageURL)
      
      //      advertisements
      do {
        try db
          .collection("advertisements")
          .addDocument(from: adModel) { error in
          if let error = error {
            fatalError(error.localizedDescription)
          }
          // alert
          let alert =  Service.createAlertController(title: "Done"
                                                      ,message:"Your advertising has been uploaded successfully.")
          alert.title = NSLocalizedString("Done", comment: "")
          alert.message = NSLocalizedString("Youradvertisinghasbeenuploadedsuccessfully.", comment: "")
          self.present(alert,animated: true , completion:  nil)

          self.addressAD.text = ""
          self.priceAD.text = ""

          let tapbar = self.storyboard?
              .instantiateViewController(withIdentifier: "TapbarVC") as! TapbarVC
          self.present(tapbar, animated: true, completion: nil)
        }
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  @IBAction func addphotoButon(_ sender: Any) {
    presentPhotoActionSheet()
  }
}


extension AddAdvertisingVC : UIImagePickerControllerDelegate {
  
  
  func presentPhotoActionSheet(){
    let actionSheet = UIAlertController(
      title: "Advertising Picture",
      message: "How would you like to select a picture",
      preferredStyle: .actionSheet)
    
    actionSheet.addAction(UIAlertAction(title: "Cancel"
                                        , style: .cancel
                                        , handler: nil))
    
    actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default
                                        , handler: {[weak self] _ in
      self?.presenCamera()
      
    }))
    actionSheet.addAction(UIAlertAction(title: "Chose Photo"
                                        , style: .default, handler: {[weak self ] _ in
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
    
    uploading  = true
    guard let selectedImage =
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
    
    self.addImageAD.image  = selectedImage
    
    guard let jpegData = selectedImage.jpegData(compressionQuality: 0.25) else { return }
    
    let ref = storageImage.child("images/\(UUID().uuidString).png")
    
    ref.putData(jpegData, metadata: nil, completion: { meta, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      
      if let metadata = meta {
        ref.downloadURL { url, error in
          if let error = error {
            fatalError(error.localizedDescription)
          }
          guard let url = url else { return }
          self.imageURL = url.absoluteString
          self.uploading = false
          
        }
      }
    }) 
    self.dismiss(animated: true, completion: nil)
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}
