//
//  TheElectionCalendar.swift
//  Civic
//
//  Created by lauren piera on 11/22/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class TheElectionCalendar: UIViewController {

    
    var googleURL="https://www.googleapis.com/civicinfo/v2/elections?key=AIzaSyDfeiCRXoUEb2ZNaq9WmgadSmeEKAiCIlw"
    var candidateURL="https://www.googleapis.com/civicinfo/v2/voterinfo?key=AIzaSyDfeiCRXoUEb2ZNaq9WmgadSmeEKAiCIlw"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
