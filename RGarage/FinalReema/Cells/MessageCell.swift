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
  @IBOutlet weak var timeSendMsg: UILabel!
    
  enum sender {
    case me , other
  }
  
//MARK: Design Chat for me and other
  
  func getMessageDesign (sender:sender){
    var backGroundColor : UIColor?
    switch sender{
    case .other :
      backGroundColor  = UIColor.otherMessage
      messageBubble.layer.maskedCorners = [.layerMinXMaxYCorner
                                           ,.layerMinXMaxYCorner
                                           ,.layerMinXMaxYCorner ]
      messageBubble.layer.borderWidth = 1
      messageLabel.textAlignment = .right
   
    case .me :
      backGroundColor = UIColor.meMessage
      messageBubble.layer.maskedCorners = [.layerMaxXMaxYCorner
                                           ,.layerMaxXMaxYCorner
                                           ,.layerMaxXMinYCorner]
      messageBubble.layer.borderWidth = 1
      messageLabel.textAlignment = .left
    }
    messageBubble.backgroundColor = backGroundColor
    messageBubble.layer.cornerRadius = 20
    messageBubble.layer.shadowOpacity = 0.1
  }
  
  override func layoutSubviews() {
      super.layoutSubviews()

      contentView.frame = contentView
                   .frame.inset(by: UIEdgeInsets(top: 5
                                                 , left: 0
                                                 , bottom: 5
                                                 , right: 0))
  }

}

