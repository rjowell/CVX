//
//  RepresentativeViewCell.swift
//  Civic
//
//  Created by lauren piera on 9/11/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class RepresentativeViewCell: UITableViewCell {

    @IBOutlet weak var govTitle: UILabel!
    
    
    @IBOutlet weak var govPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
