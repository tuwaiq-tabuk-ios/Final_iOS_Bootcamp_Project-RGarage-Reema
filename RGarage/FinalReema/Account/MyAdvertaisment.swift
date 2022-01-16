//
//  ViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 04/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct LessorinfoA{
  var priceLosserA: String
  var lessorAddressA: String
  var image : UIImage? = nil
  var date  : String

  var dictionary: [String: Any] {
    return [
      "priceLosser": priceLosserA,
      "lessorAddress": lessorAddressA]
  }
}



class MyAdvertaisment: UIViewController,UITabBarDelegate,UITableViewDataSource{
  
  private let reuseIdentifier3 = String(describing:UItablviewCellTableViewCell.self)
  
  var infoLessorA = [LessorinfoA]()
  
  let db = Firestore.firestore()
  let storage = Storage.storage()
  
  
  
  @IBOutlet weak var tableViewAccount: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nib2 = UINib(nibName: reuseIdentifier3, bundle: nil)
    
    tableViewAccount.register(nib2, forCellReuseIdentifier: reuseIdentifier3)
    
    
    loadData()
  }
  
  func loadData() {
    guard let user = Auth.auth().currentUser?.uid else { return }
    
    db.collection("Advertising").whereField("lessorID",isEqualTo: user ).getDocuments() { (querySnapshot, err) in
        if let err = err {
          print("Error getting documents: \(err)")
        } else {
          for document in querySnapshot!.documents {
//            print("\(document.documentID) => \(document.data())")
            
            let data = document.data()
            let AdressD = data["lessorAddress"] as? String ?? ""
            let PriceD = data["pricelessor"] as? String ?? ""
            let dateAD = data["Date"] as? String ?? ""
            let imagePath = "imagesAD/\(document.documentID).png"
            
            let pathReference = self.storage.reference(withPath: imagePath)
            print("\(imagePath)")
            pathReference.getData(maxSize: 1000 * 1024 * 1024) { data, error in
              
              if let error = error {
                print(error)
              }else {
                let image = UIImage(data: data!)
                Firestore.firestore().collection("Advertising")
                let newAD = LessorinfoA(priceLosserA: PriceD, lessorAddressA: AdressD , image: image,date: dateAD)
                self.infoLessorA.append(newAD)
              }
              self.tableViewAccount.reloadData()
            }
          }
        }
      }
    }
 
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return infoLessorA.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier3,
                                             for: indexPath)  as! UItablviewCellTableViewCell
    
    let infoUserAD = infoLessorA[indexPath.row]
    cell.address.text = infoUserAD.lessorAddressA
    cell.price.text = " The price is: \(infoUserAD.priceLosserA)"
    cell.imageDetails.image = infoUserAD.image
    cell.date.text = infoUserAD.date

    return  cell
    
    
  }
}
