//
//  LegislationViewCell.swift
//  Civic
//
//  Created by lauren piera on 9/17/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class LegislationViewCell: UITableViewCell {

    @IBOutlet weak var billNumber: UILabel!
    
    @IBOutlet weak var fullTextButton: UIButton!
    
    @IBOutlet weak var followThisButton: UIButton!
    
    @IBOutlet weak var billTitle: UILabel!
    
    
    @IBOutlet weak var billDescription: UILabel!
    
    
    @IBOutlet weak var lastStatusDate: UILabel!
    
    
    @IBOutlet weak var lastStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        billTitle.numberOfLines=0
        billTitle.lineBreakMode=NSLineBreakMode.byWordWrapping
        billDescription.numberOfLines=0
        billDescription.lineBreakMode=NSLineBreakMode.byWordWrapping
        lastStatus.numberOfLines=0
        lastStatus
            .lineBreakMode=NSLineBreakMode.byWordWrapping
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
