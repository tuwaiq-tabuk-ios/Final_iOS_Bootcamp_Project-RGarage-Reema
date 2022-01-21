//
//  DetailsTableInHome.swift
//  FinalReema
//
//  Created by Reema Mousa on 04/05/1443 AH.
//

import UIKit
import Firebase


class DetailsADInHome : UIViewController {
  
  //data
  let db = Firestore.firestore()
  
  var ad: AdModel?
  var adUser: UserModel?
  
  @IBOutlet weak var DetailsView: UIView!
  @IBOutlet weak var chatButton: UIButton!
  @IBOutlet weak var orlabelbetweenchatway: UILabel!
  @IBOutlet weak var whatsAppCHatButton: UIButton!
  @IBOutlet weak var advertisementImage: UIImageView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var nameLessorLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadUser()
    
    // Hide the chat method if the advertiser enters the personal ad, he cannot communicate with himself
    
    guard let ad = ad else {return}
    
    if ad.userID == user?.uid {
      chatButton.isHidden = true
      whatsAppCHatButton.isHidden = true
      orlabelbetweenchatway.isHidden = true
    }
    
    //MARK: informations AD Address ,Price ,Image
    addressLabel.text! =  ad.address
    priceLabel.text! = "\(ad.price)"
    if let imgURL = ad.imageURL {
      if imgURL != "" {
        advertisementImage.load(url: URL(string: imgURL)!)
      }
    }
  }
  
  
  //MARK: informations lessor
  
  func loadUser() {
    self.startLoading()
    db.collection("users").whereField("uid", isEqualTo: ad!.userID).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      guard let doc = snapshot?.documents.first else { return }
      
      do {
        self.adUser = try doc.data(as: UserModel.self)!
        self.nameLessorLabel.text = "\(NSLocalizedString("lessorName", comment: "")): \(self.adUser!.fullName)"
        self.phoneLabel.text = self.adUser!.phoneNumber
      } catch {
        fatalError(error.localizedDescription)
      }
      self.stopLoading()
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
  
  
  //MARK: user can cshat with whatsAPP
  
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
  
  //MARK: start Message Button
  
  @IBAction func ChatButtonPressed(_ sender: UIButton) {
 
    db.collection("conversations").whereField("usersIds", arrayContainsAny: [user.uid]).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      guard let docs = snapshot?.documents else {
         return
      }
      for doc in docs {
        do {
          let conversation = try doc.data(as: ChatRoom.self)!
          if conversation.usersIds.contains(where: { $0 == self.ad!.userID}) {
            self.gotoConversation(conversation: conversation)
            return
          }
          
        } catch {
          fatalError(error.localizedDescription)
        }
      }
      self.createConversation()
      
    }
    
  }
  
  
  func gotoConversation(conversation: ChatRoom) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
    controller.selectedConversation = conversation
    self.navigationController?.pushViewController(controller, animated: true)
  }
  //MARK: function great conversation
  
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
        
        // segue to chat details -- conversation
        conversation.docID = ref.documentID
        self.gotoConversation(conversation: conversation)
      }
    } catch {
      fatalError(error.localizedDescription)
    }
  }
}


