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
  let ADImagesRef = Storage.storage().reference().child("images/")
  
  //  var details :Details?
  var phoneD : String = ""
   var imageD : UIImage = UIImage()
  var nameD:String = ""
  
  @IBOutlet weak var chatButton: UIButton!
  @IBOutlet weak var DetailsView: UIView!
  
  
  @IBOutlet weak var imageDeatailTableHome: UIImageView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var nameLessor: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadImage()
    loadData()
  }
  @IBAction func callButtonpressed(_ sender: UIButton) {
    if let url = URL(string: "tel://\(phoneLabel.text!)"),
    UIApplication.shared.canOpenURL(url) {
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
    
  }
    
  }
  
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
  
  override func viewWillAppear(_ animated: Bool) {

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

  
  func loadData() {
    db.collection("Advertising").getDocuments { (snapshot, error) in
              if let error = error {
                  print(error)
              } else {
                  if let snapshot = snapshot {
                      for document in snapshot.documents {

                          let data = document.data()
                          let adres = data["lessorAddress"] as? String ?? ""
                          let price = data["pricelessor"] as? String ?? ""
                          self.addressLabel.text = adres
                          self.priceLabel.text = price
                        
                      }
                  }
              }
          }
      }
  
  
  // MARK: loadImage AD
  func loadImage() {
    let user = Auth.auth().currentUser
    guard let  currentUser  = user  else{return}
    let pathReference = storage.reference(withPath: "imagesAD/\(currentUser.uid).png")
    pathReference.getData(maxSize: 1000 * 1024 * 1024) { data, error in
      if let error = error {
        // Uh-oh, an error occurred!
        print(error)
      } else {
        // Data for "images/island.jpg" is returned
        let image = UIImage(data: data!)
        self.imageDeatailTableHome.image = image
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
