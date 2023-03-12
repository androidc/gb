//
//  CityCell.swift
//  part2lesson1
//
//  Created by Артем on 10.12.2022.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var CityImageView: UIImageView!
    @IBOutlet weak var LabelCity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
