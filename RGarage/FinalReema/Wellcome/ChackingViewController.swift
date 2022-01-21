//
//  ChackingViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 18/06/1443 AH.
//


import UIKit
import FirebaseFirestoreSwift
import Firebase

class ChackingViewController: UIViewController {
  override func viewDidAppear(_ animated: Bool) {
    
    //MARK: Save Login user
    if let usr = Auth.auth().currentUser {
      self.startLoading()
      
      let id = usr.uid
      let db = Firestore.firestore()
      
      db.collection("users").whereField("uid", isEqualTo: id).getDocuments { snapshot, error in
        if let error = error {
          fatalError(error.localizedDescription)
        }
        if let doc = snapshot?.documents.first {
          do {
            try user = doc.data(as: UserModel.self)
            self.stopLoading()
            let tapbarVC = self.storyboard?.instantiateViewController(identifier: "TapbarVC") as? TapbarVC
            self.view.window?.rootViewController = tapbarVC
            self.view.window?.makeKeyAndVisible()
          } catch {
            fatalError(error.localizedDescription)
          }
        }
        
      }
    }
    else {
      let ChackingVC = self.storyboard?.instantiateViewController(identifier: "ChackingVC") as? SeplashViewController
      self.view.window?.rootViewController = ChackingVC
      self.view.window?.makeKeyAndVisible()
    }
  }
}
