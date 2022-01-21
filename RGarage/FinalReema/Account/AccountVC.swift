//
//  AccountVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 04/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class AccountVC: UIViewController ,
                 UITableViewDelegate {
  //variable
  var avatar = UIImage()
  var userName = ""
  //data
  let db = Firestore.firestore()
  let storage = Storage.storage()
  
    
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
    let UpdateAccountVC = storyboard?.instantiateViewController(identifier:"UpdateAccountVC") as? UpdateAccountVC
    view.window?.rootViewController = UpdateAccountVC
    view.window?.makeKeyAndVisible()
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
