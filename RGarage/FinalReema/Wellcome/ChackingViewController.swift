//
//  ChackingViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 18/06/1443 AH.
//


import UIKit
import Firebase

class ChackingViewController: UIViewController {
  
  override func viewDidAppear(_ animated: Bool) {
    
    //MARK: Save Login user
    
    if let usr = Auth.auth().currentUser {
      self.startLoading()
      let id = usr.uid
      db
        .collection("users")
        .whereField("uid", isEqualTo: id).getDocuments { snapshot, error in
          
        if let error = error {
          fatalError(error.localizedDescription)
        }
          
        if let doc = snapshot?.documents.first {
          do {
            try user = doc.data(as: UserModel.self)
            self.stopLoading()
            let vc = self.storyboard?
              .instantiateViewController(identifier:K
                                          .Storyboard
                                          .tapbarVC)
           self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()

          } catch {
            fatalError(error.localizedDescription)
          }
        }
      }
    }
    else {
      let vc = self.storyboard?
        .instantiateViewController(identifier:K
                                    .Storyboard
                                    .seplashViewController)
      self.view.window?.rootViewController = vc
      self.view.window?.makeKeyAndVisible()

    }
  }
}
