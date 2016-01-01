//
//  LoginViewController.swift
//  liftorum
//
//  Created by Voxy on 12/10/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var errorTextField: UILabel!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad(){
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
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
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(
                    response.result.value!["access_token"],
                    forKey: "accessToken"
                )
                defaults.setObject(
                    response.result.value!["user_id"],
                    forKey: "userId"
                )
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyBoard.instantiateInitialViewController()
                self.presentViewController(initialViewController!, animated: true, completion: nil)
            case .Failure:
                if response.response?.statusCode == 401 {
                    let alert = UIAlertController(
                        title: "Invalid email or password",
                        message: "The username and password combination doesn't appear to belong to an account. Please try again.",
                        preferredStyle: UIAlertControllerStyle.Alert
                    )
                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    print("Error!")
                }
            }
            
        }
        User.login(
            emailTextField.text!,
            password: passwordTextField.text!,
            completionHandler: completionHandler
        )
    }
}
