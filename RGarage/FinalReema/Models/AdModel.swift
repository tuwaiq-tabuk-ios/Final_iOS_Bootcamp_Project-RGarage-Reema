//
//  AdModel.swift
//  FinalReema
//
//  Created by Reema Mousa on 14/06/1443 AH.
//

import Foundation


struct AdModel: Codable {
  
  var id: String
  var userID: String
  var price: Double
  var address: String
  var date: Date
  var imageURL: String?
  
}
