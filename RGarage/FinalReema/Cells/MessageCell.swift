//
//  messageCell.swift
//  FinalReema
//
//  Created by Reema Mousa on 24/05/1443 AH.
//

import UIKit

class MessageCell: UITableViewCell {
  
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var messageBubble: UIView!
  

  
  enum sender {
    case me , other
  }
  
//MARK: Design Chat for me and other
  
  func getMessageDesign (sender:sender){
    var backGroundColor : UIColor?
    switch sender{
    case .me :
      backGroundColor  = .gray
      messageBubble.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMaxYCorner,.layerMaxXMaxYCorner ]
      messageLabel.textAlignment = .right
    case .other :
      backGroundColor = .systemYellow
      messageBubble.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMaxYCorner , .layerMaxXMinYCorner]
      messageLabel.textAlignment = .left
    }
    
    
    messageBubble.backgroundColor = backGroundColor
    messageBubble.layer.cornerRadius = messageLabel.frame.size.height/2.5
    messageBubble.layer.shadowOpacity = 0.1
    
    
  }
}

