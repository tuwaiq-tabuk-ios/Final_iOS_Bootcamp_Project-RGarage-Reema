//
//  WelComeViewController.swift
//  FinalReema
//
//  Created by Reema Mousa on 14/06/1443 AH.
//

import UIKit
import FirebaseFirestoreSwift
import Firebase

class WelComeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      if let usr = Auth.auth().currentUser {
        self.startLoading()
        print(usr.uid)
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
              let tapbarVC = self.storyboard?.instantiateViewController(identifier: "tapbarVC") as? tapbarVC
              self.view.window?.rootViewController = tapbarVC
              self.view.window?.makeKeyAndVisible()
            } catch {
              fatalError(error.localizedDescription)
            }
            
          }
          
        }
      }
    }
 

}
