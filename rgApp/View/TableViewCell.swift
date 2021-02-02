//
//  TableViewCell.swift
//  Test
//
//  Created by BHARGAV on 04/12/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
class HeaderCommentTableViewCell: UITableViewCell {
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblcommentedBy:UILabel!
    @IBOutlet var lblDate:UILabel!
    @IBOutlet var viewBG:UIView!
    @IBOutlet var viewBGH:UIView!
    @IBOutlet var myStackView:UIStackView!
    @IBOutlet var myStackViewButton:UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
class ListTableViewCell: UITableViewCell {
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var viewBG:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
