//
//  Sign Up.swift
//  FinalReema
//
//  Created by Reema Mousa on 03/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class SignUpVC: UIViewController
, UINavigationControllerDelegate {
  
  //variable
  var userFullName : String = ""
  var userEmail : String = ""
  var userPassword: String = ""
  var userConfirmPassword : String = ""
  var userImage = UIImage()
  

  var vc = UIViewController()
  //for uoload photo for firebase
  let storage = Storage.storage().reference()
  
  @IBOutlet weak var nameUserSignUp: UITextField!
  @IBOutlet weak var emailUserSignUp: UITextField!
  @IBOutlet weak var passwordUserSignUp: UITextField!
  @IBOutlet weak var confirmPassUserSignUp: UITextField!
  @IBOutlet weak var userPhoto: UIImageView!
  @IBOutlet weak var UserSignUpButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userPhoto.layer.cornerRadius = userPhoto.frame.height/2
    userPhoto.layer.borderWidth = 3
    userPhoto.layer.borderColor = UIColor.lightGray.cgColor
  }
  
  
  @IBAction func ButtonToSignIn(_ sender: UIButton) {
    vc = self.storyboard?.instantiateViewController(withIdentifier:"SignIn") as! SignInVC
    vc.modalPresentationStyle = .fullScreen
    present(vc,animated: false, completion: nil)
  }
  
  
  func validateFields () -> String? {
    if nameUserSignUp.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailUserSignUp.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordUserSignUp.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        confirmPassUserSignUp.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
      
      let alert =  Service.createAleartController(title: "Error"
                                                  , message:"Please fill in all fields.")
      self.present(alert,animated: true , completion:  nil)
    }
    
    let cleanedPassword = passwordUserSignUp.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    if K.isPasswordValid(cleanedPassword) == false  {
      let alert =  Service.createAleartController(title: "Error"
                                                  , message:"Please make sure your password is at least 8 characters, contains a special character and a number.")
      
      self.present(alert,animated: true , completion:  nil)
      
    }
    return nil
  }
  
  
  @IBAction func signUpTapped(_ sender: Any) {
 
    userImage = userPhoto.image!
    print("**userImage:\(userImage)\n")
    userFullName = nameUserSignUp.text!
    print("**userFullName:\(userFullName)\n")
    userEmail = emailUserSignUp.text!
    print("**userEmail:\(userEmail)\n")
    userPassword = passwordUserSignUp.text!
    print("**userPassword:\(userPassword)\n")
    userConfirmPassword = confirmPassUserSignUp.text!
    print("**userConfirmPassword:\(userConfirmPassword)\n")
    
//    self.performSegue(withIdentifier: "toUPdateUserinfo", sender: self)
//    self.performSegue(withIdentifier: "toAccountUser", sender: self)
    
    
    //firebase signup
    let error = validateFields()
    if error != nil {
      
    }
    else {
      let fulNmae = nameUserSignUp.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let email = emailUserSignUp.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let password = passwordUserSignUp.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let confirmPass = confirmPassUserSignUp.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      
      if confirmPass == password{
        
        Auth.auth().createUser(withEmail: email, password: password )  { (result, err) in
          if err != nil {
            
            let alert =  Service.createAleartController(title: "Error", message: "Error creating user")
            self.present(alert,animated: true , completion:  nil)
            
            
          }else {
            let db = Firestore.firestore()
            db.collection("users").addDocument(data: ["fulNmae":fulNmae, "Email" :email , "password":password
                                                      , "uid": result!.user.uid ]) { (error) in
              
              if error != nil {
                // Show error message
                let alert =  Service.createAleartController(title: "Error"
                                                            , message: "Error saving user data"
                )
                self.present(alert,animated: true , completion:  nil)
              }
            }
            // Transition to the home screen
            self.transitionToHome()
         
          }
    
        }
      } else{
        let alert =  Service.createAleartController(title: "Error", message: "password not mach"
        )
        self.present(alert,animated: true , completion:  nil)
      }
    }
      
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc = segue.destination as? UpdateAccountVC
    vc?.userImageUPdate = userImage
    vc?.userFullNameUPdate = userFullName
    vc?.userEmailUPdate = userEmail
    vc?.userPasswordUPdate = userPassword
    vc?.userConfirmPasswordUPdate = userConfirmPassword
    
    let accountVC = segue.destination as? AccountVC
    accountVC?.userName = userFullName
    accountVC?.avatar = userImage
    
  }
  
  func transitionToHome() {
    let tapbarVC = storyboard?.instantiateViewController(identifier:"tapbarVC") as? tapbarVC
    view.window?.rootViewController = tapbarVC
    view.window?.makeKeyAndVisible()
  }
  
  
  
  
  //button for user add photo from library
  @IBAction func userPhotoButton(_ sender: Any) {
    
    presentPhotoActionSheet()
  }
}
extension SignUpVC : UIImagePickerControllerDelegate {
  func presentPhotoActionSheet(){
    let actionSheet = UIAlertController(
      title: "Profile Picture",
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
    self.userPhoto.image  = selectedImage
    guard let imagData = selectedImage.pngData() else {
      return
    }
    storage.child("images/file.png").putData(imagData,
                                             metadata: nil,
                                             completion: { _, error in
      
      guard error == nil else {
        print ("Fieled")
        return
      }
      self.storage.child("images/file.png").downloadURL(completion: {url, error in
        guard let url = url, error == nil else {
          return
        }
        
        let urlString = url.absoluteString
        print("Download URL : \(urlString) ")
        UserDefaults.standard.set(urlString, forKey: "url")
        
      })
    })
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
}
