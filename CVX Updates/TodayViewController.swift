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
    
    
    @IBOutlet var resultTable: UITableView!
    
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
        
        
        
        if(currentUpdates.count==0)
        {
            let thisCell=resultTable.dequeueReusableCell(withIdentifier: "widgetBlankCell", for: indexPath) as! WidgetBlankCell
            return thisCell
        }
        
        else if(currentUpdates[0][0]=="no data")
        {
            let thisCell=resultTable.dequeueReusableCell(withIdentifier: "noUpdateCell", for: indexPath) as! NoReminderCell
            return thisCell
            
        }
            
            
            
        else{
            let thisCell=resultTable.dequeueReusableCell(withIdentifier: "widgetCell", for: indexPath) as! TableViewCell_22
            thisCell.stateLabel.text=currentUpdates[indexPath.row][0]
            thisCell.billNumber.text=currentUpdates[indexPath.row][1]
            thisCell.billTitle.text=currentUpdates[indexPath.row][2]
            thisCell.newStatus.text=currentUpdates[indexPath.row][3]
            return thisCell
        }
        
    }
    
    
    
    //var loadFile=UserDefaults.init(suiteName: "group.cvx.main")?.value(forKey: "testEntry") as! String
    
    //var followList=UserDefaults.init(suiteName: "group.cvx.main")?.value(forKey: "followList") as! [[String]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var currentDate=Date()
        //testLabel.text="goodbye charlie"
        //UserDefaults.init(suiteName: "group.cvx.sharedData")?.set("this is a test 123", forKey: "helloTest")
        //print(UserDefaults.init(suiteName: "group.cvx.sharedData")?.value(forKey: "helloTest") as! String)
        //print(UserDefaults.init(suiteName: "group.cvx.sharedData")?.value(forKey: "followList") as! [[String]])
        
        print("it loaded")
        resultTable.delegate=self
        resultTable.dataSource=self
        resultTable.rowHeight=30
        print("step 1")
        
        if(UserDefaults.init(suiteName: "group.cvx.sharedData")?.value(forKey: "followList")==nil)
        {
            currentUpdates.append(["no data"])
            print("step 1-1")
        }
        else
        {
            currentData=UserDefaults.init(suiteName: "group.cvx.sharedData")?.value(forKey: "followList") as! [[String]]
            print("step 1-2")
        }
        
        
        print("step 1-3")
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
        //print(currentData)
        print(currentUpdates)
        if(currentData.count==0 || currentData[0][0]=="no data")
        {
            //currentUpdates.append(["no data"])
        }
        else{print("step -6")
            for things in currentData
            {
                
                if(things.count==3)
                {//currentUpdates.append(things)
                    print("step 1-7")
                    var startIndex="Optional(000000)".index("Optional(000000)".startIndex, offsetBy: 8)
                    let urlData=try? Data(contentsOf: URL(string: legiScanUrl+things[0])!)
                    print("step 1-8")
                    var returnData=try? JSONSerialization.jsonObject(with: urlData!) as? [String:Any]
                    print("step 1-9")
                    var billData=returnData??["masterlist"] as? [String:Any]
                    //print(billData)
                    print("step 1-10")
                    for items in billData!
                    {print("step 1-11")
                        if(items.key != "session")
                        {print("step 1-12")
                            var currentThing=items.value as! [String:Any]
                            var currentNoString: String=String(describing: currentThing["bill_id"])
                            //print(currentNoString[currentNoString.index(currentNoString.startIndex, offsetBy: 9)...currentNoString.index(currentNoString.endIndex, offsetBy: -2)])
                            print("step 1-13")
                            if(things[1]==currentNoString[currentNoString.index(currentNoString.startIndex, offsetBy: 9)...currentNoString.index(currentNoString.endIndex, offsetBy: -2)] && currentCompDay==currentThing["last_action_date"] as! String)
                            {
                                currentUpdates.append([things[0],currentNoString,currentThing["title"] as! String,currentThing["last_status"] as! String])
                            }
                            
                        }
                    }
                }
                
            }}
        print("data is")
        if(currentUpdates.count==0)
        {
            currentUpdates.append(["no data"])
        }
        resultTable.reloadData()
        //print(followList)
        //widgetLabel.text=String(followList[1][0])
        
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

