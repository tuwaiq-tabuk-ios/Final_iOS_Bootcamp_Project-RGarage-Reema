//
//  WelcomeVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 17/06/1443 AH.
//

import Foundation
import UIKit
class SplashVC : UIViewController{
  
  @IBOutlet weak var thinkingLabel: UILabel!
  @IBOutlet weak var ourAppLabel: UILabel!
  
  override func viewDidLoad() {
    thinkingLabel.text = NSLocalizedString("Thinking where to put your car?", comment: "")
    ourAppLabel.text = NSLocalizedString("Our app meets your needs...", comment: "")
  }
}
