//
//  StateLawTableController.swift
//  Civic
//
//  Created by lauren piera on 8/10/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit
import os.log

class StateLawTableController: UITableViewController {

    var stateAbbr: String?
    var masterListURL: String?
    var lastUpdateTime: String?
    var followList: [Int]=[]
    var currentFollowList: [[String]]=[]
    
    
    
    //Variables for each bill
    var billID: [String]=[]
    var billNumber: [String]=[]
    var billTitle: [String]=[]
    var billDescription: [String]=[]
    var lastAction: [String]=[]
    var lastActionDate: [String]=[]
    let saveFile=UserDefaults.standard
    var oldDate: Date?
 
    func addToFollowList(sender: UIButton)
    {
        var dataArray: [String]=billID
        //print(dataArray)
        /*print(type(of: dataArray[1]))
        print(String(sender.tag))
        print(dataArray[1])*/
        var currentLastAction: Int=dataArray.index(of: "Optional("+String(sender.tag)+")")!
        /*print("In is "+String(currentLastAction))
        print(stateAbbr!)
        print(String(sender.tag))
        print(currentLastAction)
        print(lastActionDate[currentLastAction])*/
        var currentItem: [String]=[stateAbbr!,String(sender.tag),lastActionDate[currentLastAction]]
        var tagExists: Bool=false
        
        for entries in currentFollowList
        {
            if(entries[1]==String(sender.tag))
            {
                tagExists=true
            }
        }
        
        if(tagExists==false)
        {
            currentFollowList.append(currentItem)
        }
        
        //followList.append(sender.tag)
        saveFile.set(currentFollowList, forKey: "followList")
        print(currentFollowList)
    }
    
    init(style: UITableViewStyle, state: String) {
        super.init(style: style)
        if(saveFile.value(forKey: "followList") != nil)
        {
        currentFollowList=saveFile.value(forKey: "followList") as! [[String]]
            
        }
        stateAbbr=state
        print("state isss::: "+state)
        if(oldDate==nil)
        {
            oldDate=Date()
        }
        //stateAbbr=masterView.stateCode
        //ReuseID is "newCell"
       
        masterListURL="https://api.legiscan.com/?key=438bd89d24f6339ea0adcc17fd06cd58&op=getMasterList&state="+stateAbbr!
        print(masterListURL)
        //print(saveFile.value(forKey: stateAbbr!+"lastupdatetime"))
         //var oldDate=saveFile.value(forKey: stateAbbr!+"lastupdatetime") as! Date
        
        
        if(saveFile.value(forKey: stateAbbr!+"lastupdatetime") != nil && Date().timeIntervalSince(oldDate!)<900)
        {
       
            billID=(saveFile.value(forKey: stateAbbr!+"billIDs") as? [String])!
            billNumber=saveFile.value(forKey: stateAbbr!+"billNumbers") as! [String]
            billTitle=saveFile.value(forKey: stateAbbr!+"billTitles") as! [String]
            billDescription=saveFile.value(forKey: stateAbbr!+"billDescriptions") as! [String]
            lastAction=saveFile.value(forKey: stateAbbr!+"lastActions") as! [String]
            lastActionDate=saveFile.value(forKey: stateAbbr!+"lastActionDate") as! [String]
       
        }//end of if
        
        else
        {
            do{
                
                let theData=try? Data(contentsOf: URL(string: masterListURL!)!)
                
                var jsonData=try? JSONSerialization.jsonObject(with: theData!) as? [String:Any]
                
                var specificData=jsonData??["masterlist"] as! [String:Any]
                
        
                
                for items in specificData
                {
                    if(items.key != "session")
                    {
                        var currentData: NSDictionary=items.value as! NSDictionary
                        
                        
                        billID.append(String(describing: currentData["bill_id"]))
                        billNumber.append(currentData["number"] as! String)
                        billTitle.append(currentData["title"] as! String)
                        billDescription.append(currentData["description"] as! String)
                        lastAction.append(currentData["last_action"] as! String)
                        lastActionDate.append(currentData["last_action_date"] as! String)
                    }
                }
                oldDate=Date()
                saveFile.set(Date(), forKey: stateAbbr!+"lastupdatetime")
                saveFile.set(billID, forKey: stateAbbr!+"billIDs")
                saveFile.set(billNumber, forKey: stateAbbr!+"billNumbers")
                saveFile.set(billTitle, forKey: stateAbbr!+"billTitles")
                saveFile.set(billDescription, forKey: stateAbbr!+"billDescriptions")
                saveFile.set(lastAction, forKey: stateAbbr!+"lastActions")
                saveFile.set(lastActionDate, forKey: stateAbbr!+"lastActionDate")
                
            }
            catch{
                print("error is \(error)")
            }
            
            
            
            
            print("String :s "+String(describing: billID))
            
            print(billNumber)
            
            
            
            
            
            
            
            
        }
        

        
        
        
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: NSCoder())
        //fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return billID.count
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func openBillLink(sender: UIButton!)
    {
        
        let urlData=try? Data(contentsOf: URL(string: "https://api.legiscan.com/?key=438bd89d24f6339ea0adcc17fd06cd58&op=getBill&id="+String(sender.tag))!)
        
        var returnData=try? JSONSerialization.jsonObject(with: urlData!) as? [String:Any]
        
        var billData=returnData??["bill"] as? [String:Any]
        
        var billURL=billData?["state_link"] as! String
        
        UIApplication.shared.open(URL(string: billURL)!, options: [:], completionHandler: nil)

        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as! LawBlockPrototypeTableViewCell
        
        cell.billNumber.text=billNumber[indexPath.row]
        cell.title.text=billTitle[indexPath.row]
        cell.billDescription.text=billDescription[indexPath.row]
        cell.lastActionDate.text=lastActionDate[indexPath.row]
        cell.lastAction.text=lastAction[indexPath.row]
        print("ID is "+String(describing: billID[indexPath.row]))
        let currentID=billID[indexPath.row]
        print(Int(currentID))
        var lineIndex=currentID.index(currentID.startIndex, offsetBy: 9)
        var substring1=currentID.substring(from: lineIndex)
        var finalString=substring1.substring(to: substring1.index(before: substring1.endIndex))
        print(finalString)
        
        cell.fullTextButton.tag=Int(finalString)!
        var theTag=cell.fullTextButton.tag
        
        //cell.fullTextButton.tag=Int(billID[indexPath.row])!
        //print("ID is "+billID[indexPath.row])
        cell.fullTextButton.addTarget(self, action: #selector(openBillLink(sender:)), for: UIControlEvents.touchDown)
        print(Int(finalString))
        cell.followThisButton.tag=Int(finalString)!
        cell.followThisButton.addTarget(self, action: #selector(addToFollowList), for: UIControlEvents.touchDown)
        
        

        // Configure the cell...

        return cell
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
