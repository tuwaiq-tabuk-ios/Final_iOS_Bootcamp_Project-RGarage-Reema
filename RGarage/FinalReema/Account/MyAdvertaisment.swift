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

//struct LessorinfoA{
//  var priceLosserA: String
//  var lessorAddressA: String
//  var image : UIImage? = nil
//  var date  : String
//
//  var dictionary: [String: Any] {
//    return [
//      "priceLosser": priceLosserA,
//      "lessorAddress": lessorAddressA]
//  }
//}
//
//

class MyAdvertaisment: UIViewController,UITabBarDelegate,UITableViewDataSource{
  
  private let reuseIdentifier3 = String(describing:UItablviewCellTableViewCell.self)
  
  var data: [AdModel] = []
  
  let db = Firestore.firestore()
  let storage = Storage.storage()
  
  
  
  @IBOutlet weak var tableViewAccount: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nib2 = UINib(nibName: reuseIdentifier3, bundle: nil)
    
    tableViewAccount.register(nib2, forCellReuseIdentifier: reuseIdentifier3)
      loadData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    loadData()
  }
  
  func loadData() {
    data.removeAll()
    
    db.collection("advertises").whereField("userID", isEqualTo: user.uid).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      
      guard let docs = snapshot?.documents else { return }
      for doc in docs {
        do {
          try self.data.append(doc.data(as: AdModel.self)!)
        } catch {
          fatalError(error.localizedDescription)
        }
      }
      self.tableViewAccount.reloadData()
    }
  }
  

  
  
//  func loadData() {
//    guard let user = Auth.auth().currentUser?.uid else { return }
//
//    db.collection("Advertising").whereField("lessorID",isEqualTo: user ).getDocuments() { (querySnapshot, err) in
//        if let err = err {
//          print("Error getting documents: \(err)")
//        } else {
//          for document in querySnapshot!.documents {
//
//            let data = document.data()
//            let AdressD = data["lessorAddress"] as? String ?? ""
//            let PriceD = data["pricelessor"] as? String ?? ""
//            let dateAD = data["Date"] as? String ?? ""
//            let imagePath = "imagesAD/\(document.documentID).png"
//
//            let pathReference = self.storage.reference(withPath: imagePath)
//            print("\(imagePath)")
//            pathReference.getData(maxSize: 1000 * 1024 * 1024) { data, error in
//
//              if let error = error {
//                print(error)
//              }else {
//                let image = UIImage(data: data!)
//                Firestore.firestore().collection("Advertising")
//                let newAD = LessorinfoA(priceLosserA: PriceD, lessorAddressA: AdressD , image: image,date: dateAD)
//                self.infoLessorA.append(newAD)
//              }
//              self.tableViewAccount.reloadData()
//            }
//          }
//        }
//      }
//    }
//
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return data.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier3,
                                             for: indexPath)  as! UItablviewCellTableViewCell
    
    let ad = data[indexPath.row]
    cell.address.text = ad.address
    cell.price.text = " the price is \(ad.price)"
    if let imgURL = ad.imageURL {
      if imgURL != "" {
        cell.imageDetails.load(url: URL(string: imgURL)!)
      }
    }
    
    cell.date.text = DateFormatter.localizedString(from: ad.date , dateStyle: .long, timeStyle: .medium)

    return  cell
    
    
  }
}
