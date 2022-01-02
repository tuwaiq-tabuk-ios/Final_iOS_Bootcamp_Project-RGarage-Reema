//
//  HomeAndSearchVC.swift
//  FinalReema
//
//  Created by Reema Mousa on 28/05/1443 AH.
//

import UIKit


class HomeAndSearchVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
  
  let searchController = UISearchController()
  
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    title = "Explore"
    navigationItem.searchController = searchController
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let info:Details = data[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellListOfItemCarage", for: indexPath) as! TableDetails
    
    cell.address.text! =  info.address
    print("****\na.address \(String(describing: info.address))")
    cell.price.text! = info.price
    print("****\na.price \(String(describing: info.price))")
    cell.imageTabel.image = info.image
    print("****\na.image \(String(describing: info.image))")
    
    return cell
    
  }
  
  // pass data to DetailsTableInHome
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let controller = storyboard.instantiateViewController(withIdentifier: "DetailsTableInHome") as! DetailsTableInHome
    
    controller.imageD = data[indexPath.row].image
    controller.priceD = data[indexPath.row].price
    controller.addressD = data[indexPath.row].address
    
    self.navigationController?.pushViewController(controller, animated: true)
    
    
    
    
    
  }
  
}

