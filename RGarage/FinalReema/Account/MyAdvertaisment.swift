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
    
    db.collection("advertisements").whereField("userID", isEqualTo: user.uid).getDocuments { snapshot, error in
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
    cell.date.text = DateFormatter.localizedString(from: ad.date , dateStyle: .long, timeStyle: .medium)
    
    if let imgURL = ad.imageURL {
      if imgURL != "" {
        cell.imageDetails.load(url: URL(string: imgURL)!)
      }
    }
    return  cell
    
  }
}
