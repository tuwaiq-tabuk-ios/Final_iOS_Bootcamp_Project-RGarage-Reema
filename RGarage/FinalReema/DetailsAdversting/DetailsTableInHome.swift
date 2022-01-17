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
  
  var phoneD : String =  ""
  var nameD : String = ""
  
  var imageD : UIImage? = nil
  var addressD: String = ""
  var priceD : String = ""
  
  var id : String = ""
  
  @IBOutlet weak var DetailsView: UIView!
  
  @IBOutlet weak var imageDeatailTableHome: UIImageView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var nameLessor: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    imageDeatailTableHome.image = imageD
    addressLabel.text! =  addressD
    priceLabel.text! = priceD
    
    print("******* Image \(String(describing: imageD))")
    
  }
  
  //MARK: user can make phone call
  
  @IBAction func callButtonpressed(_ sender: UIButton) {
    if let url = URL(string: "tel://\(phoneLabel.text!)"),
       UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
  
  
  //MARK: user can share advertisement
  @IBAction func shareButtonPressed(_ sender: UIButton) {
    
    UIGraphicsBeginImageContext(view.frame.size)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    let textToShare = "Check out my app"
    
    if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {
      
      let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
      let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
      
      //Excluded Activities
      activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
      
      activityVC.popoverPresentationController?.sourceView = sender
      self.present(activityVC, animated: true, completion: nil)
    }
    
  }
  
  //MARK: informations lessor
  
  override func viewWillAppear(_ animated: Bool) {
    
    let docRef = db.collection("Advertising").document(id)
    docRef.getDocument { (document, error) in
      if let document = document, document.exists {

        let  lessorID = document["lessorID"] as? String ?? ""
        self.db.collection("users").document(lessorID).getDocument {( doc , err )in
          if err != nil
          {
            print(err!)
          }
          else
          {
            self.nameD  = doc!["FullName"] as! String
            self.phoneD = doc!["PhoneNumber"] as! String
            self.phoneLabel.text = self.phoneD
            self.nameLessor.text = "By Lessor : \(self.nameD)"
            
          }
        }
        
      }
    }
  }
  
@IBAction func whatsAppButtonPressed(_ sender: UIButton) {
    
 let phoneNumber = "\(phoneLabel.text!)"
    
  let shareableMessageText = "Hi Lessor"
 let whatsApp = "https://wa.me/\(phoneNumber)/?text=\(shareableMessageText)"
    
   if let urlString = whatsApp.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    print("error")
                }
            }
        }
  }
}


