//
//  TodayViewController.swift
//  CVX Widget
//
//  Created by lauren piera on 11/2/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//



import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {
   
    let legiScanUrl="https://api.legiscan.com/?key=438bd89d24f6339ea0adcc17fd06cd58&op=getMasterList&state="
    var monthFormatter: Date?
    var currentUpdates: [[String]]=[]
    var currentData: [[String]]=[]
    var saveData: [[String]]=[]
    
    @IBOutlet weak var resultTable: UITableView!
    
    var textArray: [String]=["hello","goodbye"]
    
    @IBOutlet weak var testLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(currentUpdates.count==0)
        {
            return 1
        }
        else
        {
            return currentUpdates.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if(currentUpdates.count==0 || currentUpdates[0][0]=="no data")
        {
            let thisCell=resultTable.dequeueReusableCell(withIdentifier: "noUpdateCell", for: indexPath) as! NoReminderCell
            return thisCell
        }
        else{
        let thisCell=resultTable.dequeueReusableCell(withIdentifier: "widgetCell", for: indexPath) as! TableViewCell_22
        thisCell.stateLabel.text="TX"
        thisCell.billNumber.text="HB1234"
        thisCell.billTitle.text="A bill to become AWESOME!"
        thisCell.newStatus.text="Sent To Committee"
            return thisCell
        }
        
    }
    
    
    
    var loadFile=UserDefaults.init(suiteName: "group.cvx.main")
    
   //var followList=UserDefaults.init(suiteName: "group.cvx.main")?.value(forKey: "followList") as! [[String]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var currentDate=Date()
        //testLabel.text="goodbye charlie"
       
        currentData=loadFile?.value(forKey: "followList") as! [[String]]
        
        
        
        let calendar=Calendar.current
        var printMonth: String=""
        var printDay: String=""
        var currentYear=String(calendar.component(.year, from: currentDate))
        var currentMonth=calendar.component(.month, from: currentDate)
        var currentDay=calendar.component(.day, from: currentDate)
       
        if(currentDay>9)
        {
            printDay=String(currentDay)
        }
        else
        {
            printDay="0"+String(currentDay)
        }
        var currentCompDay: String=currentYear+"-"+printMonth+"-"+printDay
        print(currentData)
        print(currentUpdates)
        if(currentData.count==0 || currentData[0][0]=="no data")
        {
            currentUpdates.append(["no data"])
        }
        else{
        for things in currentData
        {
            
               if(things.count==3)
               {//currentUpdates.append(things)
                var startIndex="Optional(000000)".index("Optional(000000)".startIndex, offsetBy: 8)
                let urlData=try? Data(contentsOf: URL(string: legiScanUrl+things[0])!)
                var returnData=try? JSONSerialization.jsonObject(with: urlData!) as? [String:Any]
                var billData=returnData??["masterlist"] as? [String:Any]
                for items in billData!
                {
                    if(items.key != "session")
                    {
                        var currentThing=items.value as! [String:Any]
                        var currentNoString: String=String(describing: currentThing["bill_id"])
                        //print(currentNoString[currentNoString.index(currentNoString.startIndex, offsetBy: 9)...currentNoString.index(currentNoString.endIndex, offsetBy: -2)])
                        if(things[1]==currentNoString[currentNoString.index(currentNoString.startIndex, offsetBy: 9)...currentNoString.index(currentNoString.endIndex, offsetBy: -2)] && currentCompDay==currentThing["last_action_date"] as! String)
                        {
                            currentUpdates.append([things[0],currentNoString,currentThing["title"] as! String,currentThing["last_status"] as! String])
                        }
                        
                    }
                }
            }
            
            }}
        
        
        //print(followList)
        //widgetLabel.text=String(followList[1][0])
        print("it loaded")
        resultTable.delegate=self
        resultTable.dataSource=self
        resultTable.rowHeight=25
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
