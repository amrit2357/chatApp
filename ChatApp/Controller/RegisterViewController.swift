//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Amritpal singh on 25/02/19.
//  Copyright © 2019 Amrit. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show(withStatus: "Loading...")
        Auth.auth().createUser( withEmail: emailTextField.text! ,password  : passwordTextField.text!){
            (user, error) in
            if error != nil{
                print(error!)
                SVProgressHUD.showError(withStatus: "Failed to Register")
                SVProgressHUD.dismiss(withDelay: 0.7)
            }else{
                // success
                print("registration successfull")
                SVProgressHUD.showSuccess(withStatus: "Registration sucessful")
                self.performSegue(withIdentifier: "goToChatThroughRegister", sender: self)
                SVProgressHUD.dismiss(withDelay: 0.5)
                
            }
        }
        
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
}
