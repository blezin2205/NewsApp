//
//  ViewController.swift
//  NewsApp
//
//  Created by Blezin on 21.10.2020.
//  Copyright © 2020 Blezin'sDev. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
        
    }

    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}

