//
//  LegislationDisplay.swift
//  Civic
//
//  Created by lauren piera on 8/3/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class LegislationDisplay: UITableViewController {
    
    /* billNumber,title,description,lastActionDate,lastAction*/
    var currentStateData=[[String:String]]()
    
    
    
    
    
    init?(frame: CGRect, style: UITableViewStyle, state: String)
    {
        super.init(style: UITableViewStyle.plain)
        
        let theURL: String="https://api.legiscan.com/?key=438bd89d24f6339ea0adcc17fd06cd58&op=getMasterList&state=TX"
        
        do
        {
            let stateData=try? Data(contentsOf: URL(string: theURL)!)
            
            var jsonData=try? JSONSerialization.jsonObject(with: stateData!) as? [String:Any]
            
            var masterData=jsonData??["masterlist"] as! [String:Any]
            
            for items in masterData
            {
                
                var currentItem=[String:String]()
                if(items.key != "session")
                {
                    
                    var currentData: NSDictionary=items.value as! NSDictionary
                    currentItem["billNumber"]=currentData["number"] as! String
                    currentItem["title"]=currentData["title"] as! String
                    currentItem["description"]=currentData["description"] as! String
                    currentItem["lastActionDate"]=currentData["last_action_date"] as! String
                    currentItem["lastAction"]=currentData["last_action"] as! String
                }
                currentStateData.append(currentItem)
                
                
                
            }
        }
        catch{
            print("error is \(error)")
        }
        
        
        print("hello there2")
        print(currentStateData)
        
        

        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentStateData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=LawBlockPrototypeTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myIdentifier")
        return cell
    }
    
   
    
    
    
   /* required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
