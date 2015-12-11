//
//  LoginViewController.swift
//  liftorum
//
//  Created by Voxy on 12/10/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBAction func textFieldDidChange(sender: AnyObject) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            loginButton.enabled = true
        } else {
            loginButton.enabled = false
        }
    }
    
    @IBAction func login(sender: AnyObject) {
        let completionHandler = {
            (response: Response<AnyObject, NSError>) in
            switch response.result {
            case .Success:
                print(response.result.value!)
            case .Failure:
                print("Error!")
            }
        }
        User.login(
            emailTextField.text!,
            password: passwordTextField.text!,
            completionHandler: completionHandler
        )
    }
}
