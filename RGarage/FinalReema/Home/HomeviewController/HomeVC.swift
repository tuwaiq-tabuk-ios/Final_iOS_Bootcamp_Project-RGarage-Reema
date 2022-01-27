//
//  HomeAndSearchVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 28/05/1443 AH.
//

import UIKit
import Firebase

class HomeVC: UIViewController,
              UITableViewDelegate,
              UITableViewDataSource {
  
  private let reuseIdentifier1 = String(describing:UItablviewCellTableViewCell.self)
  
  var data: [AdModel] = []
  var loading: Bool = false
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Explore"
  
    let nib1 = UINib(nibName: reuseIdentifier1
                     , bundle: nil)
    tableView.register(nib1
                       , forCellReuseIdentifier: reuseIdentifier1)
   
  }
  override func viewDidAppear(_ animated: Bool) {
    loadData()
  }
  
  
  func loadData() {
    self.startLoading()
    data.removeAll()
    
    db
      .collection("advertisements")
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
        
      self.tableView.reloadData()
      self.stopLoading()
        
    }
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return data.count
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1,
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
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      if loading { return }
      
    let storyboard = UIStoryboard(name: "Main"
                                  , bundle: nil)
    let controller = storyboard
        .instantiateViewController(withIdentifier: "DetailsTableInHome") as! DetailsADInHome
    self.navigationController?
        .pushViewController(controller, animated: true)
      controller.ad = data[indexPath.row]
  }
}


