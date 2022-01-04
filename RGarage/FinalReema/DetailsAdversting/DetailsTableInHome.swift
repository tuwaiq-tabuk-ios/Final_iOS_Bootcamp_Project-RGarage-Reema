//
//  DetailsTableInHome.swift
//  FinalReema
//
//  Created by Reema Mousa on 04/05/1443 AH.
//

import UIKit

class DetailsTableInHome : UIViewController {
  
  var details :Details?
  
  var addressD : String!
  var priceD: String!
  var imageD : UIImage!
  
  @IBOutlet weak var imageDeatailTableHome: UIImageView!
  @IBOutlet weak var chatButton: UIButton!
  @IBOutlet weak var DetailsView: UIView!

  //labels
  
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }
  
  override func viewWillAppear(_ animated: Bool) {
    addressLabel.text = addressD
    priceLabel.text = priceD
    imageDeatailTableHome.image = imageD
  }
  
  
  @IBAction func chatButton(_ sender: UIButton) {
    
    let VC = storyboard?.instantiateViewController(withIdentifier: "UsersChatTableVC") as! UsersChatTableVC
      present(VC, animated: true, completion: nil)
    
  }
}
