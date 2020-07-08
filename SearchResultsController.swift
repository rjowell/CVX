//
//  SearchResultsController.swift
//  Civic
//
//  Created by lauren piera on 8/29/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {

    
    //var masterController: LegislationMasterController?
    var searchResultString: [String]?
    var stateAbbr: String!
    var specificData: [String:Any]=[:]
    var currentData: NSDictionary!
    var billDescriptions: [String]=[]
    var lastActions: [String]=[]
    var lastActionDates: [String]=[]
    var titles: [String]=[]
    var billIDs: [Int]=[]
    var billNumber: [String]=[]
    var billURL: [String]=[]
    var statusDates: [String]=[]
    //var followList: [Int]=[]
    
    var followList: [[String]]=[]
    var saveList=UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        
    }
    
    func openBillLink(sender: UIButton!)
    {
        
        let urlData=try? Data(contentsOf: URL(string: "https://api.legiscan.com/?key=438bd89d24f6339ea0adcc17fd06cd58&op=getBill&id="+String(sender.tag))!)
        var returnData=try? JSONSerialization.jsonObject(with: urlData!) as? [String:Any]
        var billData=returnData??["bill"] as? [String:Any]
        var billURL=billData?["state_link"] as! String
        UIApplication.shared.open(URL(string: billURL)!, options: [:], completionHandler: nil)
        
        
    }

    
    init(style: UITableViewStyle, searchResults: [String], stateName: String)
    {
        super.init(style: style)
        //saveList=UserDefaults.standard
        print(type(of: saveList.value(forKey: "followList")))
        followList=saveList.value(forKey: "followList") as! [[String]]
        print(followList)
        stateAbbr=stateName
        let masterListURL="https://api.legiscan.com/?key=438bd89d24f6339ea0adcc17fd06cd58&op=getMasterList&state="+stateAbbr!
        let theData=try? Data(contentsOf: URL(string: masterListURL)!)
        var jsonData=try? JSONSerialization.jsonObject(with: theData!) as? [String:Any]
        specificData=jsonData??["masterlist"] as! [String:Any]
       
        //print("you're here")
        //print(searchResultString)
        searchResultString=searchResults
        
        
        for numbers in searchResultString!
        {
            var currentRecord: NSDictionary=specificData[numbers]! as! NSDictionary
            billDescriptions.append(currentRecord.value(forKey: "description") as! String)
            billNumber.append(currentRecord.value(forKey: "number") as! String)
            billIDs.append(currentRecord.value(forKey: "bill_id") as! Int)
            lastActions.append(currentRecord.value(forKey: "last_action") as! String)
            lastActionDates.append(currentRecord.value(forKey: "last_action_date") as! String)
            titles.append(currentRecord.value(forKey: "title") as! String)
            
            
            
            
            
        }
        
        //print(billIDs)
        //print(titles)
        
    }
    
    func addToFollowList(sender: UIButton)
    {
        /*
        for items in followList
        {
            if(followList.index(of: items) == nil)
            {
                followList.append(String(sender.tag))
            }
        }*/
        
        
        
        saveList.set(followList, forKey: "followList")
        
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
self.init(coder: NSCoder())    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultString!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as! LawBlockPrototypeTableViewCell
        cell.billDescription.text=billDescriptions[indexPath.row]
        cell.billNumber.text=billNumber[indexPath.row]
        cell.title.text=titles[indexPath.row]
        cell.lastAction.text=lastActions[indexPath.row]
        cell.lastActionDate.text=lastActionDates[indexPath.row]
        cell.fullTextButton.tag=billIDs[indexPath.row] as! Int
        cell.fullTextButton.addTarget(self, action: #selector(openBillLink), for: UIControlEvents.touchDown)
        cell.followThisButton.tag=billIDs[indexPath.row] as! Int
        cell.followThisButton.addTarget(self, action: #selector(addToFollowList), for: UIControlEvents.touchDown)
        
        //var name=specificData[String(indexPath.row)]
        
        
                return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
