//
//  ViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 04/06/1443 AH.
//

import UIKit
import Firebase


class MyAdvertaismentTVC: UIViewController,
                          UITabBarDelegate,
                          UITableViewDataSource{
  
  private let reuseIdentifier2 = String(describing:UItablviewCellTableViewCell.self)
  
  var data: [AdModel] = []
  @IBOutlet weak var tableViewAccount: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nib2 = UINib(nibName: reuseIdentifier2, bundle: nil)
    
    tableViewAccount.register(nib2
                              ,forCellReuseIdentifier: reuseIdentifier2)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    loadData()
  }
  
  func loadData() {
    data.removeAll()
    db
      .collection("advertisements")
      .whereField("userID", isEqualTo: user?.uid)
      .getDocuments { snapshot, error in
        
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
  
 
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView
      .dequeueReusableCell(withIdentifier: reuseIdentifier2,
                           for: indexPath)  as! UItablviewCellTableViewCell
    
    let ad = data[indexPath.row]
    cell.address.text = ad.address
    cell.price.text = " the price is \(ad.price)"
    cell.date.text = ad.date.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
    
    if let imgURL = ad.imageURL {
      if imgURL != "" {
        cell.imageDetails.load(url: URL(string: imgURL)!)
      }
    }
    return  cell
  }
}
