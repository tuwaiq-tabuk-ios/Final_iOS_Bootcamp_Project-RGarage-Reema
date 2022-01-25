//
//  WelComeViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 14/06/1443 AH.
//

import UIKit

class SeplashViewController: UIViewController {
  
  @IBOutlet weak var areYouInVecationLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    //for localizable
    areYouInVecationLabel.text = NSLocalizedString("Are you in vacation?"
                                                   , comment: "")
  }
}
