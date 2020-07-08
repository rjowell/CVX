//
//  ElectionCalendarState.swift
//  Civic
//
//  Created by lauren piera on 8/22/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class ElectionCalendarState: UITableViewCell {

    @IBOutlet weak var stateCheckButton: UIButton!
    
    
    
    @IBOutlet weak var stateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
                // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
