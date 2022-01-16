//
//  HomeAndSearchVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 28/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


struct InfoLessor {
  var priceLosser: String
  var lessorAddress: String
  var image : UIImage? = nil
  var date  : String
  var dictionary: [String: Any] {
    return [
      "priceLosser": priceLosser,
      "lessorAddress": lessorAddress]
    
  }
  
}


class HomeAndSearchVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
  
  private let reuseIdentifier4 = String(describing:UItablviewCellTableViewCell.self)
  
  var infoLessorArr = [InfoLessor]()
  let db = Firestore.firestore()
  let storage = Storage.storage()

  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadData()
    let nib2 = UINib(nibName: reuseIdentifier4, bundle: nil)
    tableView.register(nib2, forCellReuseIdentifier: reuseIdentifier4)
    
  }
  
  func loadData() {
    
    db.collection("Advertising").getDocuments() { (snapshot, error) in
      
      if let error = error {
        
        print(error.localizedDescription)
        
      } else {
        
        if let snapshot = snapshot {
          
          for document in snapshot.documents {
            print("****\(document.documentID)")
            
            let data = document.data()
            let AdressD = data["lessorAddress"] as? String ?? ""
            let PriceD = data["pricelessor"] as? String ?? ""
            let dateAD = data["Date"] as? String ?? ""
            let imagePath = "imagesAD/\(document.documentID).png"
          
            print("\n\n\n **** The add Info: \(data)")
            let pathReference = self.storage.reference(withPath: imagePath)
            print("\(imagePath)")
            pathReference.getData(maxSize: 1000 * 1024 * 1024) { data, error in
              
              if let error = error {
                
                print(error)
              }
              else {
                let image = UIImage(data: data!)
                
                Firestore.firestore().collection("Advertising")
                let newAD = InfoLessor(priceLosser: PriceD, lessorAddress: AdressD , image: image ,date: dateAD)
                self.infoLessorArr.append(newAD)
              }
              self.tableView.reloadData()
              
            }
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
    
    return infoLessorArr.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier4,
                                             for: indexPath)  as! UItablviewCellTableViewCell
    
    let infoUserAD = infoLessorArr[indexPath.row]
    cell.address.text = infoUserAD.lessorAddress
    cell.price.text = " the price is \(infoUserAD.priceLosser)"
    cell.imageDetails.image = infoUserAD.image
    cell.date.text = infoUserAD.date
    return  cell
    
    
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "DetailsTableInHome") as! DetailsTableInHome
    
    controller.imageD = infoLessorArr[indexPath.row].image
    controller.addressD = infoLessorArr[indexPath.row].lessorAddress
    controller.priceD = infoLessorArr[indexPath.row].priceLosser
    
    self.navigationController?.pushViewController(controller, animated: true)
  }
}
