//
//  MainWindowCellTableViewCell.swift
//  Civic
//
//  Created by lauren piera on 8/30/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class MainWindowCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.addSubview(mainTextLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
