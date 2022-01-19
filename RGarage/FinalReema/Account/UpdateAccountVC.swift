//
//  UpdateAccountVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 13/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Photos

class UpdateAccountVC: UIViewController,
                       UIImagePickerControllerDelegate ,
                       UINavigationControllerDelegate {
  
  // Database
  let db = Firestore.firestore()
  let storage = Storage.storage().reference()
  var imageURL: String?
  var uploading  :Bool = false
 
  
  @IBOutlet weak var nameUpdate: UITextField!
  @IBOutlet weak var emailUpdate: UITextField!
  @IBOutlet weak var updateUserPhoto: UIImageView!
  @IBOutlet weak var numberUserUpdataTF: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUserPhoto.layer.cornerRadius = updateUserPhoto.frame.height/2
    updateUserPhoto.layer.borderWidth = 3
    updateUserPhoto.layer.borderColor = UIColor.lightGray.cgColor
    
    self.numberUserUpdataTF.text = user?.phoneNumber
    self.nameUpdate.text = user?.fullName
    self.emailUpdate.text = user?.email
    
  }

  
  
  @IBAction func changeLanguagButtonpressed(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
  }
  
  // MARK: dismissKeyboard
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    nameUpdate.resignFirstResponder()
    emailUpdate.resignFirstResponder()
    numberUserUpdataTF.resignFirstResponder()
  }
  
  
  @IBAction func BackButtonPressedtoAccountVC(_ sender: UIButton) {
    let tapbarVC = storyboard?.instantiateViewController(identifier:"tapbarVC") as? tapbarVC
    view.window?.rootViewController = tapbarVC
    view.window?.makeKeyAndVisible()
  }
  
  // MARK: LOGOUT USER
  
  @IBAction func logoutUserPressed(_ sender: Any)
  {
    do {
      try  Auth.auth().signOut()
      
      //when user logout go to this page
      let wellcome = self.storyboard?.instantiateViewController(identifier: "Wellcome") as? Welcome
      self.view.window?.rootViewController = wellcome
      //self.view.window?.makeKeyAndVisible()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }
  
  // MARK: update user Information
  
  @IBAction func PressedupdatInfoUser(_ sender: UIButton) {
    
    // validate fields
    if uploading == true {return}
    
    user.email = emailUpdate.text!
    user.phoneNumber = numberUserUpdataTF.text!
    user.fullName = nameUpdate.text!
    user.imgURL = imageURL
    
    do {
      try db.collection("users").document(user.docID!).setData(from: user, merge: true) { error in
        if let error = error {
          fatalError(error.localizedDescription)
        }
        // updated
        let alert =  Service.createAleartController(title: "Done"
                                                    , message:" successfully updated your profile.")
        self.present(alert,animated: true , completion:  nil)
        print("Document successfully updated")
      }
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  
  @IBAction func updateUserPhotoButton(_ sender: Any) {
    
    let addImge = UIImagePickerController()
    addImge.sourceType = .photoLibrary
    addImge.delegate = self
    addImge.allowsEditing = true
    
    let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Add Photo")
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("Access is granted by user")
                self.present(addImge, animated: true, completion: nil)
            }
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    DispatchQueue.main.async {
                      self.present(addImge, animated: true, completion: nil)
                    }
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
            goToSetting()
        case .denied:
            // same same
            print("Text tapped...")
            goToSetting()
            print("User has denied the permission.")
        case .limited:
            goToSetting() // the function show an alert to enable Authorization manually
            print("User has denied the permission.")
        @unknown default:
            fatalError()
        }
  }


  fileprivate func goToSetting() {
      let title = "Oooooops!"
      let message = "Hi man, for use this App press Go To settings and enabled access to Pohto Gallery... Check read and write option and relaunch the App!"
      
      let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
      
      let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
      subview.backgroundColor = UIColor(white: 0, alpha: 0.2)
      
      alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .heavy),NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
      alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular),NSAttributedString.Key.foregroundColor : UIColor.white]), forKey: "attributedMessage")
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
          print("Action cancelled")
      }
      
      let goToSettingPermission = UIAlertAction(title: "Go To setting", style: .default) { (action) in
          UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
      }
      
      alertController.addAction(goToSettingPermission)
      alertController.addAction(cancelAction)
      
      self.present(alertController, animated: true, completion: {
      })
  }
  
  // MARK: update user photo
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
  ) {
    uploading  = true
    guard let selectedImage =
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
    
    self.updateUserPhoto.image  = selectedImage
    guard let jpegData = selectedImage.jpegData(compressionQuality: 0.25) else { return }
    
    guard let currentUser  = user else  {return}
    let imageName = currentUser.uid
    let ref = storage.child("images/\(imageName).png")
    
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
}
