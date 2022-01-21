//
//  Welcome.swift
//  FinalReema
//
//  Created by Reema Mousa on 03/05/1443 AH.
//
 
import UIKit
import Firebase

class StartVC: UIViewController {
  

   var loginButton: UIButton = {
    let signUpButton = UIButton()
     signUpButton.backgroundColor = .systemYellow
     signUpButton.setTitleColor(.black, for: .normal)
     signUpButton.setTitle("SignUp", for: .normal)
     signUpButton.layer.cornerRadius = 10
     signUpButton.titleLabel?.font = UIFont(name: "Trebuchet MS", size:24 )
    return signUpButton
  }()
  
  var singUpButton: UIButton = {
    let signInButton = UIButton()
    signInButton.backgroundColor = .systemYellow
    signInButton.setTitleColor(.black, for: .normal)
    signInButton.setTitle("Login", for: .normal)
    signInButton.layer.cornerRadius = 10
    signInButton.titleLabel?.font = UIFont(name: "Trebuchet MS", size:24 )
      return signInButton
  }()
  
  
  var image : UIImageView = {
    let Image = UIImageView()
    Image.image = UIImage(named: "Peoplesearch.png")
    return Image
  }()
  
  
  override func viewDidLoad() {
    
    view.backgroundColor = .white
    singUpButton.frame = CGRect(x: 22, y: view.frame.height - 300, width: (view.frame.width - 50), height: 49.5)
    loginButton.frame = CGRect(x: 22, y: view.frame.height - 200, width: (view.frame.width - 50), height: 49.5)
    
    image.frame =  CGRect(x: 0, y:125, width: view.frame.width, height: 450)
    
    view.addSubview(image)
    view.addSubview(singUpButton)
    view.addSubview(loginButton)
    
    singUpButton.addTarget(self, action: #selector(buttonSignUp(_:)), for: .touchUpInside)
    loginButton.addTarget(self, action: #selector(buttonLoginButton(_:)), for: .touchUpInside)
  }


  @objc func buttonSignUp(_ sender: Any) {

    let VC = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.signInVC)

    self.view.window?.rootViewController = VC
    self.view.window?.makeKeyAndVisible()
  }


  @objc func buttonLoginButton(_ sender: Any) {
    let VC = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.signUpVC)

    self.view.window?.rootViewController = VC
    self.view.window?.makeKeyAndVisible()

  }
}
