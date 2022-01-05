//
//  ChatTableViewCell.swift
//  FinalReema
//
//  Created by Reema Mousa on 30/05/1443 AH.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
  
  @IBOutlet weak var msgBckground: UIView!
  @IBOutlet weak var userEmail: UILabel!
  @IBOutlet weak var userProfile: UIImageView!
  @IBOutlet weak var messageBody: UILabel!
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    // change message bubble corner radius
    
    msgBckground.layer.cornerRadius = messageBody.frame.size.height / 5
    
  }
  enum sender {
    case me
    case other
  }
//  
//  override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//    
//    // Configure the view for the selected state
//  }
//  
//  
//  func getMessageDesign(sender: String)  {
//    
//    
//    var backGroundColor = UIColor()
//    switch sender {
//    case ".me":
//      backGroundColor = .brown
//      msgBckground.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//      messageBody.textAlignment = .right
//    case ".other":
//      backGroundColor = .green
//      
//      msgBckground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
//      messageBody.textAlignment = .left
//      
//    default : break
//    }
//    //      //setting label
//    ////    messageBody.textColor = UIColor.init(named: "textColor")
//    //      //message UI
//    //      var backGroundColor : UIColor?
//    //
//    //      switch sender {
//    //      case .me :
//    //        backGroundColor = . green
//    //        msgBckground.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//    //        messageBody.textAlignment = .right
//    //      case  .other:
//    //          backGroundColor = UIColor.white
//    //
//    //        msgBckground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
//    //        messageBody.textAlignment = .left
//    //
//    //      default:
//    //          print("")
//    //      }
//    //
//    //    msgBckground.backgroundColor = backGroundColor
//    //    msgBckground.layer.shadowOpacity = 0.1
//    //
//    //
//    //  }
//    
  }
