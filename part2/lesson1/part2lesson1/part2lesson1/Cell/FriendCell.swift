//
//  FriendCell.swift
//  part2lesson1
//
//  Created by Артем Солохин on 19.12.2022.
//

import UIKit

class FriendCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var imageFriend: UIImageView!
    
    
    @IBOutlet weak var friendName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
