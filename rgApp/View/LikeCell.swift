//
//  LikeCell.swift
//  rgApp
//
//  Created by ADMS on 23/08/21.
//

import UIKit

class LikeCell: UITableViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblUserName:UILabel!
    @IBOutlet weak var vwNotification:UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
