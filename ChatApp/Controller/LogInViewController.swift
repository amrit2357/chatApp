//
//  LogInViewController.swift
//  ChatApp
//
//  Created by Amritpal singh on 25/02/19.
//  Copyright © 2019 Amrit. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //MARK : IBActions
    @IBAction func loginButtonPressed(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Loading...")
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){
            (user , error) in
            if error != nil{
                print("error")
                SVProgressHUD.showError(withStatus: "Login Failed try Again")
                SVProgressHUD.dismiss(withDelay: 0.7)
            }else{
                SVProgressHUD.showSuccess(withStatus: "Login Successful")
                self.performSegue(withIdentifier: "goToChatThroughLogin", sender: self)
                SVProgressHUD.dismiss(withDelay: 0.5)
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
