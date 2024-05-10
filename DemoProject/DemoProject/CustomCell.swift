//
//  CustomCell.swift
//  DemoProject
//
//  Created by Nagarjuna on 5/10/24.
//

import UIKit
class CustomCell: UITableViewCell {
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
