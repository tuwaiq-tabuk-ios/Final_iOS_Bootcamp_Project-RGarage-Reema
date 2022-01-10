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
  var userPhone : String = ""
  var userPassword: String = ""
  var userConfirmPassword : String = ""
  
  //data
  var vc = UIViewController()
  //for uoload photo for firebase
  let storage = Storage.storage().reference()
  
  
  var iconeClick = false
  var imageicone = UIImageView()
  
  @IBOutlet weak var nameUserSignUpTF: UITextField!
  @IBOutlet weak var emailUserSignUpTF: UITextField!
  @IBOutlet weak var passwordUserSignUpTF: UITextField!
  @IBOutlet weak var confirmPassUserSignUpTF: UITextField!
  @IBOutlet weak var phoneNumberUserSignUpTF: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
pass()
  }
  
  func pass(){
    imageicone.image = UIImage(named: "hidden")
    let contectView = UIView()
    contectView.addSubview(imageicone)
    contectView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "hidden")!.size.width, height: UIImage(named: "hidden")!.size.height)
    
    imageicone.frame = CGRect(x: -10, y: 0, width: UIImage(named: "hidden")!.size.width, height: UIImage(named: "hidden")!.size.height)
    
    passwordUserSignUpTF.rightView  = contectView
    passwordUserSignUpTF.rightViewMode = .always

    
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imagTapped(tapGestureRecognizer:)))
    imageicone.isUserInteractionEnabled = true
    imageicone.addGestureRecognizer(tapGestureRecognizer)
    
  }
  
  
  @objc func imagTapped(tapGestureRecognizer:UITapGestureRecognizer){
    let tappedImage = tapGestureRecognizer.view as! UIImageView
    if iconeClick {
      iconeClick = false
      tappedImage.image = UIImage(named: "view")
      passwordUserSignUpTF.isSecureTextEntry = false
     }
    
    else {
      iconeClick = true
      tappedImage.image = UIImage(named: "hidden")
      passwordUserSignUpTF.isSecureTextEntry = true
    }
    
  }
  
  @IBAction func ButtonToSignIn(_ sender: UIButton) {
    vc = self.storyboard?.instantiateViewController(withIdentifier:"SignIn") as! SignInVC
    vc.modalPresentationStyle = .fullScreen
    present(vc,animated: false, completion: nil)
  }
  
  
  func validateFields () -> String? {
    if nameUserSignUpTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailUserSignUpTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        phoneNumberUserSignUpTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordUserSignUpTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        confirmPassUserSignUpTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
      
      let alert =  Service.createAleartController(title: "Error"
                                                  , message:"Please fill in all fields.")
      self.present(alert,animated: true , completion:  nil)
    }
    
    let cleanedPassword = passwordUserSignUpTF.text!
      .trimmingCharacters(in: .whitespacesAndNewlines)
    
    if K.isPasswordValid(cleanedPassword) == false  {
      let alert =  Service.createAleartController(title: "Error"
                                                  , message:"Please make sure your password is at least 8 characters, contains a special character and a number.")
      
      
      self.present(alert,animated: true , completion:  nil)
      
    }
    return nil
  }
  
  
  @IBAction func signUpTapped(_ sender: Any) {
    
    userFullName = nameUserSignUpTF.text!
    print("**userFullName:\(userFullName)\n")
    userEmail = emailUserSignUpTF.text!
    print("**userEmail:\(userEmail)\n")
    userPhone = phoneNumberUserSignUpTF.text!
    print("**userEmail:\(userPhone)\n")
    userPassword = passwordUserSignUpTF.text!
    print("**userPassword:\(userPassword)\n")
    userConfirmPassword = confirmPassUserSignUpTF.text!
    print("**userConfirmPassword:\(userConfirmPassword)\n")
    
    
    //firebase signup
    let error = validateFields()
    if error != nil {
      
    }
    else {
      let fullName = nameUserSignUpTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let email = emailUserSignUpTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let password = passwordUserSignUpTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let confirmPass = confirmPassUserSignUpTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let phoneNumber  = phoneNumberUserSignUpTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      
      if confirmPass == password {
        
        Auth.auth().createUser(withEmail: email, password: password )  { (result, err) in
          if err != nil {
            
            let alert =  Service.createAleartController(title: "Error", message: "Error creating user")
            self.present(alert,animated: true , completion:  nil)
            
            
          }else {
            
            
            let db = Firestore.firestore()
            let id = Auth.auth().currentUser?.uid
            db.collection("users").document(id!).setData(["FullName":fullName,
                                                          "Email" :email ,
                                                          "Password":password,
                                                          "PhoneNumber": phoneNumber,
                                                          "uid": result!.user.uid ]) { (error) in
              
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
  
  func transitionToHome() {
    let tapbarVC = storyboard?.instantiateViewController(identifier:"tapbarVC") as? tapbarVC
    view.window?.rootViewController = tapbarVC
    view.window?.makeKeyAndVisible()
  }
  
}
