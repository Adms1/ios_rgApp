//
//  CommentCell.swift
//  rgApp
//
//  Created by ADMS on 03/08/21.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var myFeedVw:UIView!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblComment:UILabel!
    @IBOutlet weak var feedImg:UIImageView!
    @IBOutlet weak var btnShare:UIButton!
    @IBOutlet weak var uploadCommentImg:UIImageView!
    @IBOutlet weak var lblFirstLater:UILabel!

    @IBOutlet weak var commentImageHeight:NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
