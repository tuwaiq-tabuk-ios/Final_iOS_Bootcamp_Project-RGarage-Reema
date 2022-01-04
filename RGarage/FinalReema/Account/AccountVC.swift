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
import FirebaseCore
 
class AccountVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
 //variable
  var ADuserIfo = [ADuser]()
  
  var avatar = UIImage()
  var userName = ""
  
  @IBOutlet weak var profilePhoto: UIImageView!
  @IBOutlet weak var nameUser: UILabel!
  @IBOutlet weak var tableViewAccount: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    profilePhoto.image = avatar
    nameUser.text = userName
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return addADInfo.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let infoAD :  ADuser = addADInfo[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "outletADUser", for: indexPath) as! outletADUser
   
    cell.addressADuser.text = infoAD.addressUser
    cell.priceADuser.text  = infoAD.priceUser
    cell.imageADuser.image = infoAD.imageUser
    
    return cell
 }
  @IBAction func settingButtom(_ sender: Any) {
    let UpdateAccountVC = storyboard?.instantiateViewController(identifier:"UpdateAccountVC") as? UpdateAccountVC
    view.window?.rootViewController = UpdateAccountVC
    view.window?.makeKeyAndVisible()
  }
  
}


  

