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
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
         // Configure the view for the selected state
    }
}
