//
//  MessageCell.swift
//  ChatApp
//
//  Created by Amritpal singh on 02/03/19.
//  Copyright © 2019 Amrit. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet var messageBody : UILabel!
    @IBOutlet var sender : UILabel!
    @IBOutlet var avatarImage : UIImageView!
    @IBOutlet var bgImage : UIView!
    }
    

