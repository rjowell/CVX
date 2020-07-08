//
//  CandidateResultCellTableViewCell.swift
//  Civic
//
//  Created by lauren piera on 9/26/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class CandidateResultCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var phoneLblHgt: NSLayoutConstraint!
    @IBOutlet weak var emailLabelHgt: NSLayoutConstraint!
    @IBOutlet weak var webHeightConst: NSLayoutConstraint!
    @IBOutlet weak var distLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var candidatePhoto: UIImageView!
    @IBOutlet weak var candidateRunningFor: UILabel!
    
    @IBOutlet weak var districtLabel: UILabel!
    
    @IBOutlet weak var candidatePhone: UIButton!
    @IBOutlet weak var candidateEmail: UIButton!
    @IBOutlet weak var candidateWebsite: UIButton!
    @IBOutlet weak var candidateName: UILabel!
    
    @IBOutlet weak var candidateParty: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
