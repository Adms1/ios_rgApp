//
//  RGPostCell.swift
//  rgApp
//
//  Created by ADMS on 27/07/21.
//

import UIKit

class RGPostCell: UITableViewCell {

    @IBOutlet weak var myFeedVw:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDesc:UILabel!
    @IBOutlet weak var lblLikeCount:UILabel!
    @IBOutlet weak var lblshareCount:UILabel!

    @IBOutlet weak var feedImg:UIImageView!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var btnShare:UIButton!
    @IBOutlet weak var btnLike:UIButton!

    @IBOutlet weak var btnLikeList:UIButton!


    @IBOutlet weak var btnComment:UIButton!
    @IBOutlet weak var lblComment:UILabel!

    @IBOutlet weak var videoImg:UIImageView!
    @IBOutlet weak var bitMapVw:UIView!

    @IBOutlet weak var imageLike:UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
