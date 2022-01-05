//
//  Add advertisingViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 11/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
class AddAdvertising : UIViewController  ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  //data
  let db = Firestore.firestore()
  var AdData  : [ADD] = []
  //variable
  var aaddressAD : String = ""
  var ppriceAD : String = ""
  var imageAD = UIImage()
  
//  var details = Details()
  var adInfoUsers = ADuser()
  
  @IBOutlet weak var imageView: UIView!
  @IBOutlet weak var addImageAD: UIImageView!
  @IBOutlet weak var addressAD: UITextField!
  @IBOutlet weak var phoneNumberAD: UITextField!
  @IBOutlet weak var priceAD: UITextField!
  @IBOutlet weak var btnAddAdvertising: UIButton!
  @IBOutlet weak var BasicView: UIView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.layer.cornerRadius = imageView.frame.height/5
    addImageAD.layer.cornerRadius =  addImageAD.frame.height/5
    //shadow
    BasicView.layer.shadowOpacity = 10
    BasicView.layer.cornerRadius = 10
    BasicView.layer.shadowOffset = .zero
    BasicView.layer.shadowRadius = 150
    BasicView.layer.shouldRasterize = true
    
    loadDataAD()
  }
  
  func loadDataAD(){
    db.collection("users").addSnapshotListener { querySnapshot, errer in
      
      self.AdData = [] 
      if let snapshotDoc = querySnapshot?.documents{
        for doc in snapshotDoc {
          let data = (doc.data())
          if let lessorAD = data["lessor"] as? String,
             let phoneNData = data["lessorphone"] as? String,
             let addressdata = data["lessorAddress"] as? String,
             let priceData =  data["pricelessor"] as? String
//             let imagUserData =  data["imageADlesso"] as? URL
          {
            let newAD = ADD(lessor: lessorAD,adphoneData: phoneNData, adAddressData: addressdata, adPriceData: priceData)
            self.AdData.append(newAD)
            print("**** :: \(newAD)")
          }
        }
      }
    }
  }
  
  
  @IBAction func btnAddAdvertising(_ sender: Any) {
    
    if let phoneUserD = phoneNumberAD.text,
       let addressUserD = addressAD.text,
       let priceUserD = priceAD.text,
//       let imageUserD = addImageAD.image ,
       let  userLogin = Auth.auth().currentUser?.email {
      
      db.collection("dvertising").addDocument(data: [
        "lessor": userLogin,
        "lessorphone" : phoneUserD,
        "lessorAddress" : addressUserD ,
        "pricelessor" : priceUserD
//         "imageADlesso": imageUserD,
      ]){(error)in
        if let err = error {
          print(err)
        }
        else{
          DispatchQueue.main.async {
            
            self.phoneNumberAD.text = ""
            self.addressAD.text = ""
            self.priceAD.text = ""
//            self.addImageAD.image = 
            
          }
        }
      }
    }
   let AddDetails = storyboard?.instantiateViewController(withIdentifier: "HomeAndSearchVC") as! HomeAndSearchVC

    let tapbar = storyboard?.instantiateViewController(withIdentifier: "tapbarVC") as! tapbarVC
 
    present(tapbar, animated: true, completion: nil)
 
    AddDetails.tableView?.reloadData()

    
  }
  
  
  
  @IBAction func addphotoButon(_ sender: Any) {
    
    let addImge = UIImagePickerController()
    addImge.sourceType = .photoLibrary
    addImge.delegate = self
    addImge.allowsEditing = true
    present(addImge, animated: true)
  }
  
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
  {
    let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    
    addImageAD.image = image
    self.dismiss(animated: true, completion: nil)
  }
}


///for data toaccount
///    //Account
//    adInfoUsers.imageUser = imageAD
//    adInfoUsers.addressUser = aaddressAD
//    adInfoUsers.priceUser = ppriceAD

//    addADInfo.append(adInfoUsers)
//    let addADInfoToAccount  = storyboard?.instantiateViewController(withIdentifier: "AccountVC") as! AccountVC
//    addADInfoToAccount.tableViewAccount?.reloadData()
