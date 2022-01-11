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
  
  func loadData() {
    print("\n\n\n* * * * * * * * * * \(#file) \(#function)")
    db.collection("Advertising").getDocuments() { (snapshot, error) in
      
      if let error = error {
        
        print(error.localizedDescription)
        
      } else {
        
        if let snapshot = snapshot {
          
          for document in snapshot.documents {
            
            let data = document.data()
            let AdressD = data["lessorAddress"] as? String ?? ""
            let PriceD = data["pricelessor"] as? String ?? ""
            let newAD = InfoLessorAdverstisement(priceLosserAA: PriceD, lessorAddressAA: AdressD)
            self.infoLessorAdverstisements.append(newAD)
            print("\n\n - - - THE LessorA ARRAY: \(self.infoLessorAdverstisements)")
          }
          self.tableViewAccount.reloadData()
        }
      }
    }
  }
}



// MARK: - Table data source

extension AccountVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
 
    return  infoLessorAdverstisements.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("\n\n\n----------------------------\(#file) \(#function)")
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ADuser") as! AdvertisingUserTVCell
    
    //AdvertisingUserTVCell
    
    let infoUserAD = infoLessorAdverstisements[indexPath.row]
    print(" - Info user: \(infoUserAD)")
    
    let lessorAddress = infoUserAD.lessorAddressAA
    
    cell.addressADuser.text = lessorAddress
    print("\n\n - LessorAddress- \(lessorAddress)")
    
    let priceADuser = infoUserAD.priceLosserAA
    cell.priceADuser.text = " the price is \(priceADuser)"
    print("\n\n\n - The price is: \(priceADuser)")
    
    return  cell
  }
}




