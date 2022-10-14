//
//  RoomCell.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit

class RoomCell: UITableViewCell {

    @IBOutlet weak var roomNoLbl: UILabel!
    @IBOutlet weak var occupiedLbl: UILabel!
    @IBOutlet weak var maxLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(room: Room) {
        roomNoLbl.text = room.id
        occupiedLbl.text = "Is Occupied? \(room.isOccupied ? "Yes" : "No")"
        maxLbl.text = "Max Occupancy: \(room.maxOccupancy)"
        dateLbl.text = Date.getFormattedDate(string: room.createdAt)
    }
}
