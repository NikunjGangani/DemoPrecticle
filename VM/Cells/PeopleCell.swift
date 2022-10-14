//
//  PeopleCell.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit
import Kingfisher

class PeopleCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var noLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var jobTitleLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(people: People) {
        noLbl.text = "\(people.id)."
        nameLbl.text = "\(people.firstName) \(people.lastName)"
        jobTitleLbl.text = people.jobtitle
        emailLbl.text = people.email
        colorLbl.text = "Favorite color: \(people.favouriteColor.capitalized)"
        imgView.kf.setImage(with: URL(string: people.avatar), placeholder: nil, options: [], completionHandler: nil)
        imgView.layer.borderColor = UIColor.black.cgColor
        imgView.layer.borderWidth = 1
        dateLbl.text = Date.getFormattedDate(string: people.createdAt)
    }
}
