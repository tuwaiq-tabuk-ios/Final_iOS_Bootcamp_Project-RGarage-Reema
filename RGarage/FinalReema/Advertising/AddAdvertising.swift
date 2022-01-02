//
//  Add advertisingViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 11/05/1443 AH.
//

import UIKit

class AddAdvertising : UIViewController  ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  //variable
  var aaddressAD : String = ""
  var ppriceAD : String = ""
  var imageAD = UIImage()
  
  var details = Details()
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
    
  }
  
  @IBAction func btnAddAdvertising(_ sender: Any) {
    imageAD = addImageAD.image!
    print("**imageAD:\(imageAD)\n")
    aaddressAD = addressAD.text!
    print("**aaddressAD:\(aaddressAD)\n")
    ppriceAD = "Price is : \(priceAD.text!)"
    print("**aaddressAD:\(ppriceAD)\n")
    
    //home
    details.image = imageAD
    details.price = ppriceAD
    details.address = aaddressAD
    
    //Account
//    adInfoUsers.imageUser = imageAD
//    adInfoUsers.addressUser = aaddressAD
//    adInfoUsers.priceUser = ppriceAD
    
    data.append(details)
//    addADInfo.append(adInfoUsers)
    
    let AddDetails = storyboard?.instantiateViewController(withIdentifier: "HomeAndSearchVC") as! HomeAndSearchVC
    
//    let addADInfoToAccount  = storyboard?.instantiateViewController(withIdentifier: "AccountVC") as! AccountVC
    let tapbar = storyboard?.instantiateViewController(withIdentifier: "tapbarVC") as! tapbarVC
    
    present(tapbar, animated: true, completion: nil)
    
    AddDetails.tableView?.reloadData()
    
//    addADInfoToAccount.tableViewAccount?.reloadData()
    
    
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
