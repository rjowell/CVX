//
//  TableViewCell-22.swift
//  CVX Widget
//
//  Created by lauren piera on 11/3/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class TableViewCell_22: UITableViewCell {
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var billNumber: UILabel!
    
    @IBOutlet weak var billTitle: UILabel!
    
    @IBOutlet weak var newStatus: UILabel!
    
    /*@IBOutlet weak var newStatusToday: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var newStatus: UILabel!
    @IBOutlet weak var billNumber: UILabel!
    
    @IBOutlet weak var billTitle: UILabel!*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

