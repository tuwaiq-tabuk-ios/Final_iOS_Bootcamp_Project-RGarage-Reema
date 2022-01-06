//
//  DetailsTableInHome.swift
//  FinalReema
//
//  Created by Reema Mousa on 04/05/1443 AH.
//



import UIKit
import FirebaseFirestore
import Firebase

class DetailsTableInHome : UIViewController {
  //data
  let db = Firestore.firestore()
  let user = Auth.auth().currentUser
  let storage = Storage.storage()
  
  //image
  let profileImagesRef = Storage.storage().reference().child("images/")
  
  //  var details :Details?
  var phoneD : String = ""
  var addressD : String = ""
  var priceD: String = ""
  var imageD : UIImage = UIImage()
  
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
    print(user?.uid)
    if let currentUser  = user {
      db.collection("Advertising").document(currentUser.uid).getDocument { doc , err in
        if err != nil {
          print(err!)
        }
        
        else{
          let data = doc!.data()!
          self.phoneD  = data["lessorphone"] as! String
          self.addressD  = data["lessorAddress"] as! String
          self.priceD  = data["pricelessor"] as! String
          
          self.phoneLabel.text = self.phoneD
          self.addressLabel.text = self.addressD
          self.priceLabel.text = self.priceD
          
          
        }
        
      }
    }
    
  }
  
  
  @IBAction func chatButton(_ sender: UIButton) {
    
    let VC = storyboard?.instantiateViewController(withIdentifier: "UsersChatTableVC") as! UsersChatTableVC
    present(VC, animated: true, completion: nil)
    
  }
}
