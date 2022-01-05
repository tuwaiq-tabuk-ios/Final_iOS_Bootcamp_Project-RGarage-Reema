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

class HomeAndSearchVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
  
   let searchController = UISearchController()
  //let Adv = ADD()
  var Adv  : [ADD] = [ADD]()
//  var listArray = [""]
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    title = "Explore"
    navigationItem.searchController = searchController
    
  }

  func loadData() {
    let db = Firestore.firestore()
    db.collection("dvertising").getDocuments() { (QuerySnapshot, err) in
      if let err = err {
        print("Error getting documents : \(err)")
      }
      else {
          for document in QuerySnapshot!.documents {

            self.Adv.append(document.data()["lessorAddress"] as! ADD  )
            print("****** :: \(self.Adv.count)")
            self.Adv.append(document.data()["pricelessor"] as! ADD )
        }
//        self.tableView.reloadData()
      }
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Adv.count
  }
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let info = Adv[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellListOfItemCarage")  as! TableDetails

    cell.address.text = info.adAddressData
    print("****\na.address \(String(describing: info.adAddressData))")

    cell.price.text = info.adPriceData
    print("****\na.address \(String(describing: info.adPriceData))")
 
    return  cell
    
  }
}
