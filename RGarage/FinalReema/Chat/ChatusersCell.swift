//
//  ChatusersCell.swift
//  FinalReema
//
//  Created by Reema Mousa on 08/06/1443 AH.
//

import UIKit

class ChatusersCell: UITableViewCell {

  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var imageUser: UIImageView!
  @IBOutlet weak var lastmessageLabel : UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    imageUser.layer.cornerRadius = 20
    }
     override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
         // Configure the view for the selected state
    }
}
 
