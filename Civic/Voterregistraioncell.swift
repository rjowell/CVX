//
//  voterregistraioncell.swift
//  Civic
//
//  Created by lauren piera on 9/19/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class VoterRegistraionCell: UITableViewCell {

    @IBOutlet weak var stateName: UILabel!
    
    
    @IBOutlet weak var onlineRegistration: UIButton!
    
    @IBOutlet weak var infoLink: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //stateName.text=""
        
        infoLink.setTitle("", for: UIControlState.normal)
        onlineRegistration.isHidden=true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
