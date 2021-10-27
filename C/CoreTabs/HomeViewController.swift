//
//  ViewController.swift
//  BuildInstagramApp
//
//  Created by Bryan on 2021/10/25.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenicated()

    }
    
    private func handleNotAuthenicated(){
        // check auth status
        if Auth.auth().currentUser == nil {
            // show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }else {

        }
    }

}

