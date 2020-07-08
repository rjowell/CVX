//
//  RepresentativeResultCell.swift
//  Civic
//
//  Created by lauren piera on 9/15/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class RepresentativeResultCell: UITableViewCell {

    
    @IBOutlet weak var officeLabel: UILabel!
    
    @IBOutlet weak var repPhoto: UIImageView!
    
    @IBOutlet weak var repName: UILabel!
    
    
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var repWebsite: UIButton!
    @IBOutlet weak var repEmail: UIButton!
    @IBOutlet weak var repPhone: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        officeLabel.numberOfLines=0
        officeLabel.lineBreakMode=NSLineBreakMode.byWordWrapping
        self.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
