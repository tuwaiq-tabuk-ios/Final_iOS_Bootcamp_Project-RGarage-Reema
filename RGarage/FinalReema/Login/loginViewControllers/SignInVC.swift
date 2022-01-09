//
//  signin.swift
//  FinalReema
//
//  Created by Reema Mousa on 03/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInVC: UIViewController {
  var vc = UIViewController()

  @IBOutlet weak var emailSignIn: UITextField!
  @IBOutlet weak var passwordSignIn: UITextField!
  @IBOutlet weak var signinButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    signinButton.layer.cornerRadius = 10
  }
  
  @IBAction func ButtonToSignUp(_ sender: UIButton) {
    vc = self.storyboard?.instantiateViewController(withIdentifier:"SignUp") as! SignUpVC
    vc.modalPresentationStyle = .fullScreen
    present(vc,animated: false, completion: nil)
  }
  
  @IBAction func forgetPasswordButton(_ sender: UIButton) {
    
    vc = self.storyboard?.instantiateViewController(withIdentifier:"ForgetPasswordVC") as! ForgetPasswordVC
    vc.modalPresentationStyle = .fullScreen
    present(vc,animated: false, completion: nil)
  }
  
  
  @IBAction func signInPressed(_ sender: Any) {
    
    let email = emailSignIn.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = passwordSignIn.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // Signing in the user
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
        
      if let error = error {
        let alert =  Service.createAleartController(title: "Error", message: error.localizedDescription)
        self.present(alert,animated: true , completion:  nil)
        
      } else {
            
            let tapbarVC = self.storyboard?.instantiateViewController(identifier: "tapbarVC") as? tapbarVC
            
            self.view.window?.rootViewController = tapbarVC
            self.view.window?.makeKeyAndVisible()
        }
    }
}
  
  
}
