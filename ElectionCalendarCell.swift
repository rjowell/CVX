//
//  ElectionCalendarCell.swift
//  Civic
//
//  Created by lauren piera on 8/20/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class ElectionCalendarCell: UITableViewCell {

    @IBOutlet weak var dateNumber: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var electionButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var stageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stageLabel.numberOfLines=0
        stageLabel.lineBreakMode=NSLineBreakMode.byWordWrapping
        electionButton.titleLabel?.numberOfLines=0
        electionButton.titleLabel?.lineBreakMode=NSLineBreakMode.byWordWrapping
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
