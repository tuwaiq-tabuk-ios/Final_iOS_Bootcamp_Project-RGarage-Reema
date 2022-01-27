//
//  Sign Up.swift
//  FinalReema
//
//  Created by Reema Mousa on 03/05/1443 AH.
//

import UIKit
import Firebase


class SignUpVC: UIViewController
, UINavigationControllerDelegate {
  
  //variable password hidden and show
  var iconeClick = false
  var imageicone = UIImageView()
  
  @IBOutlet weak var nameUserSignUpTF: UITextField!
  @IBOutlet weak var emailUserSignUpTF: UITextField!
  @IBOutlet weak var passwordUserSignUpTF: UITextField!
  @IBOutlet weak var confirmPassUserSignUpTF: UITextField!
  @IBOutlet weak var phoneNumberUserSignUpTF: UITextField!
  @IBOutlet weak var signUpButton : UIButton!
  @IBOutlet weak var signInButton : UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    passwordshowAndHidden()
    //border btn
    signUpButton.layer.cornerRadius = 10
    
    //MARK: Localizable buttons
    signInButton.setTitle(NSLocalizedString("Signin"
                                            , comment: ""), for: .normal)
    signUpButton.setTitle(NSLocalizedString("SignUP"
                                            , comment: ""), for: .normal)
  }
  
  
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    
    nameUserSignUpTF.resignFirstResponder()
    emailUserSignUpTF.resignFirstResponder()
    passwordUserSignUpTF.resignFirstResponder()
    confirmPassUserSignUpTF.resignFirstResponder()
    phoneNumberUserSignUpTF.resignFirstResponder()
    
  }
  
  
  @IBAction func ButtonToSignIn(_ sender: UIButton) {
    
    let VC = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.signInVC)
    
    self.view.window?.rootViewController = VC
    self.view.window?.makeKeyAndVisible()
  }
  
  //MARK: validateFields
  
  func validateFields () -> String? {
    
    if nameUserSignUpTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailUserSignUpTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        phoneNumberUserSignUpTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordUserSignUpTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        confirmPassUserSignUpTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
      
      let alert =  Service.createAlertController(title: "Error"
                                                  , message:"Please fill in all fields.")
      
      alert.title = NSLocalizedString("Error", comment: "")
      alert.message = NSLocalizedString("Please fill in all fields..", comment: "")
      self.present(alert,animated: true , completion:  nil)
    }
    
    let cleanedPassword = passwordUserSignUpTF.text!
      .trimmingCharacters(in: .whitespacesAndNewlines)
    
    if K.Password.isPasswordValid(cleanedPassword) == false  {
      let alert =  Service.createAlertController(title: "Error"
                                                  , message:"Please make sure your password is at least 8 characters, contains a special character and a number.")
      
      alert.title = NSLocalizedString("Error"
                                      , comment: "")
      alert.message = NSLocalizedString("Please make sure your password is at least 8 characters, contains a special character and a number."
                                     , comment: "")
      self.present(alert,animated: true
                   , completion:  nil)
      
    }
    return nil
  }
  
  //MARK: firebase signup
  @IBAction func signUpTapped(_ sender: Any) {
    //firebase signup
    
    let textFieldSignUP = validateFields()
    if textFieldSignUP != nil {
    }
    
    else {
      let fullName = nameUserSignUpTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let email = emailUserSignUpTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let password = passwordUserSignUpTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let confirmPass = confirmPassUserSignUpTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let phoneNumber  = phoneNumberUserSignUpTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      
      if confirmPass == password {
        Auth
          .auth()
          .createUser(withEmail: email, password: password ){ (authDataResult, err) in
            
            if err != nil {
              let alert =  Service.createAlertController(title: "Error"
                                                          , message:"Erro in Email")
              
              alert.title = NSLocalizedString("Error"
                                              , comment: "")
              alert.message = NSLocalizedString("Erro in Email"
                                                , comment: "")
              
              self.present(alert,animated: true , completion:  nil)
              print("Error creating user" )
              
            } else {
              
              let id = Auth
                .auth()
                .currentUser?.uid
              
              let userModel = UserModel(uid: id!,
                                        email: email,
                                        fullName: fullName,
                                        phoneNumber: phoneNumber)
              
              do {
                self.startLoading()
                try db
                  .collection("users")
                  .addDocument(from: userModel) { error in
                    self.stopLoading()
                    if error != nil {
                      print("Error saving user data")
                    }
                    self.tapbarVC()
                  }
              } catch {
                fatalError(error.localizedDescription)
              }
              
            }
          }
      }else{
        let alert = Service
          .createAlertController(title: "Error"
                                  , message: "password not match")
        
        alert
          .title = NSLocalizedString("Error", comment: "")
        
        alert
          .message = NSLocalizedString("password not match"
                                       , comment: "")
        
        self.present(alert,animated: true , completion:  nil)
        
      }
    }
  }
  
  //MARK: segue to tapbarVC
  func tapbarVC() {
    
    let vc = self.storyboard?
      .instantiateViewController(identifier:K
                                  .Storyboard
                                  .tapbarVC)
    self
      .view
      .window?
      .rootViewController = vc
    
    self.view.window?.makeKeyAndVisible()
  }
  
  //MARK: show and hidden password
  func passwordshowAndHidden(){
    imageicone.image = UIImage(named: "hidden")
    let contectView = UIView()
    contectView.addSubview(imageicone)
    
    contectView.frame = CGRect(x: 0
                               , y: 0
                               , width: UIImage(named: "hidden")!.size.width
                               , height: UIImage(named: "hidden")!.size.height)

    imageicone.frame = CGRect(x: 2
                              , y: 0
                              , width: UIImage(named: "hidden")!.size.width
                              , height: UIImage(named: "hidden")!.size.height)
    
    passwordUserSignUpTF
      .rightView  = contectView
    
    passwordUserSignUpTF
      .rightViewMode = .always
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self
                                                      , action: #selector(imagTapped(tapGestureRecognizer:)))
    imageicone.isUserInteractionEnabled = true
    imageicone.addGestureRecognizer(tapGestureRecognizer)
  }

  @objc func imagTapped(tapGestureRecognizer:UITapGestureRecognizer){
    let tappedImage = tapGestureRecognizer
      .view as! UIImageView
    
    if iconeClick {
      iconeClick = false
      tappedImage.image = UIImage(named: "view")
      passwordUserSignUpTF.isSecureTextEntry = false
    }else{
      
      iconeClick = true
      tappedImage.image = UIImage(named: "hidden")
      passwordUserSignUpTF.isSecureTextEntry = true
    }
  }
}
