//
//  LawBlockPrototypeTableViewCell.swift
//  Civic
//
//  Created by lauren piera on 8/6/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit
import CoreLocation

class LawBlockPrototypeTableViewCell: UITableViewCell {
    
    var billNumber: UILabel=UILabel()
    
    var title: UILabel!=UILabel()
    var billDescription: UILabel!=UILabel()
    var lastActionDate: UILabel!=UILabel()
    var lastAction: UILabel!=UILabel()
    var fullTextButton: UIButton=UIButton()
    var followThisButton: UIButton=UIButton()
    var masterController: LegislationMasterController!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        masterController=LegislationMasterController()
        
        
        billNumber.text="Bill Number"
        billNumber.frame=CGRect(x: 5, y: 5, width: 140, height: 20)
        billNumber.textColor=UIColor.red
        billNumber.font=UIFont(name: "Arial", size: 20)
        followThisButton.setTitle("Follow This", for: UIControlState.normal)
        followThisButton.titleLabel?.textColor=UIColor.white
        followThisButton.frame=CGRect(x: 150, y: 110, width: 135, height: 20)
        followThisButton.backgroundColor=UIColor.darkGray
        contentView.addSubview(followThisButton)
        contentView.addSubview(billNumber)
        title.text="Title"
        title.numberOfLines=0
        title.lineBreakMode=NSLineBreakMode.byWordWrapping
        title.frame=CGRect(x: 5, y: 20, width: self.bounds.width*0.9, height: 40)
        title.textColor=UIColor.red
        title.font=UIFont(name: "Arial", size: 15)
        
        contentView.addSubview(title)
        billDescription.text="Description"
        billDescription.numberOfLines=0
        billDescription.lineBreakMode=NSLineBreakMode.byWordWrapping
        billDescription.font=UIFont(name: "Arial", size: 13)
        billDescription.frame=CGRect(x: 5, y: 60, width: self.bounds.width*0.9, height: 50)
        billNumber.textColor=UIColor.red
        contentView.addSubview(billDescription)
        lastActionDate.text="Last Actiondate"
        lastActionDate.frame=CGRect(x: 20, y: 5, width: 20, height: 5)
        billNumber.textColor=UIColor.red
        contentView.addSubview(lastActionDate)
        lastAction.text="Last Action"
        lastAction.frame=CGRect(x: 25, y: 5, width: 20, height: 5)
        billNumber.textColor=UIColor.red
        contentView.addSubview(lastAction)
        fullTextButton.frame=CGRect(x: 40, y: 110, width: 70, height: 20)
        fullTextButton.backgroundColor=UIColor.green
        fullTextButton.setTitle("Full Text", for: UIControlState.normal)
        contentView.addSubview(fullTextButton)
        
    }

  

}
