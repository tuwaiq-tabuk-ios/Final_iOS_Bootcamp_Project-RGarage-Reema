//
//  Welcome.swift
//  FinalReema
//
//  Created by Reema Mousa on 03/05/1443 AH.
//

import UIKit
import Firebase

class StartVC: UIViewController {
  
  var singUpButton: UIButton = {
    
    let signUpButton = UIButton()
    
    signUpButton.backgroundColor = .systemYellow
    signUpButton.setTitleColor(.black
                               , for: .normal)
    
    signUpButton.setTitle("SignUp"
                          , for: .normal)
    
    signUpButton.titleLabel?.font = UIFont(name: "Trebuchet MS"
                                           , size:24 )
    
    signUpButton.layer.cornerRadius = 10
    return signUpButton
  }()
  

  var signInButton: UIButton = {
    let signInButton = UIButton()
    signInButton.backgroundColor = .systemYellow
    signInButton.setTitleColor(.black
                               , for: .normal)
    signInButton.setTitle("Login"
                          , for: .normal)
    signInButton.titleLabel?.font = UIFont(name: "Trebuchet MS"
                                           , size:24 )
    signInButton.layer.cornerRadius = 10
    return signInButton
  }()
  
  
  var image : UIImageView = {
    let Image = UIImageView()
    Image.image = UIImage(named: "Peoplesearch.png")
    return Image
  }()
  
  
  override func viewDidLoad() {
    
    singUpButton.frame = CGRect(x: 22, y: view.frame.height - 300
                                , width: (view.frame.width - 50), height: 49.5)
    
    signInButton.frame = CGRect(x: 22, y: view.frame.height - 200
                               , width: (view.frame.width - 50), height: 49.5)
    
    image.frame =  CGRect(x: 0, y:125, width: view.frame.width, height: 450)
    
    view.addSubview(image)
    view.addSubview(singUpButton)
    view.addSubview(signInButton)
    
    singUpButton.addTarget(self
                           , action: #selector(buttonSignUpPressed(_:))
                           , for: .touchUpInside)
    signInButton.addTarget(self
                          , action: #selector(buttonsignInPressed(_:))
                          , for: .touchUpInside)
    
    singUpButton.setTitle(NSLocalizedString("SignUP"
                                            , comment: ""), for: .normal)
    
    signInButton.setTitle(NSLocalizedString("Signin"
                                            , comment: ""), for: .normal)
   
  
  
  }
  
  
  @objc func buttonSignUpPressed(_ sender: Any) {
    
    let vc = self.storyboard?
      .instantiateViewController(identifier:K
                                  .Storyboard
                                  .signUpVC)
    
    self.view.window?.rootViewController = vc
    self.view.window?.makeKeyAndVisible()
  }
  
  
  @objc func buttonsignInPressed(_ sender: Any) {
    let VC = self.storyboard?
      .instantiateViewController(identifier:K
                                  .Storyboard
                                  .signInVC)
    
    self.view.window?.rootViewController = VC
    self.view.window?.makeKeyAndVisible()
    
  }
}
