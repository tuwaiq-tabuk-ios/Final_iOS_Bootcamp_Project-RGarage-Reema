//
//  AccountVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 04/05/1443 AH.
//

import UIKit
import Firebase

class AccountVC: UIViewController ,
                 UITableViewDelegate {
  //variable
  var avatar = UIImage()
  var userName = ""

  @IBOutlet weak var profilePhoto: UIImageView!
  @IBOutlet weak var nameUser: UILabel!
  @IBOutlet weak var viewInfoUser: UIView!
  
  @IBOutlet weak var myAdvertismentButton: UIButton!
  
  override func viewDidLoad() {
    print("\n\n\n* * * * * * * * * * \(#file) \(#function)")
    super.viewDidLoad()
    
    profilePhoto.layer.cornerRadius = profilePhoto.frame.width/2
    profilePhoto.layer.borderWidth = 3
    profilePhoto.layer.borderColor = UIColor.lightGray.cgColor
   
    myAdvertismentButton.setTitle(NSLocalizedString("MyAdvertisments", comment: ""), for: .normal)
    
    nameUser.text = user?.fullName
    
    //loadNameUser()
    viewInfoUser.layer.cornerRadius = 10
     
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    loadImage()
  }
  @IBAction func settingButtom(_ sender: Any) {
    let VC = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.updateAccountVC)
    
    self.view.window?.rootViewController = VC
    self.view.window?.makeKeyAndVisible()
  }
  
  
  // MARK: loadImage User
    func loadImage() {
    if let imgURL = user.imgURL {
      if imgURL != "" {
        profilePhoto.load(url: URL(string: imgURL)!)
      }
    }
  }
}
