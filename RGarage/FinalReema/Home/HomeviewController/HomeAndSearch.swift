//
//  Search.swift
//  FinalReema
//
//  Created by Reema Mousa on 04/05/1443 AH.
//

import UIKit

class HomeAndSearch : UIViewController
,UITableViewDelegate ,UITableViewDataSource {
  
  let searchController = UISearchController()
  
  @IBOutlet weak var TableView: UITableView!
  
  override func viewDidLoad() {
    title = "Explore"
    navigationItem.searchController = searchController
  }
   
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let a:Details = data[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellListOfItemCarage", for: indexPath) as! TableDetails
    
    cell.address.text! =  a.address
    print("****\na.address \(String(describing: a.address))")
    cell.price.text! = a.price
    print("****\na.price \(String(describing: a.price))")
    cell.imageTabel.image = a.image
    print("****\na.image \(String(describing: a.image))")
    return cell
    
  }
  
  
//  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let selectedRow = [indexPath.row]
//    performSegue(withIdentifier: "showDetails", sender: selectedRow)
//  }
//
//  override func prepare(for segue: UIStoryboardSegue, sender:Any?){
//    if let DVc =
//
//  }
}
