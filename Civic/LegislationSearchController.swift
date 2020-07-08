//
//  LegislationSearchController.swift
//  Civic
//
//  Created by lauren piera on 9/17/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit
import CoreData




class SaveData: NSObject, NSCoding
{
    
    
    var currentData: [String:Any]?
    var retrievedData: [String:Any]?
    var stateCode: String=""
    
    
    init(state: String, data: [String:Any])
    {
        
        retrievedData=data
        stateCode=state
        
        print("the state in the func is")
        print(stateCode)
        
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(retrievedData, forKey: stateCode+"masterListData")
    }
    
    required init?(coder aDecoder: NSCoder) {
        //self.init(coder: aDecoder)
        
        currentData=aDecoder.decodeObject(forKey: "ilmasterListData") as! [String:Any]
        
        
        
        
    }
    
    
}





class LegislationSearchController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var showTopicSort: UIButton!
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topics.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return topicsArray[row]
    }
    
    @IBOutlet weak var topicGoButton: UIButton!
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        topicSelection=row
    }
    var topicSelection: Int=0
    
    @IBOutlet weak var topicWindow: UIView!
    func sortByCategory(sender: UIButton)
    {
        var searchTerms: [String]=topics[topicsArray[topicSelection]]!
        print(searchTerms)
        
        //var jsonData=try? JSONSerialization.jsonObject(with: currentMasterListData!) as! [String:Any]
         var thisHereData1=currentMasterListData as! [String:Any]
        specificData=thisHereData1["masterlist"] as! [String:Any]
        
        billIDs.removeAll()
        billTitles.removeAll()
        billNumbers.removeAll()
        billDescriptions.removeAll()
        lastActionDates.removeAll()
        lastActions.removeAll()
        
        
        for items in specificData
        {
            if(items.key != "session")
            {
                var currentEntry=items.value as! NSDictionary
                var specificTitle: String=currentEntry["title"] as! String
                var specificDesc: String=currentEntry["description"] as! String
        
                    for terms in searchTerms
                    {
                        if(specificTitle.range(of: terms) != nil || specificDesc.range(of: terms) != nil)
                        {
                            if(billIDs.contains(String(describing: currentEntry["bill_id"])) == false)
                            {
                            
                                billIDs.append(String(describing: currentEntry["bill_id"]))
                            billTitles.append(currentEntry["title"] as! String)
                            billNumbers.append(currentEntry["number"] as! String)
                            billDescriptions.append(currentEntry["description"] as! String)
                            lastActionDates.append(currentEntry["last_action_date"] as! String)
                            lastActions.append(currentEntry["last_action"] as! String)
                            }
                        }
                    }
            }
        }
        
        lawResultsTable.reloadData()
        topicWindow.isHidden=true
    }
    
    func saveStateData()
    {
        let currentContext=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let currentItem=StateData(context: currentContext)
        currentItem.stateName="TX"
        
        
        
    }
    
    @IBOutlet weak var lawResultsTable: UITableView!
    var stateCode: String?
    var searchResults: [String]=[]
    var isSearchWindow: Bool=false
    var stateAbbr: String?
    var stateInformation: [NSManagedObject]=[]
    var masterListURL: String?
    var currentMasterListData: [String:Any]?
    
    var fromMonth: Int=0
    var fromDay: Int=0
    
    let topicsArray: [String]=["Education","Healthcare","Public Safety","Economy","Environment","Women's Issues","LGBT Issues","Government","Immigration","Foreign Policy"]
    let topics: [String:[String]]=["Education":["school","college","education","teacher","student","university","textbook","curriculum","teaching","classrorom"],
                                   "Healthcare":["doctor","patient","healthcare","health care","prescription","medic","hospital","pharma","health","abortion","birth control","contracept","reproduct"],"Public Safety":["police","firefighter","jail","prison","crime","gun control","terror","arrest","sheriff","constable","trooper","criminal","violence","public safety"],"Economy":["economy","jobs","wage","bank","financ","consumer","business"],"Environment":["pollut","eco","sustainab","conservation","environment","natur","organic","preserv"],"Women's Issues":["abortion","pro-choice","pro choice","pro-life","pro life","gyno","pregnan","maternity","equal pay"],"LGBT Issues":["lesbian","gay","bisex","transge","transsex","same-sex","same sex"],"Government":["term limit","legislator","lawmaker","districting","gerrymand"],"Immigration":["immigra","foreign nationals"],"Foreign Policy":["isis","al qaeda","alqaeda","north korea","pyongyang","defense","foreign policy","passport","green card"]]
    
    @IBOutlet weak var goHomeButton: UIButton!
    
    func goHome(sender: UIButton)
    {
        self.view.addSubview(Spinner())
    }
    
    
    @IBOutlet weak var cancelButton: UIButton!
    
    func closeWindow(sender: UIButton)
    {
        searchWindow.isHidden=true
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        
        print("clicked")
        dismissKeyboard()
        closeSearchWindow()
    }
    @IBOutlet weak var dateErrorLabel: UILabel!
    
    
    var toMonth: Int=0
    var toDay: Int=0
    var lastUpdateTime: String?
    var followList: [Int]=[]
    var currentFollowList: [[String]]=[]
    let legiScanUrl="https://api.legiscan.com/?key=438bd89d24f6339ea0adcc17fd06cd58&op=getMasterList&state="
    
    @IBOutlet weak var refreshButton: UIButton!
    
    let stateDictionary: [String:String]=["AL":"Alabama","AK":"Alaska","AR":"Arkansas","AZ":"Arizona","CA":"California","CO":"Colorado","CT":"Connecticut","DE":"Delaware","FL":"Florida","GA":"Georgia","HI":"Hawaii","ID":"Idaho","IL":"Illinois","IN":"Indiana","IA":"Iowa","KS":"Kansas","KY":"Kentucky","LA":"Louisiana","ME":"Maine","MD":"Maryland","MA":"Massachusetts","MI":"Michigan","MN":"Minnesota","MO":"Missouri","MS":"Mississippi","MT":"Montana","NC":"North Carolina","ND":"North Dakota","NE":"Nebraska","NH":"New Hampshire","NJ":"New Jersey","NM":"New Mexico","NV":"Nevada","NY":"New York","OH":"Ohio","OK":"Oklahoma","OR":"Oregon","PA":"Pennsylvania","RI":"Rhode Island","SC":"South Carolina","SD":"South Dakota","TN":"Tennessee","US":"U.S. House & Senate","TX":"Texas","UT":"Utah","VA":"Virginia","VT":"Vermont","WA":"Washington","DC":"Washington, DC","WI":"Wisconsin","WV":"West Virginia","WY":"Wyoming"]
    
    let monthArray: [String]=["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    let daysInMonth: [Int]=[31,28,31,30,31,30,31,31,30,31,30,31]
    
    
    var searchTerms: [String]=[]
    var lawsToMonitor: [String:[String]]=[:]
    var searchTerm: String=""
    
    var billIDs: [String]=[]
    var billNumbers: [String]=[]
    var billTitles: [String]=[]
    var billDescriptions: [String]=[]
    var lastActions: [String]=[]
    var lastActionDates: [String]=[]
    
    var saveFile=UserDefaults.init(suiteName: "group.cvx.sharedData")
    var oldDate: Date?
    
    var specificData: [String:Any]=[:]
    
    
    
    @IBOutlet weak var showAllBills: UIButton!
    
    @IBOutlet weak var searchFieldLabel: UILabel!
    
    @IBOutlet weak var useDateRange: UIButton!
    var wantDateRange: Bool=false
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchThisState: UIButton!
    
    
    @IBOutlet weak var sortButton: UIButton!
    
    
    
    @IBOutlet weak var searchWindow: UIView!
    
    
   
    @IBOutlet weak var topicPicker: UIPickerView!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    
    @IBOutlet weak var ascendingSortButton: UIButton!
    
    @IBOutlet weak var descendingSortButton: UIButton!
    
    @IBOutlet weak var toDayLabel: UITextField!
    @IBOutlet weak var fromDayLabel: UITextField!
    @IBOutlet weak var toMonthLabel: UILabel!
    @IBOutlet weak var fromMonthLabel: UILabel!
    @IBOutlet weak var fromMonthStepper: UIStepper!
    
    @IBOutlet weak var toMonthStepper: UIStepper!
    
    @IBAction func fromValueChanged(_ sender: UIStepper) {
        
        fromMonthLabel.text=monthArray[Int(sender.value)]
        fromMonth=Int(sender.value)
    }
    
    
    @IBAction func toValueChanged(_ sender: UIStepper) {
        
        toMonthLabel.text=monthArray[Int(sender.value)]
        toMonth=Int(sender.value)
    }
    
    func useDateButton(sender: UIButton)
    {
        if(wantDateRange==false)
        {
            sender.backgroundColor=UIColor(red: 165/255, green: 189/255, blue: 229/255, alpha: 1)
            wantDateRange=true
        }
        else
        {
            wantDateRange=false
            sender.backgroundColor=UIColor.white
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func showTopicWindow(sender: UIButton)
    {
        topicWindow.isHidden=false
    }
    func hideTopicWindow(sender: UIButton)
    {
        topicWindow.isHidden=true
    }
    @IBOutlet weak var topicCancelButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        fromMonthStepper.wraps=true
        topicWindow.isHidden=true
        
        topicGoButton.addTarget(self, action: #selector(sortByCategory), for: UIControlEvents.touchDown)
        showTopicSort.addTarget(self, action: #selector(showTopicWindow), for: UIControlEvents.touchDown)
        topicCancelButton.addTarget(self, action: #selector(hideTopicWindow), for: UIControlEvents.touchDown)
        fromMonthStepper.autorepeat=false
        self.view.addSubview(spinner)
        spinner.isHidden=true
        topicPicker.delegate=self
        topicPicker.dataSource=self
        fromMonthStepper.maximumValue=11
        goHomeButton.addTarget(self, action: #selector(goHome), for: UIControlEvents.touchDown)
        dateErrorLabel.isHidden=true
        toMonthStepper.wraps=true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        searchTextField.returnKeyType=UIReturnKeyType.search
        toMonthStepper.autorepeat=false
        toMonthStepper.maximumValue=11
        print("step111")
        lawResultsTable.dataSource=self
        lawResultsTable.delegate=self
        self.view.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        searchWindow.isHidden=true
        searchWindow.layer.borderWidth=3
        print("step112")
        searchWindow.layer.borderColor=UIColor(red: 25/255, green: 45/255, blue: 89/255, alpha: 1.5).cgColor
        searchWindow.layer.zPosition=1
        searchTextField.layer.borderWidth=1
        if(saveFile?.value(forKey: stateCode!+"lastupdatetime") != nil){
            oldDate=saveFile?.value(forKey: stateCode!+"lastupdatetime") as! Date}
        searchThisState.addTarget(self, action: #selector(showSearchWindow), for: UIControlEvents.touchDown)
        searchButton.addTarget(self, action: #selector(closeSearchWindow), for: UIControlEvents.touchDown)
        showAllBills.addTarget(self, action: #selector(loadAllBills), for: UIControlEvents.touchDown)
        ascendingSortButton.addTarget(self, action: #selector(sortByAscending), for: UIControlEvents.touchDown)
        descendingSortButton.addTarget(self, action: #selector(sortByDescending), for: UIControlEvents.touchDown)
        useDateRange.addTarget(self, action: #selector(useDateButton), for: UIControlEvents.touchDown)
        stateLabel.text=stateDictionary[(stateCode?.uppercased())!]
        searchFieldLabel.numberOfLines=0
        searchFieldLabel.lineBreakMode=NSLineBreakMode.byWordWrapping
        for subitems in searchWindow.subviews
        {
            subitems.sizeToFit()
        }
        
        
        if(UserDefaults.init(suiteName: "group.cvx.sharedData")?.value(forKey: "followList") != nil)
        {
            currentFollowList=UserDefaults.init(suiteName: "group.cvx.sharedData")?.value(forKey: "followList") as! [[String]]
            //currentFollowList=saveFile.value(forKey: "followList") as! [[String]]
        }
        print("follow list is")
        print(currentFollowList)
        
        loadAllBills()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(stateCode)
   
        
        print("step11133")
    }
    
    @IBOutlet weak var descendingLabel: UILabel!
    
    
   
    
    
    func addToFollowList(sender: UIButton!)
    {
        
        if(sender.titleLabel?.text=="Unfollow")
        {
            let currentTag=sender.tag
            currentFollowList=currentFollowList.filter {$0[1] != String(sender.tag)}
            sender.setTitle("Follow This", for: UIControlState.normal)
            sender.backgroundColor=UIColor.white
            //sender.setTitleColor(UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5), for: UIControlState.normal)
            print(currentFollowList)
            UserDefaults.init(suiteName: "group.cvx.sharedData")?.set(currentFollowList, forKey: "followList")
        }
        else{
        
        if(currentFollowList.count != 0 && currentFollowList[0][0]=="no data")
        {
            currentFollowList.remove(at: 0)
        }
        
        
        var currentLastAction: Int=billIDs.index(of: "Optional("+String(sender.tag)+")")!
        var currentItem: [String]=[stateCode!.uppercased(),String(sender.tag),lastActionDates[currentLastAction]]
        var tagExists: Bool=false
        
            if(currentFollowList.count != 0 && currentFollowList[0][0] != "no data")
        {
        for entries in currentFollowList
        {
            if(entries[1]==String(sender.tag))
            {
                tagExists=true
            }
            }}
        
        if(tagExists==false)
        {
            currentFollowList.append(currentItem)
        }
        
        sender.setTitle("Unfollow", for: UIControlState.normal)
        //sender.backgroundColor=UIColor(red: 111/255, green: 159/255, blue: 237/255, alpha: 1.0)
        //sender.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        
        }
        UserDefaults.init(suiteName: "group.cvx.sharedData")?.set(currentFollowList, forKey: "followList")
        UserDefaults.init(suiteName: "group.cvx.sharedData")?.synchronize()
        //saveFile.set(currentFollowList, forKey: "followList")
        print(currentFollowList)
    }
    
    func openBillLink(sender: UIButton!)
    {
        
        let urlData=try? Data(contentsOf: URL(string: "https://api.legiscan.com/?key=438bd89d24f6339ea0adcc17fd06cd58&op=getBill&id="+String(sender.tag))!)
        
        var returnData=try? JSONSerialization.jsonObject(with: urlData!) as? [String:Any]
        
        var billData=returnData??["bill"] as? [String:Any]
        
        var billURL=billData?["state_link"] as! String
        var textsURL=billData?["texts"] as! [Any]
        var stateInfoLink=textsURL[0] as! [String:Any]
        var stateTextLink=stateInfoLink["state_link"] as! String
        print(stateTextLink)
        
        UIApplication.shared.open(URL(string: stateTextLink)!, options: [:], completionHandler: nil)
        
        
    }
    var spinner: Spinner=Spinner()
    func sortByAscending(sender: UIButton)
    {
        print("ascending pressed")
        spinner.isHidden=false
        sortbyDate(isAscending: true)
        searchWindow.isHidden=true
        spinner.isHidden=true
    }
    
    func sortByDescending(sender: UIButton)
    {
        print("dscending pressed")
        spinner.isHidden=false
        sortbyDate(isAscending: false)
        searchWindow.isHidden=true
        spinner.isHidden=true
    }
    
    
    
    
    func showSearchWindow(sender: UIButton)
    {
        
        print("pressed")
        searchTerm=""
        searchWindow.isHidden=false
        self.view.bringSubview(toFront: searchWindow)
        searchWindow.sizeToFit()
        //descendingLabel.sizeToFit()
        
    }
    
    func closeSearchWindow()
    {
        
        var proceed: Bool=true
        
        if(wantDateRange==true){
            fromDay=Int(fromDayLabel.text!)!
            toDay=Int(toDayLabel.text!)!
        
        var tempFromDate=(100*fromMonth)+fromDay
        var tempToDate=(100*toMonth)+toDay
            
         if(tempFromDate>=tempToDate)
         {
            proceed=false
            }
            
        }
       
        if(proceed==false)
        {
        
        
        dateErrorLabel.isHidden=false
        
        }
        
        
        else{
      
        searchWindow.isHidden=true
       
        
            if(searchTextField.text != "")
            {
                searchTerm=searchTextField.text!
                searchTerms=searchTerm.components(separatedBy: ",")
                print("terms are")
                print(searchTerms)
                    
                searchLaw(state: stateCode!, searchTerms: searchTerms)
                    
                
                //print(searchResults)
            }
        
        
        
        
        billIDs.removeAll()
        billTitles.removeAll()
        billNumbers.removeAll()
        billDescriptions.removeAll()
        lastActionDates.removeAll()
        lastActions.removeAll()
        
        for numbers in searchResults
        {
            var currentNowData=specificData[numbers] as! NSDictionary
            billDescriptions.append(currentNowData.value(forKey: "description") as! String)
            billNumbers.append(currentNowData.value(forKey: "number") as! String)
            billIDs.append(String(describing: currentNowData.value(forKey: "bill_id")))
            lastActions.append(currentNowData.value(forKey: "last_action") as! String)
            lastActionDates.append(currentNowData.value(forKey: "last_action_date") as! String)
            billTitles.append(currentNowData.value(forKey: "title") as! String)
        }
        
        //print(billTitles)
        
        lawResultsTable.reloadData()}
        
        
    }
    
    func sortbyDate(isAscending:Bool)
    {
        var dateIndex: [String:Int]=[:]
       
        
        //var jsonData=try? JSONSerialization.jsonObject(with: currentMasterListData!) as! [String:Any]
        var thisHereData=currentMasterListData as! [String:Any]
        specificData=thisHereData["masterlist"] as! [String:Any]
        
        for items in specificData
        {
            if(items.key != "session")
            {
                var currentData=items.value as! NSDictionary
                var finalDateString=""
                var currentLastDate=currentData["last_action_date"] as! String
                var compressedDate: [String]=currentLastDate.components(separatedBy: "-")
                for numbers in compressedDate
                {
                    finalDateString.append(numbers)
                }
                dateIndex[items.key]=Int(finalDateString)
            }
        }
        
        //print(dateIndex)
        var newDict: [(key: String, value: Int)]?
        if(isAscending==true)
        {
            newDict=dateIndex.sorted{$1.value < $0.value}
        }
        else
        {
            newDict=dateIndex.sorted{$1.value > $0.value}

        }
        
        
        
            //newDict=dateIndex.sorted{$1.value < $0.value}
        
        print("it sorted dummy")
        //print(newDict)
        searchResults.removeAll()
        //print(newDict)
        for items in newDict!{
            searchResults.append(items.key)
            
        }
        billIDs.removeAll()
        billTitles.removeAll()
        billNumbers.removeAll()
        billDescriptions.removeAll()
        lastActionDates.removeAll()
        lastActions.removeAll()
        
        for numbers in searchResults
        {
            var currentNowData=specificData[numbers] as! NSDictionary
            billDescriptions.append(currentNowData.value(forKey: "description") as! String)
            billNumbers.append(currentNowData.value(forKey: "number") as! String)
            billIDs.append(String(describing: currentNowData.value(forKey: "bill_id")))
            lastActions.append(currentNowData.value(forKey: "last_action") as! String)
            lastActionDates.append(currentNowData.value(forKey: "last_action_date") as! String)
            billTitles.append(currentNowData.value(forKey: "title") as! String)
        }
        lawResultsTable.reloadData()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var constant: CGFloat=17+14+14
        //Bill Number + Status Date + Current Status Label
        var titleLength: CGFloat=CGFloat(((billTitles[indexPath.row].components(separatedBy: " ").count)/9)*14)
        var descriptionLength: CGFloat=CGFloat(((billDescriptions[indexPath.row].components(separatedBy: " ").count)/6)*17)
        var lastStatusLength: CGFloat=CGFloat(((lastActions[indexPath.row].components(separatedBy: " ").count)/9)*16)
        
        return constant+titleLength+descriptionLength+lastStatusLength+130
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell=lawResultsTable.dequeueReusableCell(withIdentifier: "lawViewCell", for: indexPath) as! LegislationViewCell
        
        newCell.billDescription.text=billDescriptions[indexPath.row]
        newCell.billNumber.text=billNumbers[indexPath.row]
        newCell.billTitle.text=billTitles[indexPath.row]
        newCell.lastStatus.text=lastActions[indexPath.row]
        newCell.lastStatusDate.text=lastActionDates[indexPath.row]
        
        var tagString: String=billIDs[indexPath.row]
        var lineIndex=tagString.index(tagString.startIndex, offsetBy: 9)
        var substring1=tagString.substring(from: lineIndex)
        print(substring1)
        var finalString=substring1.substring(to: substring1.index(before: substring1.endIndex))
        print(finalString)
        newCell.fullTextButton.tag=Int(finalString)!
        newCell.fullTextButton.addTarget(self, action: #selector(openBillLink), for: UIControlEvents.touchDown)
        cancelButton.addTarget(self, action: #selector(closeWindow), for: UIControlEvents.touchDown)
        newCell.followThisButton.tag=Int(finalString)!
        newCell.followThisButton.addTarget(self, action: #selector(addToFollowList), for: UIControlEvents.touchDown)
        if(currentFollowList.count==0 || currentFollowList[0][0] != "no data")
        {
        //print(currentFollowList[0][0])
        for items in currentFollowList
        {
            print("look here lauren")
            //print(items[1])
            print(finalString)
            if(items[1]==finalString)
            {
                newCell.followThisButton.setTitle("Unfollow", for: UIControlState.normal)
                //newCell.followThisButton.backgroundColor=UIColor(red: 111/255, green: 159/255, blue: 237/255, alpha: 1.0)
                //newCell.followThisButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            }}
        
        
        
        
        return newCell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func searchLaw(state: String, searchTerms: [String])
    {
        searchResults.removeAll()
        
        
        for things in specificData
        {
            if(things.key != "session")
            {
                var currentData: NSDictionary=things.value as! NSDictionary
                var currentTitle=currentData["title"] as! String
                var currentDesc=currentData["description"] as! String
                
                var currentDates: String=""
                if(type(of: currentData["last_action_date"]!) == NSNull.self)
                {
                    currentDates="N/A"
                    //print("herrrrrrrreeee11")
                }
                else
                {
                    currentDates=currentData["last_action_date"] as! String
                }
                
                
                //var currentDates=currentData["last_action_date"] as! String
                
                var monthStartIndex="0000-00-00".index("0000-00-00".startIndex, offsetBy: 5)
                var dayStartIndex="0000-00-00".index("0000-00-00".startIndex, offsetBy: 8)
                var monthEndIndex="0000-00-00".index("0000-00-00".endIndex, offsetBy: -3)
                var dayEndIndex="0000-00-00".index("0000-00-00".endIndex, offsetBy: 0)
                var monthRange: Range=monthStartIndex..<monthEndIndex
                var dayRange: Range=dayStartIndex..<dayEndIndex
                
                var currentMonth: String=""
                var currentDay: String=""
                if(currentDates=="N/A")
                {
                    currentMonth="N/A"
                    currentDay="N/A"
                }
                else
                {
                
                currentMonth=currentDates.substring(with: monthRange)
                currentDay=currentDates.substring(with: dayRange)
                    
                    
                }
                print("stuff  here")
                print(currentDay)
                print(currentMonth)
                print(wantDateRange)
                var fromDate: Int=(100*fromMonth)+fromDay
                var toDate: Int=(100*toMonth)+toDay
                print("DAte is")
                print(fromDate)
                print(toDate)
                var billDate: Int=0
                if(currentMonth != "N/A" && currentDay != "N/A")
                {
                    print("hello there russ")
                    billDate=Int(currentMonth+currentDay)!-100
                }
                print("bill date is")
                print(billDate)
                for words in searchTerms
                {
                    if(currentTitle.lowercased().range(of: words.lowercased()) == nil)
                    {
                        print("step 1")
                        if(currentDesc.lowercased().range(of: words.lowercased()) != nil)
                        {print("step 2")
                            //print(currentData["bill_id"])
                            
                            if(wantDateRange==true)
                            {print("ste 3333")
                                if(billDate>fromDate && billDate<toDate)
                                {print("step 4444")
                                   searchResults.append(things.key)
                                }
                            }
                            
                            else
                            {
                                print("step 555")
                            searchResults.append(things.key)
                            }
                            
                        }
                    }
                    else
                    {print("3sethere")
                        if(wantDateRange==true)
                        {print("4sethere")
                            if(billDate>fromDate && billDate<toDate)
                            {
                                searchResults.append(things.key)
                            }
                        }
                            
                        else
                        {
                            
                            searchResults.append(things.key)
                        }
                    }
                }
            }
        }
        print("results here")
        //print(searchResults)
    }
    
    
    
    
    
    
    func loadAllBills()
    {
        var lastStateUpdateTime: Date?
        var updateTimeInterval: TimeInterval?
        if(saveFile?.value(forKey: stateCode!+"lastUpdateTime") == nil)
        {
            lastStateUpdateTime=nil
        }
        else
        {
            lastStateUpdateTime=saveFile?.value(forKey: stateCode!+"lastUpdateTime") as! Date
        }
        print("last update time")
        print(lastStateUpdateTime)
        if(lastStateUpdateTime==nil)
        {
            updateTimeInterval=nil
        }
        else
        {
            updateTimeInterval=Date().timeIntervalSince(lastStateUpdateTime!)
        }
        
        
        if(updateTimeInterval != nil && saveFile?.value(forKey: stateCode!+"masterListData") != nil)
        {
            print("hello htere")
            if(updateTimeInterval!<3600)
            {
                print("if this")
                var currentStuff=saveFile?.value(forKey: stateCode!+"masterListData")
                print(type(of: currentMasterListData))
                currentMasterListData=try! JSONSerialization.jsonObject(with: currentStuff as! Data) as! [String:Any]
            }
            else
            {
                print("if this22")
                var thisDataHereElse1=try? Data(contentsOf: URL(string: legiScanUrl+stateCode!)!)
                currentMasterListData=try! JSONSerialization.jsonObject(with: thisDataHereElse1!) as! [String:Any]
                saveFile?.set(Date(), forKey: stateCode!+"lastUpdateTime")
                saveFile?.set(thisDataHereElse1, forKey: stateCode!+"masterListData")
            }
        }
        else
        {
            print("hellow tere")
            var thisDataHereElse2=try? Data(contentsOf: URL(string: legiScanUrl+stateCode!)!)
            
            
            saveFile?.set(Date(), forKey: stateCode!+"lastUpdateTime")
            saveFile?.set(thisDataHereElse2, forKey: stateCode!+"masterListData")
           
            currentMasterListData=try! JSONSerialization.jsonObject(with: thisDataHereElse2!) as! [String:Any]
            
            
            
            //var currentThing: SaveData=SaveData(state: stateCode!, data: currentMasterListData!)
            //print(currentThing.stateCode)
            //let thisDataHere11=NSKeyedArchiver.archivedData(withRootObject: currentThing)
            //saveFile?.set(thisDataHere11, forKey: "lookheredata")
            //var retrieveData=saveFile?.value(forKey: "lookheredata")
            //var almostThere=NSKeyedUnarchiver.unarchiveObject(with: retrieveData as! Data)
           // var thisStuff=NSDictionary(almostThere)
            //print(almostThere)
           
            
        }
        
        print("date begins here")
        var currentStuff=currentMasterListData as! [String:Any]
        //print(currentMasterListData!["masterlist"])
        specificData=currentStuff["masterlist"] as! [String:Any]
        print(specificData.count)
        
       
       // print(currentMasterListData)
        
        billIDs.removeAll()
        billTitles.removeAll()
        billNumbers.removeAll()
        billDescriptions.removeAll()
        lastActionDates.removeAll()
        lastActions.removeAll()
        print("you made it111")
       
            
        
            
            
            //var jsonData=try? JSONSerialization.jsonObject(with: currentMasterListData!) as! [String:Any]
        
            for items in specificData
            {
                if(items.key != "session")
                {
                    //print(items.key)
                    var currentData: NSDictionary=items.value as! NSDictionary
                  
                    
                    
                    //print(currentData["last_action"])
                    billIDs.append(String(describing: currentData["bill_id"]))
                    billNumbers.append(currentData["number"] as! String)
                    billTitles.append(currentData["title"] as! String)
                    billDescriptions.append(currentData["description"] as! String)
                    if(type(of: currentData["last_action"]!) == NSNull.self)
                    {
                        lastActions.append("N/A")
                    }
                    else{
                        lastActions.append(currentData["last_action"] as! String)
                        
                    }
                    if(type(of: currentData["last_action_date"]!) == NSNull.self)
                    {
                        lastActionDates.append("N/A")
                    }
                    else{
                        lastActionDates.append(currentData["last_action_date"] as! String)
                        
                    }
                }
                
                
            }
            //oldDate=Date()
        
            
            
            
        
        
        lawResultsTable.reloadData()
        //print(billIDs)
        //print(billDescriptions)
        
        
        
        
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
