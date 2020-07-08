//
//  Spinner.swift
//  Civic
//
//  Created by lauren piera on 10/16/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class Spinner: UIView {

    let loadingLabel: UILabel=UILabel()
    let spinner: UIActivityIndicatorView=UIActivityIndicatorView()
    //let containerView: UIView=UIView()
    let viewFrame: CGRect=CGRect(x:UIScreen.main.bounds.width/2-60, y: UIScreen.main.bounds.height/2-60, width: 120, height: 120)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame=viewFrame
        self.backgroundColor=UIColor(red: 78/255, green: 106/255, blue: 153/255, alpha: 1)
        loadingLabel.frame=CGRect(x: 20, y: 20, width: 100, height: 25)
        loadingLabel.font=UIFont(name: "AmericanTypewriter", size: 20)
        loadingLabel.textColor=UIColor.white
        self.addSubview(spinner)
        spinner.activityIndicatorViewStyle = .whiteLarge
        self.addSubview(loadingLabel)
        self.addSubview(spinner)
        spinner.frame=CGRect(x: 50, y: 70, width: 20, height: 20)
        spinner.startAnimating()
        loadingLabel.text="Loading"
        spinner.activityIndicatorViewStyle = .whiteLarge
        
        
        
        
    }
   
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
}
