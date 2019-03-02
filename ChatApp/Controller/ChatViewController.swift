//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Amritpal singh  on 25/02/19.
//  Copyright © 2019 Amrit. All rights reserved.
//

import UIKit
import Firebase
class ChatViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, UITextFieldDelegate{
    
    var messageArray : [Message] = [Message]()
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.delegate = self
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.separatorStyle = .none
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        
        
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        
        retrieveMessage()
        configureTableView()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    func configureTableView(){
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 75
    }
    @IBAction func logouPressed(_ sender: Any) {
        do{
        try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print ("There is problem in signing Out \(error)")
        }
    }
    @IBAction func sendButtonPressed(_ sender: Any) {
        // message saved to the firebase
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false

        let messageDb = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender":Auth.auth().currentUser?.email,
                                 "MessageBody":messageTextField.text!]
        messageDb.childByAutoId().setValue(messageDictionary){
            (error, reference) in
                if error != nil {
                    print ("error in saving the message")
                }else{
                    print("Message send successfully")
                    self.messageTextField.isEnabled = true
                    self.sendButton.isEnabled = true
                    self.messageTextField.text = ""
                }

        }

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4){
            self.heightConstraint.constant = 410
            print("start editing")
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4){
            self.heightConstraint.constant = 85
            self.view.layoutIfNeeded()
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell",for : indexPath) as! MessageCell
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.sender.text = messageArray[indexPath.row].sender
        cell.avatarImage.image = UIImage(named: "user")
        return cell
    }
    
    @objc func tableViewTapped(){
        print("tapped")
        messageTextField.endEditing(true)
    }
    
    
    func retrieveMessage(){
        
    let messagedb = Database.database().reference().child("Messages")
        messagedb.observe(.childAdded){
            (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            let message = Message()
            
            message.messageBody = text
            message.sender = sender
            self.messageArray.append(message)
            
            self.configureTableView()
            self.messageTableView.reloadData()
            
        }
    }
    
}
