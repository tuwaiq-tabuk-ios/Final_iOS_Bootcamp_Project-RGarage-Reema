//
//  messageCell.swift
//  FinalReema
//
//  Created by Reema Mousa on 24/05/1443 AH.
//

import UIKit

class messageCell: UITableViewCell {
  
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var messageBubble: UIView!
  
 
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
   }

  enum sender {
    case me , other
  }
   
  func getMessageDesign (sender:sender){
    var backGroundColor : UIColor?
    switch sender{
    case .me :
      backGroundColor  = .gray
      messageBubble.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMaxYCorner,.layerMaxXMaxYCorner ]
      textLabel?.textAlignment = .right
    case .other :
      backGroundColor = .systemYellow
      messageBubble.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMaxYCorner , .layerMaxXMinYCorner]
      textLabel?.textAlignment = .left
    }
    
    messageBubble.backgroundColor = backGroundColor
    messageBubble.layer.cornerRadius = messageLabel.frame.size.height/2.5
    messageBubble.layer.shadowOpacity = 0.1
     
  }
}
