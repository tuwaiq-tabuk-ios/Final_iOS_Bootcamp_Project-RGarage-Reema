//
//  Search.swift
//  FinalReema
//
//  Created by Reema Mousa on 04/05/1443 AH.
//

import UIKit

class HomeAndSearch : UIViewController ,UITableViewDelegate ,UITableViewDataSource {
  let searchController = UISearchController()
  
  
  @IBOutlet weak var TableView: UITableView!

  override func viewDidLoad() {
    title = "Explore"
    navigationItem.searchController = searchController
  }
  func handel (){
    
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellListOfItemCarage", for: indexPath)
    return cell
 
  }
  
 }
