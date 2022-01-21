//
//  CheckEmailVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 15/05/1443 AH.
//

import UIKit

class CheckEmailVC: UIViewController {

  @IBOutlet weak var backToLoogin: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
backToLoogin.layer.cornerRadius = 10
    }
    

  @IBAction func bacToLoginPressed(_ sender: UIButton) {
   
    let VC = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.signInVC)
    
    self.view.window?.rootViewController = VC
    self.view.window?.makeKeyAndVisible()

  }
}
