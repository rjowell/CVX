//
//  ElectionUpdateCell.swift
//  CVX Widget
//
//  Created by lauren piera on 11/3/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class ElectionUpdateCell: UITableViewCell {

    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var electionName: UILabel!
    
    
    @IBOutlet weak var daysLeft: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
