//
//  UserInfoTableViewCell.swift
//  NetworkingWithUrlSession
//
//  Created by Dheeraj Arora on 16/12/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lbluserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblOrganizationName: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblZipCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
