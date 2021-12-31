//
//  ViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 03/05/1443 AH.
//
import Foundation
import UIKit
import Firebase
class Wellcome: UIViewController {
  
 public var ViewC = UIViewController()
  
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var signUPButton: UIButton!

   override func viewDidLoad() {
    super.viewDidLoad()

     signInButton.layer.cornerRadius = 20
     signUPButton.layer.cornerRadius = 20
    }

  @IBAction func WelcomeButtons(_ sender: UIButton) {
    print(#function)

    if sender.tag == 1 {
  
      ViewC = self.storyboard?.instantiateViewController(withIdentifier:"SignIn") as! SignInVC
      ViewC.modalPresentationStyle = .fullScreen
      present(ViewC,animated: false, completion: nil)

     }
    else {
      ViewC = self.storyboard?.instantiateViewController(withIdentifier:"SignUp") as! SignUpVC
      ViewC.modalPresentationStyle = .fullScreen
      present(ViewC,animated: false,completion: nil)
    }
   }
 }

