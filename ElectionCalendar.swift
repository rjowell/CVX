//
//  ElectionCalendar.swift
//  Civic
//
//  Created by lauren piera on 8/18/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit
import EventKit

class ElectionCalendar: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var calendarTable: UITableView!
    
    var currentDate: Date=Date()
    //var calendar1=Calendar.current
    var currentYear: String=""
    
    @IBOutlet weak var welcomeWindow: UIView!
    
    @IBOutlet weak var showHelp: UIButton!
    @IBOutlet weak var welcomeCloseButton: UIButton!
    @IBOutlet weak var noticeLabel: UILabel!
    
    func closeHelp(sender: UIButton)
    {
            welcomeWindow.isHidden=true
    }
    func showHelpWindow(sender: UIButton)
    {
        welcomeWindow.isHidden=false
    }
    var stateAbbr: [String]=[]
    var electionIDnum: Int=0
    var sectionCounts: [Int:Int]=[0:0,1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0]
    var electionsInArray: [String]=[]
    var electionsToMonitor: [[String]]=[]
    var sampleURL: String=""
    var currentState=""
    var currentMonth: String=""
    var currentDay: String=""
    var dataStore=UserDefaults.init(suiteName: "group.cvx.sharedData")
    var saveList: [[String]]=[]
    var electionName: String=""
    var monthList: [String]=["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if (segue.identifier=="candidateWindow")
        {
            if let CandidateViewer=segue.destination as? CandidateViewer
            {
            CandidateViewer.electionNumber=electionIDnum
            CandidateViewer.electionName=electionName
            print("here")
            }
        }
        
        else{
        if let ElectionCalendarStateList=segue.destination as? ElectionCalendarStateList
        {
            ElectionCalendarStateList.selectedStates.removeAll()
            ElectionCalendarStateList.selectedStates=stateAbbr
            print("this iss")
            }}
        
        
    }
    
    
    let eventsStore: EKEventStore=EKEventStore()
  
    var electionData: [String:Any]=[:]
    var foundCharacters: String=""
    var generalInfo=""
    var stateStore=UserDefaults.standard
    var electionArray: [Election]=[]
    var electionItem: Election?
    var electionStageItem: ElectionStage?
    var dataParser: XMLParser?
    var calendarData: [String:[Election]] = [:]
    var calendarInfo: [Int:[CalendarItem]]=[0:[],1:[],2:[],3:[],4:[],5:[],6:[],7:[],8:[],9:[],10:[],11:[]]
    var stringIndex="thisisateststring".index("thisisateststring".startIndex, offsetBy: 3)
    var electionStringIndex="thisisateststring".index("thisisateststring".startIndex, offsetBy: 4)
    var dateStringEndIndex="1111-11-11".index("1111-11-11".endIndex, offsetBy: -2)
    var monthStringEndIndex="1111-11-11".index("1111-11-11".endIndex, offsetBy: -3)
    var dateStringStartIndex="1111-11-11".index("1111-11-11".startIndex, offsetBy: 5)
    var monthIndexPath: [Int:IndexPath]=[:]
    var totalRows=12
    var offsetCount: Int=0
    var notInArray: Bool=false
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return monthList[section+Int(currentMonth)!-1]
    }
    
    func addToCalendar(sender: UIButton)
    {var separateIndex=sender.accessibilityLabel!.index(of: "-")
        print("initial list")
        print(saveList)
        if(sender.titleLabel?.text=="Unfollow")
        {
            print("unfollow this")
            //saveList.removeAll()
            
            var currentSection: Int=Int((sender.accessibilityLabel?.substring(to: separateIndex!))!)!
            var currentRow: Int=Int(String((sender.accessibilityLabel?.substring(from: separateIndex!).dropFirst())!))!
            var currentState: String=(calendarInfo[currentSection-1]?[sender.tag%10].electionState)!
            var currentStage: String=(calendarInfo[currentSection-1]?[sender.tag%10].electionStage)!
            var currentName: String=(calendarInfo[currentSection-1]?[sender.tag%10].electionName)!
            
            for index in 0...saveList.count-1
            {
                print("index is")
                print(index)
                /*print("compare here")
                print(currentState)
                print(saveList[index][0])
                print(currentStage)
                print(saveList[index][1])
                print(currentName)
                print(saveList[index][2])*/
                if(saveList[index][0]==currentState && saveList[index][1]==currentStage && saveList[index][2]==currentName)
                {
                    saveList.remove(at: index)
                    print("remove here")
                    break
                }
            }
            
            sender.setTitle("Add To Calendar", for: UIControlState.normal)
            dataStore?.set(saveList, forKey: "followList")
            
            //calendarInfo[currentSection-1]?.remove(at: currentRow)
            print(calendarInfo)
            
            print(saveList)
            
        }
        else{
            var section: Int=Int((sender.accessibilityLabel?.substring(to: separateIndex!))!)!
            var row: Int=Int(String((sender.accessibilityLabel?.substring(from: separateIndex!).dropFirst())!))!
        
        var newItem: [String]=[]
            print(calendarInfo[section-1]?[row].electionState)
        newItem.append((calendarInfo[section-1]?[row].electionState)!)
        newItem.append((calendarInfo[section-1]?[row].electionStage)!)
        
        newItem.append((calendarInfo[section-1]?[row].electionName)!)
        newItem.append(String(describing: calendarInfo[section-1]?[row].electionMonth))
        newItem.append(String(describing: calendarInfo[section-1]?[row].electionDay))
        var addToCal: Bool=true
        print(saveList)
        for items in saveList
        {
            if(items.index(of: (calendarInfo[section-1]?[row].electionName)!) != nil && items.index(of: (calendarInfo[section-1]?[row].electionStage)! ) != nil)
            {
                addToCal=false
                print("its false")
            }
        }
        
        if(addToCal==true)
        {
        saveList.append(newItem)
            dataStore?.set(saveList, forKey: "followList")
        print(saveList)
        
        
        
        eventsStore.requestAccess(to: .event) { (granted, error) in
            if(granted) && (error==nil)
            {
                
                let event: EKEvent=EKEvent(eventStore: self.eventsStore)
                event.calendar=self.eventsStore.defaultCalendarForNewEvents
                let electionDay=self.calendarInfo[section-1]?[row].electionDay
                
                let dateFormatter=DateFormatter()
                dateFormatter.timeZone=TimeZone(abbreviation: "EDT")
                dateFormatter.dateFormat="yyyy/MM/dd HH:mm"
                
                let thestartDate=dateFormatter.date(from: self.currentYear+"/"+String(section)+"/"+String(electionDay!)+" 00:01")
                let theendDate=dateFormatter.date(from: self.currentYear+"/"+String(section)+"/"+String(electionDay!)+" 23:59")
                
                
                event.title=(self.calendarInfo[section-1]?[row].electionName)!+" - "+(self.calendarInfo[section-1]?[row].electionStage)!
                event.startDate=thestartDate!
                event.endDate=theendDate!
                do
                {
                    try self.eventsStore.save(event, span: .thisEvent)
                }
                catch let error as NSError
                {
                    print("failed to save event with error : \(error)")
                }
                print("events sved")
            }//end of if granted
            else{
                
                print("failed to save event with error : \(error) or access not granted")
            }
            }//end of event store
            sender.setTitle("Unfollow", for: UIControlState.normal)
        }//end of if add to cal
        
        
        
        
            print(sender.tag)}
    }//end of button process
    
    func openCandidateWindow(sender: UIButton)
    {
        self.view.addSubview(Spinner())
        electionIDnum=sender.tag
        electionName=(sender.titleLabel?.text)!
        print(sender.tag)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        print("section")
        print(section+Int(currentMonth)!-1)
        var currentItem: [CalendarItem]=calendarInfo[section+Int(currentMonth)!-1]!
        return currentItem.count
      
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 12-(Int(currentMonth)!-1)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let electionCell=calendarTable.dequeueReusableCell(withIdentifier: "electionCalendarCell", for: indexPath) as! ElectionCalendarCell
       
        var electionName: String=""
        var lastCell: [ElectionCalendarCell]=[]
        //print("this number is")
        //print(indexPath.section+Int(currentMonth)!-1)
        var currentElectionItem: CalendarItem=calendarInfo[indexPath.section+Int(currentMonth)!-1]![indexPath.row]
        
        electionCell.electionButton.addTarget(self, action: #selector(openCandidateWindow), for: UIControlEvents.touchDown)
        electionCell.electionButton.setTitle(currentElectionItem.electionName, for: UIControlState.normal)
        electionCell.electionButton.tag=Int(currentElectionItem.electionID.trimmingCharacters(in: .whitespaces))!
        
        electionCell.stageLabel.text=currentElectionItem.electionStage
        
        electionCell.stateLabel.text=currentElectionItem.electionState
        
        electionCell.calendarButton.tag=Int(String(currentElectionItem.electionMonth)+String(indexPath.row))!
        
        electionCell.calendarButton.accessibilityLabel=String(currentElectionItem.electionMonth)+"-"+String(indexPath.row)
        var itExists: Bool=false
        for items in saveList
        {
            if(items.count==5)
            {
                if(items[0]==currentElectionItem.electionState && items[1]==currentElectionItem.electionStage && items[2]==currentElectionItem.electionName)
                {
                    itExists=true
                    print("its already here")
                }
            }
        }
        if(itExists==true)
        {
            electionCell.calendarButton.setTitle("Unfollow", for: UIControlState.normal)
            //electionCell.calendarButton.backgroundColor=UIColor.green
            electionCell.calendarButton.addTarget(self, action: #selector(addToCalendar), for: UIControlEvents.touchDown)
        }
        else
        {
        electionCell.calendarButton.addTarget(self, action: #selector(addToCalendar), for: UIControlEvents.touchDown)
        }
        electionCell.dateNumber.text=String(currentElectionItem.electionDay)
        
    
        
        return electionCell
        
        
        
        
        
        
        
    }
   
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor=UIColor(red: 222/255, green: 232/255, blue: 249/255, alpha: 1)
        header?.tintColor=UIColor(red: 28/255, green: 38/255, blue: 53/255, alpha: 1)
        header?.textLabel?.font=UIFont(name: "AmericanTypewriter", size: 18)
        header?.textLabel?.textAlignment = .center
    }
  
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        welcomeWindow.isHidden=true
        if(stateStore.array(forKey: "savedStates") != nil)
        {
            stateAbbr=stateStore.array(forKey: "savedStates") as! [String]
        }
        if(dataStore?.array(forKey: "followList") != nil)
       {
        saveList=dataStore?.array(forKey: "followList") as! [[String]]
        }
        //print(stateAbbr)
        //print(electionArray)
        print("taaada")
        print(saveList)
        let currentDate=Date()
        let formatter=DateFormatter()
        let dayFormatter=DateFormatter()
        showHelp.addTarget(self, action: #selector(showHelpWindow), for: UIControlEvents.touchDown)
        welcomeCloseButton.addTarget(self, action: #selector(closeHelp), for: UIControlEvents.touchDown)
        let yearFormatter=DateFormatter()
        formatter.dateFormat="MM"
        yearFormatter.dateFormat="yyyy"
        dayFormatter.dateFormat="dd"
        currentYear=yearFormatter.string(from: currentDate)
        print("year is "+currentYear)
        currentDay=dayFormatter.string(from: currentDate)
        //print("date is "+formatter.string(from: currentDate))
        currentMonth=formatter.string(from: currentDate)
        let dateMonthRange=dateStringStartIndex..<monthStringEndIndex
       // noticeLabel.numberOfLines=0
        //print("here1")
       // noticeLabel.lineBreakMode=NSLineBreakMode.byWordWrapping
        //print("here2")
        self.view.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        //print("here3")
        calendarTable.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
       
        
        
        for states in stateAbbr
        {
            currentState=states
            
            sampleURL="http://api.votesmart.org/Election.getElectionByYearState?key=6b633e49549b6c63c659be06c2ee75f9&year="+currentYear+"&stateId="+states
            print(sampleURL)
            dataParser=XMLParser(contentsOf: URL(string: sampleURL)!)
            dataParser?.delegate=self
            dataParser?.parse()
            calendarData[states]=electionArray
            
            electionArray.removeAll()
        }
        
        
        
       print(calendarData["GA"])
        print("here count   ")
        print(calendarData.count)
        
        for things in calendarData
        {
            for smallerThings in things.value
            {
                
                //print(smallerThings.electionStage.count)
                
                
                
                for stages in smallerThings.electionStage
                {
                    stages.day=Int(stages.electionDate.substring(from: dateStringEndIndex))
                    stages.month=Int(stages.electionDate.substring(with: dateMonthRange))
                }
            }
        }
        
        for items in calendarData
        {
            for elections in items.value
            {
                for stages in elections.electionStage
                {
                    
                    var currentItem=CalendarItem()
                    var currentKey=stages.month-1
                    currentItem.electionMonth=stages.month
                    currentItem.electionDay=stages.day
                    currentItem.electionName=elections.name
                    currentItem.electionStage=stages.name
                    currentItem.electionState=stages.state
                    currentItem.electionStageID=stages.electionStageID
                    currentItem.electionID=elections.electionID
                    print("Id is")
                    print(currentItem.electionID)
                    
                    print(Int(currentMonth)!)
                    print("------month")
                    print(currentItem.electionMonth)
                    print(currentItem.electionDay)
                    
                    
                    if(currentItem.electionMonth>Int(currentMonth)!)
                    {
                        print(Int(currentMonth)!)
                        print("month")
                        print(currentItem.electionMonth)
                        
                        
                            print(Int(currentDay)!)
                            print("month---")
                            print(currentItem.electionDay)
                            if(calendarInfo[currentKey]?.count==0)
                            {
                                        calendarInfo[currentKey]=[currentItem]
                            }
                                else
                                {
                        
                                calendarInfo[currentKey]?.append(currentItem)
                        
                                }
                        
                        
                    }
                    else
                    {
                            if(currentItem.electionMonth==Int(currentMonth)! && currentItem.electionDay>=Int(currentDay)!)
                            {
                                if(calendarInfo[currentKey]?.count==0)
                                {
                                    calendarInfo[currentKey]=[currentItem]
                                }
                                else
                                {
                                    
                                    calendarInfo[currentKey]?.append(currentItem)
                                    
                                }
                        }
                    }
                    
                    print("cal here")
                    print(calendarInfo)
                }
            }
            
            for items in calendarInfo
            {
                //print(items.value.count)
            }
        }
        
        
        
        
        for index in 1...12
        {
            if(calendarInfo[index] != nil)
            {
           
                
                calendarInfo[index]?.sort(by: { (itemOne: CalendarItem, itemTwo: CalendarItem) -> Bool in
                    return itemOne.electionDay < itemTwo.electionDay
                })
                
            }
        }
        
        //print(calendarInfo.keys)
       
        //print(calendarInfo.count)
        calendarTable.delegate=self
        calendarTable.dataSource=self
        calendarTable.reloadData()
        
    }
    
    class Election
    {
        var electionID: StringLiteralType!
        var name: StringLiteralType!
        var state: StringLiteralType!
        var typeID: StringLiteralType!
        var special: StringLiteralType!
        var year: StringLiteralType!
        var electionStage: [ElectionStage]=[]
    }
    
    class CalendarItem: NSObject
    {
        var electionDay: Int!
        var electionMonth: Int!
        var electionName: String!
        var electionStage: String!
        var electionState: String!
        var electionStageID: String!
        var electionID: String!
    }
    
    class ElectionStage
    {
        var stageID: StringLiteralType!
        var electionStageID: StringLiteralType!
        var name: StringLiteralType!
        var state: StringLiteralType!
        var electionDate: StringLiteralType!
        var month: Int!
        var day: Int!
        //var filingDeadline: String?
        var npatMail: StringLiteralType!
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        if(elementName=="election")
        {
            electionItem=Election()
        }
        if(elementName=="stage")
        {
            electionStageItem=ElectionStage()
            electionItem?.electionStage.append(electionStageItem!)
        }
        
        
        
        
        
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        
        self.foundCharacters+=string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if(elementName=="electionId")
        {
            electionItem?.electionID=StringLiteralType(foundCharacters).substring(from: stringIndex) as StringLiteralType
        }
        if(elementName=="name")
        {
            if(electionItem?.electionStage.isEmpty==true)
            {
                electionItem?.name=StringLiteralType(foundCharacters).substring(from: stringIndex) as StringLiteralType
            }
            else
            {
                electionItem?.electionStage.last?.name=StringLiteralType(foundCharacters).substring(from: electionStringIndex) as StringLiteralType
            }
        }
        if(elementName=="stateId")
        {
            
            if(electionItem?.electionStage.isEmpty==true)
            {
                electionItem?.state=StringLiteralType(foundCharacters).substring(from: stringIndex) as StringLiteralType
            }
            else
            {
                electionItem?.electionStage.last?.state=StringLiteralType(foundCharacters).substring(from: electionStringIndex) as StringLiteralType
            }
            
        }
        if(elementName=="officeTypeId")
        {
            electionItem?.typeID=StringLiteralType(foundCharacters).substring(from: stringIndex) as StringLiteralType
        }
        if(elementName=="special")
        {
            electionItem?.special=StringLiteralType(foundCharacters).substring(from: stringIndex) as StringLiteralType
        }
        if(elementName=="electionYear")
        {
            electionItem?.year=StringLiteralType(foundCharacters).substring(from: stringIndex) as StringLiteralType
        }
        if(elementName=="stageId")
        {
            electionItem?.electionStage.last?.stageID=StringLiteralType(foundCharacters).substring(from: stringIndex) as StringLiteralType
        }
        if(elementName=="electionDate")
        {
            electionItem?.electionStage.last?.electionDate=StringLiteralType(foundCharacters).substring(from: electionStringIndex) as StringLiteralType
        }
        if(elementName=="npatMailed")
        {
            electionItem?.electionStage.last?.npatMail=StringLiteralType(foundCharacters).substring(from: electionStringIndex) as StringLiteralType
        }
        if(elementName=="electionElectionstageId")
        {
            
            
            
            electionItem?.electionStage.last?.electionStageID=StringLiteralType(foundCharacters).substring(from: electionStringIndex) as StringLiteralType
        }
        if(elementName=="stage")
        {
            //electionItem?.electionStage.append(electionStageItem!)
            electionStageItem=nil
        }
        if(elementName=="election")
        {
            
            
            if(electionsInArray.contains((electionItem?.name)!))
            {
                //print(electionsInArray)
            }
            
            else
            {
            
            electionArray.append(electionItem!)
            electionsInArray.append((electionItem?.name)!)
            }
            
            
            
            }
        
        foundCharacters=""
        
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
