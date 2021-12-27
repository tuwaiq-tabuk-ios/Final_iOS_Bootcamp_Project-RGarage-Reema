//
//  Add advertisingViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 11/05/1443 AH.
//

import UIKit

class AddAdvertising : UIViewController  ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var getAdvertismentInfo:Detail = Detail(address: "Main street", phone: "000000000", price: "90" , image: "user1")
                             //  Detail(address: "Street 2", phone: "55555555555", price: "40",image: "Social media-bro")
  
  
//  let a : self.getAdvertismentInfo
//  var getDetail : Detail!
  
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
    
    addImageAD.image = UIImage(named: getAdvertismentInfo.image)
    addressAD.text = getAdvertismentInfo.address
    phoneNumberAD.text = getAdvertismentInfo.phone
    priceAD.text = getAdvertismentInfo.price
    

//    getDetail.address = (addressAD.text)
    
    
    
  }
  
  @IBAction func btnAddAdvertising(_ sender: Any) {
    
    let AddDetails = storyboard?.instantiateViewController(withIdentifier: "tapbarVC") as! tapbarVC
    
    present(AddDetails, animated: true, completion: nil)
  }
  
  
  @IBAction func addphotoButon(_ sender: Any) {
    
    let addImge = UIImagePickerController()
    addImge.sourceType = .photoLibrary
    addImge.delegate = self
    addImge.allowsEditing = true
    present(addImge, animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    addImageAD.image = image
    self.dismiss(animated: true, completion: nil)
  }
  
  
  
  
}
