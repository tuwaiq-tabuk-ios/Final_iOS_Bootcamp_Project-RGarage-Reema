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

private let reuseIdentifier3 = String(describing:UItablviewCellTableViewCell.self)

struct InfoLessorAdverstisement {
  var priceLosserAA: String
  var lessorAddressAA: String
  
  var dictionary: [String: Any] {
    return [
      "priceLosser": priceLosserAA,
      "lessorAddress": lessorAddressAA]
  }
}


class AccountVC: UIViewController ,
                 UITableViewDelegate {
  //variable
  var avatar = UIImage()
  var userName = ""
  //data
  let db = Firestore.firestore()
  let storage = Storage.storage()
  
  var infoLessorAdverstisements = [InfoLessorAdverstisement]()
  
  
  @IBOutlet weak var tableViewAccount: UITableView!
  @IBOutlet weak var profilePhoto: UIImageView!
  @IBOutlet weak var nameUser: UILabel!
  
  override func viewDidLoad() {
    print("\n\n\n* * * * * * * * * * \(#file) \(#function)")
    super.viewDidLoad()
    
    profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
    profilePhoto.layer.borderWidth = 3
    profilePhoto.layer.borderColor = UIColor.lightGray.cgColor
    
    
    
    let nib2 = UINib(nibName: reuseIdentifier3, bundle: nil)
    
    tableViewAccount.register(nib2, forCellReuseIdentifier: reuseIdentifier3)
    
    
    loadImage()
    loadImage()
    
    //for user see his name in profile
    let user = Auth.auth().currentUser
    if let currentUser  = user {
      db.collection("users").document(currentUser.uid).getDocument { doc , err in
        if err != nil {
          print(err!)
        }
        else{
          let data = doc!.data()!
          self.userName  = data["FullName"] as! String
          print("\n\n* * * DATA :  \(data)")
          self.nameUser.text = self.userName
        }
      }
    }
  }
  
  @IBAction func settingButtom(_ sender: Any) {
    let UpdateAccountVC = storyboard?.instantiateViewController(identifier:"UpdateAccountVC") as? UpdateAccountVC
    view.window?.rootViewController = UpdateAccountVC
    view.window?.makeKeyAndVisible()
  }
  
  
  // MARK: loadImage User
  
  func loadImage() {
    let user = Auth.auth().currentUser
    guard let  currentUser  = user  else{return}
    let pathReference = storage.reference(withPath: "images/\(currentUser.uid).png")
    pathReference.getData(maxSize: 1000 * 1024 * 1024) { data, error in
      if let error = error {
        // Uh-oh, an error occurred!
        print(error)
      } else {
        // Data for "images/island.jpg" is returned
        let image = UIImage(data: data!)
        self.profilePhoto.image = image
      }
    }
    
  }

}
