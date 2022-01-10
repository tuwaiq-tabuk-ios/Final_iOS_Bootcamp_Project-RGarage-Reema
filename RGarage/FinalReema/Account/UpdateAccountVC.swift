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


class UpdateAccountVC: UIViewController,
                       UIImagePickerControllerDelegate ,
                       UINavigationControllerDelegate {
  
  // Database
  let db = Firestore.firestore()
  let user = Auth.auth().currentUser
  let storage = Storage.storage().reference()
  let profileImagesRef = Storage.storage().reference().child("images/")
  
//variabls
  var userFullNameUPdate : String = ""
  var userEmailUPdate : String = ""
  var userPasswordUPdate: String = ""
  var userConfirmPasswordUPdate : String = ""
  var userImageUPdate = UIImage()
  var phoneNumber : String = ""
  
  var iconeClick = false
  var imageicone = UIImageView()
  
  @IBOutlet weak var nameUpdate: UITextField!
  @IBOutlet weak var emailUpdate: UITextField!
  @IBOutlet weak var passwordUpdate: UITextField!
  @IBOutlet weak var confirmPasswordUpdate: UITextField!
  @IBOutlet weak var updateUserPhoto: UIImageView!
  @IBOutlet weak var numberUserUpdataTF: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUserPhoto.layer.cornerRadius = updateUserPhoto.frame.height/2
    updateUserPhoto.layer.borderWidth = 3
    updateUserPhoto.layer.borderColor = UIColor.lightGray.cgColor
    
    //hidden and shaow password
    imageicone.image = UIImage(named: "hidden")
    let contectView = UIView()
    contectView.addSubview(imageicone)
    contectView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "hidden")!.size.width, height: UIImage(named: "hidden")!.size.height)

    imageicone.frame = CGRect(x: -10, y: 0, width: UIImage(named: "hidden")!.size.width, height: UIImage(named: "hidden")!.size.height)

    passwordUpdate.rightView  = contectView
    passwordUpdate.rightViewMode = .always
    
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imagTapped(tapGestureRecognizer:)))
    imageicone.isUserInteractionEnabled = true
    imageicone.addGestureRecognizer(tapGestureRecognizer)

  }
  
  @objc func imagTapped(tapGestureRecognizer:UITapGestureRecognizer){
    let tappedImage = tapGestureRecognizer.view as! UIImageView
    if iconeClick {
      iconeClick = false
      tappedImage.image = UIImage(named: "view")
      passwordUpdate.isSecureTextEntry = false
 
    }
    else {
      iconeClick = true
      tappedImage.image = UIImage(named: "hidden")
      passwordUpdate.isSecureTextEntry = true
     
    }
  }

   

  // MARK: Show user Information in update VC
  override func viewWillAppear(_ animated: Bool) {
    
    if let currentUser  = user {
      db.collection("users").document(currentUser.uid).getDocument { doc , err in
        if err != nil {
          print(err!)
        }
        else{
          let data = doc!.data()!
          
          self.userFullNameUPdate  = data["FullName"] as! String
          self.userEmailUPdate = (self.user?.email)!
          self.userPasswordUPdate = data["Password"] as! String
          self.phoneNumber = data["PhoneNumber"] as! String
          
          print("**********DATA :  \(data)")
          
          self.numberUserUpdataTF.text = self.phoneNumber
          self.nameUpdate.text = self.userFullNameUPdate
          self.emailUpdate.text = self.userEmailUPdate
          self.passwordUpdate.text = self.userPasswordUPdate
          self.confirmPasswordUpdate.text = self.userPasswordUPdate
          
        }
        
      }
    }
    
  }
 
  
  // MARK: LOGOUT USER
  
  @IBAction func logoutUserPressed(_ sender: Any)
  {
    do {
      try  Auth.auth().signOut()
      
      //when user logout go to this page
      let wellcome = self.storyboard?.instantiateViewController(identifier: "Wellcome") as? Wellcome
      self.view.window?.rootViewController = wellcome
      //self.view.window?.makeKeyAndVisible()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }
  
  // MARK: update user Information
  @IBAction func PressedupdatInfoUser(_ sender: UIButton) {
    if let user  = user{
    Auth.auth().currentUser?.updateEmail(to: emailUpdate.text!) { [self] error in
      if error == nil{
        let ref = db.collection("users").document(Auth.auth().currentUser!.uid)
        ref.updateData(["email": emailUpdate.text!,"FullName":nameUpdate.text! ,"PhoneNumber": numberUserUpdataTF.text! ,"Password": passwordUpdate.text!,]) { err in
          if let err = err {
            print("Error updating document: \(err)")
          } else {
            print("Document successfully updated")
          }
        }
        
      }
    }}else{
    let alert =  Service.createAleartController(title: "Error", message: "successfully updated ")
    self.present(alert,animated: true , completion:  nil)
    }}
 
  // MARK: update user photo
  //for upload user photo
  
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
    guard let selectedImage =
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
              return
            }
    
    let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    updateUserPhoto.image = image
    
    self.updateUserPhoto.image  = selectedImage
    guard let imagData = selectedImage.pngData() else {
      return
    }
    guard let currentUser  = user else  {return}
    let imageName = currentUser.uid
    
    storage.child("images/\(imageName).png").putData(imagData,
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
