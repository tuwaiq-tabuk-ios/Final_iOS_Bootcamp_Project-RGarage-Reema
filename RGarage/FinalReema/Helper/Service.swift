//
//  Service.swift
//  FinalReema
//
//  Created by Reema Mousa on 15/05/1443 AH.
//

import Foundation
import UIKit

//MARK: ALert

class Service{
  
  static func createAlertController(title : String,
                                     message: String) -> UIAlertController {
    
    let alert = UIAlertController(title: title, message: message
                                  , preferredStyle: .alert)
    
    let okAction  = UIAlertAction(title: "OK"
                                  , style: .default){(action) in
      alert.dismiss(animated: true
                    , completion: nil)
  
    }
    
    alert.addAction(okAction)
    
    return alert
  }
}
