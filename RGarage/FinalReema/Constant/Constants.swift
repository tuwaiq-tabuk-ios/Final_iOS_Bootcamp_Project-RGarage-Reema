//
//  Constants.swift
//  FinalReema
//
//  Created by Reema Mousa on 18/06/1443 AH.
//


import UIKit


struct K {
  
struct Storyboard {
  
  static let signInVC = "SignIn"
  static let signUpVC = "SignUp"
  static let tapbarVC = "TapbarVC"
  static let seplashViewController = "ChackingVC"
  static let forgetPasswordVC = "ForgetPasswordVC"
  static let checkEmailVC = "CheckEmailVC"
  static let welcome = "Wellcome"
  static let updateAccountVC = "UpdateAccountVC"

 }
  
  //MARK: password conditions
  class Password{
    static func isPasswordValid(_ password : String) -> Bool {
      let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&_])[A-Za-z\\d$@$#!%*?&_]{8,}")
      return passwordTest.evaluate(with: password)
    }
}
}
