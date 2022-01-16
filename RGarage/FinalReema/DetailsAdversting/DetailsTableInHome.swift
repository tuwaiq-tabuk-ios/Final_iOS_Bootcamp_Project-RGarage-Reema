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
  
  @IBOutlet weak var chatButton: UIButton!
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
  @IBAction func shareButtonPressed(_ sender: UIButton) {  UIGraphicsBeginImageContext(view.frame.size)
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
 
    var lessorID = ""
    db.collection("Advertising").getDocuments() { (snapshot, error) in
            if let error = error {
        print(error.localizedDescription)
      } else {
        
        if let snapshot = snapshot {
      
          for document in snapshot.documents {
            print("****\(document.documentID)")
            
            let data = document.data()
            lessorID = data["lessorID"] as? String ?? ""
            print("\n\n ** LessorID from Adv Inside= \(lessorID)")
          }}
      }}
    
    print("\n\n ** LessorID from Adv outside= \(lessorID)")
    
    if let currentUser  = user {
      db.collection("users").document(currentUser.uid).getDocument { doc , err in
        if err != nil {
          print(err!)
        }
        else{
          let data = doc!.data()!
          
          self.nameD  = data["FullName"] as! String
          self.phoneD = data["PhoneNumber"] as! String
          
          print("**********DATA :  \(data)")
          self.phoneLabel.text = self.phoneD
          self.nameLessor.text = "By Lessor : \(self.nameD)"
          
        }
      }
    }
  }
  
  @IBAction func chatButton(_ sender: UIButton) {
    
    //    let VC = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
    //    present(VC, animated: true, completion: nil)
    //
    //  }
  }
  
}


//
//
//override func viewWillAppear(_ animated: Bool) {
//
//
//    db.collection("users").getDocuments() { (snapshot, error) in
//
//      if let error = error {
//
//          print(error.localizedDescription)
//
//      } else {
//        if let snapshot = snapshot {
//        for document in snapshot.documents {
//          let data = document.data()
//
//        let nnameD  = data["FullName"] as! String
//       let pphoneD = data["PhoneNumber"] as! String
//
//        print("**********DATA :  \(data)")
//          let newDD = DadaDD(phoneD: pphoneD, nameD: nnameD)
//          self.userData.append(newDD)
//
//          self.phoneLabel.text =  pphoneD
//          self.nameLessor.text = "By Lessor : \(nnameD)"
//
//      }
//
//    }
//  }
//}
//
//}
//

//
//override func viewWillAppear(_ animated: Bool) {
//
//  db.collection("users").getDocuments() { (snapshot, error) in
//
//    if let error = error {
//
//      print(error.localizedDescription)
//
//    } else {
//      if let snapshot = snapshot {
//        for document in snapshot.documents {
//          let data = document.data()
//
//          self.nameD  = (data["FullName"] as? String)!
//          self.phoneD = (data["PhoneNumber"] as? String)!
//
//          print("**********DATA :  \(data)")
//          self.phoneLabel.text = self.phoneD
//          self.nameLessor.text = "By Lessor : \(self.nameD)"
//        }
//
//      }
//    }
//
//  }
//}


//  override func viewWillAppear(_ animated: Bool) {
//
//
//    db.collection("users").getDocuments() { (snapshot, error) in
//
//        if let error = error {
//            print(error.localizedDescription)
//
//        } else {
//          if let snapshot = snapshot {
//          for document in snapshot.documents {
//            let data = document.data()
//
//            let nnameD  = data["FullName"] as! String
//            let pphoneD = data["PhoneNumber"] as! String
//
//            print("**********DATA :  \(data)")
//
//            self.phoneLabel.text =  pphoneD
//            self.nameLessor.text = "By Lessor : \(nnameD)"
//        }
//      }
//    }
//  }
//}

