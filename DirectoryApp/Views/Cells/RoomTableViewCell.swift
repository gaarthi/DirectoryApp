//
//  RoomTableViewCell.swift
//  DirectoryApp
//
//  Created by Aarthi on 02/11/22.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

    @IBOutlet weak var roomID: UILabel!
    @IBOutlet weak var maxOccupancy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
