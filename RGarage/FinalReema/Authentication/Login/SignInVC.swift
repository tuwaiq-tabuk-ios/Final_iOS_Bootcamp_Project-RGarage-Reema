//
//  signin.swift
//  FinalReema
//
//  Created by Reema Mousa on 03/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class SignInVC: UIViewController ,UITextFieldDelegate {
  
  var iconeClick = false
  var imageicone = UIImageView()
  
  @IBOutlet weak var emailSignInTF: UITextField!
  @IBOutlet weak var passwordSignInTF: UITextField!
  @IBOutlet weak var signinButton: UIButton!
  @IBOutlet weak var dontHaveAccountLabel: UILabel!
  @IBOutlet weak var signUpButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    passwordshowAndHiddenSignIn()
    
    signinButton.layer.cornerRadius = 10
    
    // for  Localizable
     signUpButton.setTitle(NSLocalizedString("SignUP"
                                             , comment: "")
                                               , for: .normal)
    signinButton.setTitle(NSLocalizedString("Signin"
                                            , comment: "")
                                              , for: .normal)
     dontHaveAccountLabel.text = NSLocalizedString("Don't have Acount?"
                                                   , comment: "")
  }
  
  
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    
    emailSignInTF.resignFirstResponder()
    passwordSignInTF.resignFirstResponder()

  }
  
  //MARK: VC signup
  @IBAction func ButtonToSignUp(_ sender: UIButton) {
    let vc = self.storyboard?
      .instantiateViewController(identifier:K
                                  .Storyboard
                                  .signUpVC)
    
    self.view.window?.rootViewController = vc
    self.view.window?.makeKeyAndVisible()

  }

  
  //MARK: VC forgetPassword
  @IBAction func forgetPasswordButton(_ sender: UIButton) {
    let vc = self.storyboard?
      .instantiateViewController(identifier:K
                                  .Storyboard
                                  .forgetPasswordVC)
    
    self.view.window?.rootViewController = vc
    self.view.window?.makeKeyAndVisible()
  }
  
  //MARK: signIn withFirebase
  
  @IBAction func signInPressed(_ sender: Any) {
    
    let email = emailSignInTF.text!
      .trimmingCharacters(in: .whitespacesAndNewlines)
    
    let password = passwordSignInTF.text!
      .trimmingCharacters(in: .whitespacesAndNewlines)
    
    Auth
      .auth()
      .signIn(withEmail: email
              , password: password) { (result, error) in
        
      if let error = error {
        let alert =  Service.createAlertController(title: "Error"
                                                    , message: error.localizedDescription)
        self.present(alert,animated: true
                     , completion:  nil)
        
        
      } else {
            // fetch user profile
        guard let id = result?.user.uid else { fatalError() }
        // Signing in the user
        self.startLoading()
        
       db
          .collection("users")
          .whereField("uid", isEqualTo: id)
          .getDocuments { snapshot, error in
            
          if let error = error {
            fatalError(error.localizedDescription)
          }
            
           if let doc = snapshot?.documents.first {
            do {
              try user = doc.data(as: UserModel.self)
              self.stopLoading()
              let tapbarVC = self.storyboard?
                .instantiateViewController(identifier: "TapbarVC") as? TapbarVC
              self.view.window?.rootViewController = tapbarVC
              self.view.window?.makeKeyAndVisible()
              
            }catch {
              fatalError(error.localizedDescription)
            }
          }
        }
      }
    }
  }
  
  //MARK: show and hidden password
  func passwordshowAndHiddenSignIn(){
    imageicone.image = UIImage(named: "hidden")
    let contectView = UIView()
    contectView.addSubview(imageicone)
    
    contectView.frame = CGRect(x: 0
                               , y: 0
                               , width: UIImage(named: "hidden")!
                                .size.width
                               , height: UIImage(named: "hidden")!
                                .size.height)
    imageicone.frame = CGRect(x: 2
                              , y: 0
                              , width: UIImage(named: "hidden")!
                                .size.width, height: UIImage(named: "hidden")!
                                .size.height)
    
    passwordSignInTF.rightView  = contectView
    passwordSignInTF.rightViewMode = .always
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self
                                                      , action: #selector(imagTapped(tapGestureRecognizer:)))
    imageicone.isUserInteractionEnabled = true
    imageicone.addGestureRecognizer(tapGestureRecognizer)
   }

  @objc func imagTapped(tapGestureRecognizer:UITapGestureRecognizer){
    let tappedImage = tapGestureRecognizer.view as! UIImageView
    if iconeClick {
      iconeClick = false
      tappedImage.image = UIImage(named: "view")
      passwordSignInTF.isSecureTextEntry = false
    }
    else {
      iconeClick = true
      tappedImage.image = UIImage(named: "hidden")
      passwordSignInTF.isSecureTextEntry = true
    }
  }
}
