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
  //  var ADuserIfo = [ADuser]()
  
  var avatar = UIImage()
  var userName = ""
  
  
  let db = Firestore.firestore()
  let storage = Storage.storage()
  var infoLessorAdverstisements = [InfoLessorAdverstisement]()

  
  @IBOutlet weak var profilePhoto: UIImageView!
  @IBOutlet weak var nameUser: UILabel!
  @IBOutlet weak var tableViewAccount: UITableView!
  
  override func viewDidLoad() {
    print("\n\n\n* * * * * * * * * * \(#file) \(#function)")
    super.viewDidLoad()
    
    profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
    profilePhoto.layer.borderWidth = 3
    profilePhoto.layer.borderColor = UIColor.lightGray.cgColor
    
    tableViewAccount.delegate = self
//    loadData()
//    profilePhoto.image = avatar
//    nameUser.text = userName
    loadData()
    loadImage()
    
    let user = Auth.auth().currentUser
    print(user?.uid)
    if let currentUser  = user {
      db.collection("users").document(currentUser.uid).getDocument { doc , err in
        if err != nil {
          print(err!)
        }
        else{
          let data = doc!.data()!
          
          self.userName  = data["fulNmae"] as! String
          print("\n\n* * * DATA :  \(data)")
          self.nameUser.text = self.userName
        }
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
//    print("\n\n\n* * * * * * * * * * \(#file) \(#function)")
    
//    loadData()
//    loadImage()
//
//    let user = Auth.auth().currentUser
//    print(user?.uid)
//    if let currentUser  = user {
//      db.collection("users").document(currentUser.uid).getDocument { doc , err in
//        if err != nil {
//          print(err!)
//        }
//        else{
//          let data = doc!.data()!
//
//          self.userName  = data["fulNmae"] as! String
//          print("\n\n* * * DATA :  \(data)")
//          self.nameUser.text = self.userName
//        }
//      }
//    }
    
  }
  
  
  @IBAction func settingButtom(_ sender: Any) {
    let UpdateAccountVC = storyboard?.instantiateViewController(identifier:"UpdateAccountVC") as? UpdateAccountVC
    view.window?.rootViewController = UpdateAccountVC
    view.window?.makeKeyAndVisible()
  }
  
  
  func loadImage() {
    let user = Auth.auth().currentUser
    print(user?.uid)
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
    print("\n\n\n- - - - - - - - - - - - -\(#file) \(#function)")
    print(" - Lessor COUNT = \(infoLessorAdverstisements.count)")
      return  infoLessorAdverstisements.count
    }
    
    
    func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("\n\n\n----------------------------\(#file) \(#function)")
      
    let cell = tableView.dequeueReusableCell(withIdentifier: "ADUser") as! outletADUser
//      AdvertisingUserTVCell
    let infoUserAD = infoLessorAdverstisements[indexPath.row]
    print(" - Info user: \(infoUserAD)")
    
      
    let lessorAddress = infoUserAD.lessorAddressAA
    print("\n\n - LessorAddress- \(lessorAddress)")
    cell.addressADuser.text = lessorAddress
    
    
    let priceADuser = infoUserAD.priceLosserAA
    print("\n\n\n - The price is: \(priceADuser)")
    cell.priceADuser.text = " the price is \(priceADuser)"
      
    return  cell
  }
}




