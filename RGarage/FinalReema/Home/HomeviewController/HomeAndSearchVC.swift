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
    var pictures = [UIImage]()
  
    var dictionary: [String: Any] {
        return [
            "priceLosser": priceLosser,
            "lessorAddress": lessorAddress]
    }
}


class HomeAndSearchVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
  
   let searchController = UISearchController()
   var infoLessorArr = [InfoLessor]()
  
  var pictures = [UIImage]()

  let db = Firestore.firestore()
  let storage = Storage.storage()
  

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    title = "Explore"
    navigationItem.searchController = searchController
    loadData()
    
  }
  

  func loadData() {

      db.collection("Advertising").getDocuments() { (snapshot, error) in

          if let error = error {

              print(error.localizedDescription)

          } else {

              if let snapshot = snapshot {

                  for document in snapshot.documents {

                      let data = document.data()
                      let AdressD = data["lessorAddress"] as? String ?? ""
                      let PriceD = data["pricelessor"] as? String ?? ""
                    let newAD = InfoLessor(priceLosser: PriceD, lessorAddress: AdressD)
                      self.infoLessorArr.append(newAD)
                  }
                  self.tableView.reloadData()
              }
          }
      }
  }
  
 

  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {

    return infoLessorArr.count

  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    

    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellListOfItemCarage")  as! TableDetails
    
    let infoUserAD = infoLessorArr[indexPath.row]

    cell.address.text = infoUserAD.lessorAddress
    cell.price.text = " the price is \(infoUserAD.priceLosser)"
    return  cell
    
  }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "DetailsTableInHome") as! DetailsTableInHome
        
    self.navigationController?.pushViewController(controller, animated: true)
  }
  
}

