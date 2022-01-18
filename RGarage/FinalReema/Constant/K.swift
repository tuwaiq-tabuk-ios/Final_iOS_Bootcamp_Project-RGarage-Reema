//
//  helper.swift
//  FinalReema
//
//  Created by Reema Mousa on 14/05/1443 AH.
//
import Foundation
import UIKit

//MARK: password conditions
class K {
  static func isPasswordValid(_ password : String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&_])[A-Za-z\\d$@$#!%*?&_]{8,}")
    return passwordTest.evaluate(with: password)
  }
}
