//
//  AuthService.swift
//  NewsApp
//
//  Created by Blezin on 21.10.2020.
//  Copyright © 2020 Blezin'sDev. All rights reserved.
//

import Foundation
import VKSdkFramework


protocol AuthServiceDelegate: class {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFailed()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
        
    }
    weak var delegate: AuthServiceDelegate?
    var token: String? {
           return VKSdk.accessToken()?.accessToken
       }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFailed()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
    func wakeUpSession() {
        let scope = ["wall", "friends"]
        VKSdk.wakeUpSession(scope) { [delegate] (status, error) in
            switch status {
                
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
         
            case .authorized:
                print("authorized")
                delegate?.authServiceSignIn()
           default:
                delegate?.authServiceSignInDidFailed()
            }
        }
    }
    
    private let appId = "7638510"
    private let vkSdk: VKSdk
   
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
        print("HELLO")
        delegate?.authServiceSignIn()
    }
    
    
}
