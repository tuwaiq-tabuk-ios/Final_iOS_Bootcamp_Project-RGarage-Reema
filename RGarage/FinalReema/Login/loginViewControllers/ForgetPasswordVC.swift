//
//  ForgetPasswordVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 15/05/1443 AH.
//

import UIKit
import FirebaseAuth
class ForgetPasswordVC: UIViewController {
  
  
  var vc = UIViewController()
  
  @IBOutlet weak var emailResetPasswordTF: UITextField!
  
  @IBOutlet weak var sendButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
    sendButton.layer.cornerRadius = 10
    
    }
    
  @IBAction func sendButtonTOCheck(_ sender: UIButton) {
    let auth = Auth.auth()
    
    auth.sendPasswordReset(withEmail: emailResetPasswordTF.text!){ [self](error) in
      if let error = error {
        let alert =  Service.createAleartController(title: "Error", message: error.localizedDescription)
        self.present(alert,animated: true , completion:  nil)
        return
      } else {
        self.vc = self.storyboard?.instantiateViewController(withIdentifier:"CheckEmailVC") as! CheckEmailVC
        self.vc.modalPresentationStyle = .fullScreen
        present(vc,animated: false, completion: nil)
      }

    }
  }
  
}
