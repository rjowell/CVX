//
//  LegislationWindowViewController.swift
//  Civic
//
//  Created by lauren piera on 8/3/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class LegislationWindowViewController: UIViewController {

    
    @IBOutlet weak var TexasLegDisplay: LegislationDisplay!
    
    
    let apiKey: String=""
    let stateAbbr: String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testDisplay: LegislationDisplay=LegislationDisplay(frame: CGRect(x: 5, y: 5, width: 20, height: 5), style: UITableViewStyle.plain, state: "MD")!
        
       // self.view.addSubview(testDisplay as UIView)
        
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
