//
//  AddRemovePhotoController.swift
//  ChatApp
//
//  Created by Amritpal singh on 02/03/19.
//  Copyright © 2019 Amrit. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class AddRemovePhotoController: UIViewController ,UIImagePickerControllerDelegate ,
UINavigationControllerDelegate{
     let imagePicker = UIImagePickerController()

    @IBOutlet weak var addImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imageValue = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        addImage.image = imageValue
        imagePicker.dismiss(animated: true, completion: nil)
        
        
//        let messageDb = Database.database().reference().child("Image")
//        let image = ["Sender":Auth.auth().currentUser?.email as Any,
//                     "image": imageValue!] as [String : Any]
//        messageDb.childByAutoId().setValue(image){
//            (error, reference) in
//            if(error != nil){
//                print ("Error in saving the iamge to database")
//                SVProgressHUD.showError(withStatus: "unable to change the photo")
//                SVProgressHUD.dismiss(withDelay: 0.5)
//
//            }else{
//                print ("Image is saved successfully")
//                self.dismiss(animated: true, completion: nil)
//                SVProgressHUD.showSuccess(withStatus: "Image saved successfully")
//                SVProgressHUD.dismiss(withDelay: 0.3)
//
//            }
            
       
        
    }
    @IBAction func addImagebutton(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func removePhotoPressed(_ sender: Any) {
        addImage.image = UIImage(named: "user")
    }
    
    @IBAction func deleteAccountPressed(_ sender: Any) {
        SVProgressHUD.showSuccess(withStatus: "Your Acount is deleted")
        SVProgressHUD.dismiss(withDelay: 0.3)
    }
    @IBAction func logouPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print ("There is problem in signing Out \(error)")
        }
    }
}
