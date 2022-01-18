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
  //let storage = Storage.storage()
  
  var ad: AdModel?
  var adUser: UserModel?
  
  @IBOutlet weak var DetailsView: UIView!
  
  @IBOutlet weak var chatButton: UIButton!
  @IBOutlet weak var orlabelbetweenchatway: UILabel!
  @IBOutlet weak var whatsAppCHatButton: UIButton!
  
  @IBOutlet weak var imageDeatailTableHome: UIImageView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var nameLessor: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadUser()
    
    guard let ad = ad else {
      return
    }
    
    if ad.userID == user.uid {
      chatButton.isHidden = true
      whatsAppCHatButton.isHidden = true
      orlabelbetweenchatway.isHidden = true
    }
    
    
    //MARK: informations lessor
    
    //imageDeatailTableHome.load(url: URL(string: ad!.imageURL!)!)
    addressLabel.text! =  ad.address
    priceLabel.text! = "\(ad.price)"
    
    //    print("******* Image \(String(describing: imageD))")
    if let imgURL = ad.imageURL {
      if imgURL != "" {
        imageDeatailTableHome.load(url: URL(string: imgURL)!)
      }
    }
  }
  
  func loadUser() {
    db.collection("users").whereField("uid", isEqualTo: ad!.userID).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      guard let doc = snapshot?.documents.first else { return }
      
      do {
        self.adUser = try doc.data(as: UserModel.self)!
        self.nameLessor.text = "Lessor Name : \(self.adUser!.fullName)"
        self.phoneLabel.text = self.adUser!.phoneNumber
      } catch {
        fatalError(error.localizedDescription)
      }
    }
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
  
  
  @IBAction func ChatButtonPressed(_ sender: UIButton) {
    //
    print(ad!.userID, user.uid)
    db.collection("conversations").whereField("usersIds", arrayContainsAny: [user.uid, ad!.userID]).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      print(snapshot?.documents.count , "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
      guard let doc = snapshot?.documents.first else {
        self.createConversation()
        return
      }
      do {
        let conversation = try doc.data(as: ChatRoom.self)!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        controller.selectedConversation = conversation
        self.navigationController?.pushViewController(controller, animated: true)
      } catch {
        fatalError(error.localizedDescription)
      }
    }
    
  }
  
  
  private func createConversation() {
    var users: [ChatRoomUser] = []
    users.append(ChatRoomUser(id: user!.uid, name: user.fullName, imgURL: user.imgURL))
    
    users.append(ChatRoomUser(id: adUser!.uid, name: adUser!.fullName, imgURL: adUser!.imgURL))
    
    var conversation = ChatRoom(users: users, usersIds: [user!.uid, adUser!.uid], id: UUID().uuidString, message: [])
    var ref: DocumentReference!
    do {
      ref = try self.db.collection("conversations").addDocument(from: conversation) { error in
        if let error = error {
          fatalError(error.localizedDescription)
        }
        // segue to chat details -> conversation
        
        conversation.docID = ref.documentID
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        controller.selectedConversation = conversation
        self.navigationController?.pushViewController(controller, animated: true)
      }
    } catch {
      fatalError(error.localizedDescription)
    }
  }
}


