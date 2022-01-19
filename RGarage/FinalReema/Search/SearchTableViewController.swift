//
//  SearchTableViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 16/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class SearchTableViewController: UITableViewController,UISearchBarDelegate {
  
  private let reuseIdentifier = String(describing:UItablviewCellTableViewCell.self)
  
  let  db = Firestore.firestore()
  
  var data : [AdModel] = []
  var filterData :[AdModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nib2 = UINib(nibName: reuseIdentifier, bundle: nil)
    tableView.register(nib2, forCellReuseIdentifier: reuseIdentifier)
    
  }
  override func viewDidAppear(_ animated: Bool) {
    loadData()
  }
  
  //MARK: Load data for search
  func loadData() {
    data.removeAll()
    self.startLoading()
    db.collection("advertisements").getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      else{
        guard let docs = snapshot?.documents else {return}
        for doc in docs {
          do {
            try
            self.data.append(doc.data(as: AdModel.self)!)
          }catch{
            fatalError(error.localizedDescription)
            
          }
        }
        self.stopLoading()
      }
    }
  }
  
  //MARK: serach Bar Funciton 
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    guard let text = searchBar.text else {return}
    filterData = data.filter({ item in
      item.address.contains(text)
    })
    self.tableView.reloadData()
  }
    
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filterData.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                             for: indexPath)  as! UItablviewCellTableViewCell
    let ad = filterData[indexPath.row]
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
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "DetailsTableInHome") as! DetailsTableInHome
    controller.ad = data[indexPath.row]
    self.navigationController?.pushViewController(controller, animated: true)
    
  }
}
