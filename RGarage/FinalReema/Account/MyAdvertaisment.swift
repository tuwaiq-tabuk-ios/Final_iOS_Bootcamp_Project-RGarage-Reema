////
////  ViewController.swift
////  FinalReema
////
////  Created by Reema Mousa on 04/06/1443 AH.
////
//
//import UIKit
//import Firebase
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseStorage
//
//struct Lessorinfo{
//    var priceLosserA: String
//    var lessorAddressA: String
//
//    var dictionary: [String: Any] {
//        return [
//            "priceLosser": priceLosserA,
//            "lessorAddress": lessorAddressA]
//    }
//}
//
//class MyAdvertaisment: UIViewController {
//
//  var infoLessorA = [Lessorinfo]()
//  let db = Firestore.firestore()
//  let storage = Storage.storage()
//
//
//
//  @IBOutlet weak var tableViewAccount: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//      loadData()
//    }
//
//    func loadData() {
//
//        db.collection("Advertising").getDocuments() { (snapshot, error) in
//
//            if let error = error {
//
//                print(error.localizedDescription)
//
//            } else {
//
//                if let snapshot = snapshot {
//
//                    for document in snapshot.documents {
//
//                        let data = document.data()
//                        let AdressD = data["lessorAddress"] as? String ?? ""
//                        let PriceD = data["pricelessor"] as? String ?? ""
//                      let newAD = Lessorinfo(priceLosserA: PriceD, lessorAddressA: AdressD)
//                        self.infoLessorA.append(newAD)
//                    }
//                    self.tableViewAccount.reloadData()
//                }
//            }
//        }
//    }
//
//  func tableView(_ tableView: UITableView,
//                 numberOfRowsInSection section: Int) -> Int {
//
//    return infoLessorA.count
//
//  }
//
//  func tableView(_ tableView: UITableView,
//                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//    let cell = tableView.dequeueReusableCell(withIdentifier: "ADuser") as! AdvertisingUserTVCell
//
//    let UserAD = infoLessorA[indexPath.row]
//
//    cell.priceADuser.text = UserAD.priceLosserA
//    cell.addressADuser.text = UserAD.lessorAddressA
//
//
//  return cell
//
//  }
//
//}
