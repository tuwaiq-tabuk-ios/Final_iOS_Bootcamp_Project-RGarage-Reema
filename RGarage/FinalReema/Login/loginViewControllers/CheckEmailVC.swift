//
//  CheckEmailVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 15/05/1443 AH.
//

import UIKit

class CheckEmailVC: UIViewController {
var vc = UIViewController()
  @IBOutlet weak var backToLoogin: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
backToLoogin.layer.cornerRadius = 10
    }
    

  @IBAction func bacToLoginPressed(_ sender: UIButton) {
    vc = storyboard?.instantiateViewController(withIdentifier:"SignIn" ) as! SignInVC
    vc.modalPresentationStyle = .fullScreen
    present(vc,animated: false, completion: nil)
    
  }
}
