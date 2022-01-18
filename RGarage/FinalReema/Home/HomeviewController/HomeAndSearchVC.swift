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
  
  private let reuseIdentifier4 = String(describing:UItablviewCellTableViewCell.self)
  
  var data: [AdModel] = []
  var loading: Bool = false
  
  let db = Firestore.firestore()
  let storage = Storage.storage()

  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Explore"

    let nib2 = UINib(nibName: reuseIdentifier4, bundle: nil)
    tableView.register(nib2, forCellReuseIdentifier: reuseIdentifier4)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    loadData()
  }
  
  func loadData() {
    loading = true
    data.removeAll()
    
    db.collection("advertisements").getDocuments { snapshot, error in
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
      self.tableView.reloadData()
      self.loading = false
    }
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return data.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier4,
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      if loading { return }
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "DetailsTableInHome") as! DetailsTableInHome
      
     controller.ad = data[indexPath.row]
      
    self.navigationController?.pushViewController(controller, animated: true)
  }
}
