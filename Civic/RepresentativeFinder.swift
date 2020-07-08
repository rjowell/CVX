//
//  RepresentativeFinder.swift
//  Civic
//
//  Created by lauren piera on 9/6/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit
import CoreLocation




class RepresentativeFinder: UIViewController, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate {
    
   
    
   let loadingWheel: Spinner=Spinner()
    var senateCount: Int=0
    @IBOutlet weak var localGoButton: UIButton!
    
    @IBOutlet weak var stateGoButton: UIButton!
    var finalData: [String:[String:Int]]?
    @IBOutlet weak var localCancel: UIButton!
    var dataArray: [Int:[String]]=[:]
    @IBOutlet weak var stateSwitchButton: UIButton!
    
    @IBOutlet weak var localSwitchButton: UIButton!
    
    
    @IBOutlet weak var addressInvalid: UILabel!
    var finalIndex: [String:[String:Int]]=[:]
    @IBOutlet weak var stateCancel: UIButton!
    @IBOutlet weak var searchWindow: UIView!
    var currentNameArray: [String]=[]
    var currentPhoneArray: [String]=[]
    var currentEmailArray: [String]=[]
    var currentPictureArray: [String]=[]
    var currentWebArray: [String]=[]
    var currentTitleArray: [String]=[]
    var currentPartyArray: [String]=[]
    @IBOutlet weak var searchWindowTitle: UILabel!
    
    @IBOutlet weak var stateInstructionLabel: UILabel!
    @IBOutlet weak var localInstructionLabel: UILabel!
    
    @IBOutlet weak var localSearchField: UITextField!
    var repTracker: [Int]=[]
    @IBOutlet weak var stateSearchPicker: UIPickerView!
    
    @IBOutlet weak var jumpWindow: UIView!
    
    
    //@IBOutlet weak var searchWindow: UIView!
    
    @IBOutlet weak var jumpPicker: UIPickerView!
    @IBOutlet weak var jumpButton: UIButton!
    
    
   
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var jumpGoButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var showSearch: UIButton!
    
    
    var jumpOfficeSelection: String=""
    var stateOfficeList=["Governor","Lieutenant Governor","United States Senate","United States House of Representatives"]
    //@IBOutlet weak var searchWindowLabel: UILabel!
    
    @IBOutlet weak var representativeResults: UITableView!
    let stateList: [String]=["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Washington, DC","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa", "Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont", "Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    
    let stateAbbr: [String]=["AL","AK","AZ","AR","CA","CO","CT","DE","washington","FL","GA","HI","ID","IL", "Indiana","IA","KS","KY","Louisiana","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC", "ND","OH","OK","oregon","PA","rhodeisland","SC","SD","TN","TX","UT","VT","VA","Washingtonstate","WV","WI","WY"]
    
    
    
    var googleURL="https://www.googleapis.com/civicinfo/v2/representatives?key=AIzaSyDfeiCRXoUEb2ZNaq9WmgadSmeEKAiCIlw&address="
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var address: String=""
    var stateGovernmentTitles: [[String]]=[]
    var stateGovernmentNames: [[String]]=[]
    var stateGovernmentPics: [[String]]=[]
    var stateGovernmentPhone: [[String]]=[]
    var stateGovernmentEmail: [[String]]=[]
    var stateGovernmentWeblink: [[String]]=[]
    var stateGovernmentParties: [[String]]=[]
    var officialsDictionary: [String:[Int]]=[:]
    var sectionHeadings: [String]=[]
    var currentStateAbbr: String=""
    var newOfficials: [String:[Int]]=[:]
    var currentState: String=""
    var divisionsList: [String:[Int]]=[:]
    var officialsList: [String:[String:Int]]=[:]
    var finalDivIndex: [String:[Int]]=[:]
    var officesIndex: [String:IndexPath]=[:]
    var titleList: [String]=[]
    //weak var theDelegate: SearchResultsDelegate?
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        if(pickerView.tag==100)
        {
            var itemCount: Int=0
            for items in stateGovernmentTitles
            {
                itemCount+=items.count
            }
            return itemCount
            print(pickerView)
        }
        else
        {
            return 51
            
        }
    }
    
    
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var currentView: UILabel?
        
        if(pickerView.tag==100)
        {
            currentView=UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            
            currentView!.font=UIFont(name: "AmericanTypewriter", size: 17)
            currentView!.textColor=UIColor.white
            let paraStyle=NSMutableParagraphStyle()
            paraStyle.lineSpacing=0

            var currentString=NSMutableAttributedString(string: titleList[row])
            currentString.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, currentString.length))
            currentView!.attributedText=currentString
            
            
           
            currentView!.textColor=UIColor.white
            currentView!.numberOfLines=0
            
            currentView!.lineBreakMode=NSLineBreakMode.byWordWrapping
            
        }
        else
        {
            currentView=UILabel()
            currentView!.text=stateList[row]
            currentView!.font.withSize(20)
        }
        
        currentView!.textAlignment=NSTextAlignment.center
        currentView?.sizeToFit()
        
        
        
        
        if(pickerView.tag==100)
        {
            
        }
        else
        {
            
            
        }
        //currentView.sizeToFit()
        
        return currentView!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView.tag==100)
        {
            jumpOfficeSelection=titleList[row]
            print("jump is "+jumpOfficeSelection)
        }
        else
        {
        currentState=stateList[row]
            currentStateAbbr=stateAbbr[row]
            
        }
        //print(currentStateAbbr)
    }
    
    /*func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        if(pickerView.tag==100)
        {
            return 400
            
        }
        else{
            return 300}
        
    }*/
    
    
    func hideSearchWindow(sender: UIButton)
    {
        searchWindow.isHidden=true
        showSearch.isEnabled=true
        jumpButton.isEnabled=true
        homeButton.isEnabled=true
    }
    
    
    
    func showRepresentatives(sender: UIButton)
    {
        searchWindow.endEditing(true)
        
        address=localSearchField.text!
        
        
        var currentURL=googleURL+address
        
        let theData=try? Data(contentsOf: URL(string: currentURL.replacingOccurrences(of: " ", with: "%20"))!)
        //var errorData=try? JSONSerialization.jsonObject(with: theData!)
        print("data is here")
        print(theData)
        
        loadingWheel.isHidden=false
        
        
        
        
        
        
        
        
        
        
        if(sender==localGoButton)
        {
            if(theData==nil)
            {
                addressInvalid.isHidden=false
                print("here--------")
                searchWindow.isHidden=false
            }
            else{
                
                showSearch.isEnabled=true
                jumpButton.isEnabled=true
                homeButton.isEnabled=true
            locationLabel.text=localSearchField.text
            
            
            stateGovernmentTitles.removeAll()
            stateGovernmentNames.removeAll()
            stateGovernmentPics.removeAll()
            stateGovernmentEmail.removeAll()
            stateGovernmentPhone.removeAll()
            stateGovernmentWeblink.removeAll()
            sectionHeadings.removeAll()
            currentNameArray.removeAll()
            currentPartyArray.removeAll()
            currentPhoneArray.removeAll()
            currentEmailArray.removeAll()
            currentPictureArray.removeAll()
            currentWebArray.removeAll()
            currentTitleArray.removeAll()
            repTracker.removeAll()
            dataArray.removeAll()
            address=""
            print("Locale bttton")
           
            address=localSearchField.text!
            print("locale")
            
            var currentURL=googleURL+address
           
            let theData=try? Data(contentsOf: URL(string: currentURL.replacingOccurrences(of: " ", with: "%20"))!)
            //var errorData=try? JSONSerialization.jsonObject(with: theData!)
            print("data is here")
            print(theData)
            if(theData==nil)
             {
                
             }
 
             
            else{
                finalData=[:]
                //searchTextBox.endEditing(true)
                
            var representatives=try? JSONSerialization.jsonObject(with: theData!) as! NSDictionary
            //searchWindow.isHidden=true
                //searchTextBox.text=""
                //addressInvalid.isHidden=true
            var divisionsIndex=representatives?["divisions"] as! NSDictionary
            //print(divisionsIndex.allKeys)
            var normInput=representatives?["normalizedInput"] as! [String:Any]
            var officesDirectory=representatives?["offices"] as! NSArray
            var officialsDirectory=representatives?["officials"] as! NSArray
            var stateAbbrev1=normInput["state"] as! String
            //print(stateAbbrev1)
            var testArray: [[Int]]=[]
            var stringArray: [String]=[]
            for items in divisionsIndex
            {
                
                    if((items.key as! String).range(of: "state:"+stateAbbrev1.lowercased()+"/") != nil || (items.key as! String).range(of:"district:dc") != nil)
                    {
                    //print(type(of: officersIndex))
                    let officeData=items.value as! [String:Any]
                    if(officeData["officeIndices"] == nil)
                        {
                        testArray.append([-1])
                           stringArray.append(String(describing: officeData["name"]!))
                        }
                    else
                        {
                        
                        stringArray.append(String(describing: officeData["name"]!))
                        var currentArray: [Int]=officeData["officeIndices"]! as! [Int]
                        print(currentArray)
                        testArray.append(currentArray)
                        //officersIndex[officeData["name"]! as! String]!=officeData["officeIndices"]! as! [Int]
                        }
                    }
            }//end of items in div index
            
            
        
            finalIndex.removeAll()
            for index in 0..<testArray.count
            {
                var currentArray: [Int]=testArray[index]
                var currentDivision: String=stringArray[index]
                var currentOfficer: [String:Int]=[:]
               print(currentArray)
               for items in currentArray
               {
                
                
                
                if(items<0)
                {
                    
                    currentOfficer["nil"]=0
                }
                else
                {
                    var currentOffice=officesDirectory[items] as! NSDictionary
                    var interArray=currentOffice["officialIndices"] as! [Int]
                    currentOfficer[currentOffice["name"] as! String]=interArray[0]
                }
                
                
                }//end for items in current array
                
                finalIndex[currentDivision]=currentOfficer
                
                
            }//end for index in 0..test array
            
            print("the stuff is")
                print(finalIndex)
                repTracker.removeAll()
                for items in finalIndex
                {
                    var newStringArray: [String]=[]
                    for stuff in items.value
                    {
                        //newStringArray.append(stuff.value)
                        newStringArray.append(items.key)
                        newStringArray.append(stuff.key)
                        dataArray[stuff.value]=newStringArray
                        repTracker.append(stuff.value)
                        
                        newStringArray.removeAll()
                    }
                }
                
                
                //var indexCounter: Int=0
                var newRepTracker: [Int]=repTracker.sorted()
                print(newRepTracker)
            for numbers in newRepTracker
            {
                var currentElement=dataArray[numbers]!
                //var currentIndex=repTracker.index(of: numbers)
                print(numbers)
                print(currentElement[0])
                print(currentElement[1])
                print("this data right here")
                
                
                if(numbers>0)
                {
                    var thisCurrentPerson=officialsDirectory[numbers] as! NSDictionary
                    currentNameArray.append(thisCurrentPerson["name"] as! String)
                    currentTitleArray.append(currentElement[1])
                    if(thisCurrentPerson["party"]==nil)
                    {
                        currentPartyArray.append("nil")
                    }
                    else
                    {
                        currentPartyArray.append(thisCurrentPerson["party"] as! String)
                    }
                    
                    
                    if(thisCurrentPerson["phones"] != nil)
                    {
                        var phoneArray: [String]=thisCurrentPerson["phones"] as! [String]
                        currentPhoneArray.append(phoneArray[0] as! String)
                    }
                    else
                    {
                        currentPhoneArray.append("nil")
                    }
                    if(thisCurrentPerson["urls"] != nil)
                    {
                        var currentUrlArray: [String]=thisCurrentPerson["urls"] as! [String]
                        currentWebArray.append(currentUrlArray[0] as! String)
                    }
                    else
                    {
                        currentWebArray.append("nil")
                    }
                    if(thisCurrentPerson["emails"] != nil)
                    {
                        var currentEMAILArray: [String]=thisCurrentPerson["emails"] as! [String]
                        currentEmailArray.append(currentEMAILArray[0] as! String)
                    }
                    else
                    {
                        currentEmailArray.append("nil")
                    }
                    if(thisCurrentPerson["photoUrl"] != nil)
                    {
                        
                        currentPictureArray.append(thisCurrentPerson["photoUrl"] as! String)
                    }
                    else
                    {
                        currentPictureArray.append("nil")
                    }
                }
               print("look")
                print(newRepTracker.index(of: numbers)!)
                
                
                    if(numbers>0 && newRepTracker.count-1 > newRepTracker.index(of: numbers)! && dataArray[newRepTracker[newRepTracker.index(of: numbers)!+1]]![0] != currentElement[0] || newRepTracker.count-1 == newRepTracker.index(of: numbers)!)
                    {
                        sectionHeadings.append(currentElement[0])
                        stateGovernmentNames.append(currentNameArray)
                        stateGovernmentEmail.append(currentEmailArray)
                        stateGovernmentPhone.append(currentPhoneArray)
                        stateGovernmentPics.append(currentPictureArray)
                        stateGovernmentWeblink.append(currentWebArray)
                        stateGovernmentTitles.append(currentTitleArray)
                        stateGovernmentParties.append(currentPartyArray)
                        currentNameArray.removeAll()
                        currentPhoneArray.removeAll()
                        currentEmailArray.removeAll()
                        currentPictureArray.removeAll()
                        currentWebArray.removeAll()
                        currentTitleArray.removeAll()
                    }
                
                
                
                //print(dataArray[newRepTracker[newRepTracker.index(of: numbers)!+1]])
               
               
                
               
                
                
            }
                
            
                
               
               // var thisIsIt: [String:Any]=finalData?.sorted{$0.value[0].value < $1.value[0].value}
                print(stateGovernmentParties)
                representativeResults.reloadData()
                representativeResults.setContentOffset(CGPoint.zero, animated: true)
                loadingWheel.isHidden=false
                addressInvalid.isHidden=true
                searchWindow.isHidden=true
            }
            }}
            
                
        else
        {
            showSearch.isEnabled=true
            homeButton.isEnabled=true
            jumpButton.isEnabled=true
            locationLabel.text=currentState
            //searchWindow.isHidden=true
            stateGovernmentTitles.removeAll()
            stateGovernmentNames.removeAll()
            stateGovernmentParties.removeAll()
            stateGovernmentPics.removeAll()
            stateGovernmentEmail.removeAll()
            stateGovernmentPhone.removeAll()
            stateGovernmentWeblink.removeAll()
            sectionHeadings.removeAll()
            currentNameArray.removeAll()
            currentPhoneArray.removeAll()
            currentEmailArray.removeAll()
            currentPictureArray.removeAll()
            currentWebArray.removeAll()
            currentTitleArray.removeAll()
            repTracker.removeAll()
            dataArray.removeAll()
            print("step 1")
            print(stateGovernmentTitles)
            //stateGovernmentTitles[0].removeAll()
            address=currentStateAbbr.lowercased()
            print(currentStateAbbr)
            print("state abbr "+currentStateAbbr)
            if(address=="washington")
            {
                sectionHeadings.append(currentState)
            }
            else
            {
            sectionHeadings.append(currentState+" State")
            }
            locationLabel.text=currentState
            //address=searchTextBox.text!
            var currentURL=googleURL+address
            print(currentURL)
            
            let theData=try? Data(contentsOf: URL(string: currentURL.replacingOccurrences(of: " ", with: "%20"))!)
            print(theData)
            
            var representatives=try? JSONSerialization.jsonObject(with: theData!) as! NSDictionary
            var officeIndex=representatives?["divisions"] as! NSDictionary
            //print(officeIndex.allKeys)
            var stateOfficeIndex: NSDictionary?
            //Seattle
            if(address=="washingtonstate")
            {
                stateOfficeIndex=officeIndex["ocd-division/country:us/state:wa"] as! NSDictionary
            }
            else if(address=="rhodeisland")
            {
                stateOfficeIndex=officeIndex["ocd-division/country:us/state:ri"] as! NSDictionary
            }
            else if(address=="louisiana")
            {
                stateOfficeIndex=officeIndex["ocd-division/country:us/state:la"] as! NSDictionary
            }
            //DC
            else if(address=="washington")
            {
                stateOfficeIndex=officeIndex["ocd-division/country:us/district:dc"] as! NSDictionary
            }
            else if(address=="indiana")
            {
                stateOfficeIndex=officeIndex["ocd-division/country:us/state:in"] as! NSDictionary
            }
            else if(address=="oregon")
            {
                stateOfficeIndex=officeIndex["ocd-division/country:us/state:or"] as! NSDictionary
            }
            else
            {
            stateOfficeIndex=officeIndex["ocd-division/country:us/state:"+currentStateAbbr.lowercased()] as! NSDictionary
            }
            //print(stateOfficeIndex.allKeys)
            var indexes=stateOfficeIndex?["officeIndices"] as! NSArray
            print(indexes)
            
            //print(officeIndexArray)
            var currentOfficials=representatives?["officials"] as! NSArray
            print("officials us")
            print(currentOfficials.count)
            var currentOffices=representatives?["offices"] as! NSArray
            //print(currentOfficials)
            //print(currentOffices)
            print("step 2")
            officialsDictionary.removeAll()
            for number in indexes
            {
                var numberArray: [Int]=[]
                var currentItem: [String:[Int]]=[:]
                var thisOffice=currentOffices[number as! Int] as! NSDictionary
                var indexList=thisOffice["officialIndices"]
                numberArray=indexList as! [Int]
                officialsDictionary[thisOffice["name"] as! String]=numberArray
                //print(officialsDictionary.keys)
                
                
            }
            var newArray=officialsDictionary.sorted{$0.value[0] < $1.value[0]}
            var newArray2: [String:[Int]]=[:]
            for items in newArray
            {
                newArray2[items.key]=items.value
            }
            print(newArray2)
            
            print("step 3")
            stateGovernmentTitles.removeAll()
            stateGovernmentNames.removeAll()
            stateGovernmentEmail.removeAll()
            stateGovernmentPhone.removeAll()
            stateGovernmentWeblink.removeAll()
            stateGovernmentPics.removeAll()
            stateGovernmentParties.removeAll()
            stateGovernmentTitles.append([])
            stateGovernmentNames.append([])
            stateGovernmentEmail.append([])
            stateGovernmentPhone.append([])
            stateGovernmentWeblink.append([])
            stateGovernmentPics.append([])
            stateGovernmentParties.append([])
            
            
            if(address=="washington")
            {
                for entries in newArray2
                {
                    
                    for items in entries.value
                    {
                        
                       stateGovernmentTitles[0].append(entries.key)
                        var currentPerson=currentOfficials[items as! Int] as! NSDictionary
                        stateGovernmentNames[0].append(currentPerson["name"] as! String)
                        if(currentPerson["party"]==nil)
                        {
                            stateGovernmentParties[0].append("nil")
                        }
                        else
                        {
                        stateGovernmentParties[0].append(currentPerson["party"] as! String)
                        }
                        var telephoneArray: NSArray=[]
                        if(currentPerson["phones"] != nil)
                        {
                            telephoneArray=currentPerson["phones"] as! NSArray
                        }
                        else
                        {
                            telephoneArray=["nil"]
                        }
                        
                        stateGovernmentPhone[0].append(telephoneArray[0] as! String)
                        var urlArray1: NSArray=[]
                        if(currentPerson["urls"] != nil)
                        {
                            urlArray1=currentPerson["urls"] as! NSArray
                        }
                        else
                        {
                            urlArray1=["nil"]
                        }
                        stateGovernmentWeblink[0].append(urlArray1[0] as! String)
                        
                        
                        var emailArray1: NSArray=[]
                        if(currentPerson["emails"] != nil)
                        {
                            emailArray1=currentPerson["emails"] as! NSArray
                            stateGovernmentEmail[0].append(emailArray1[0] as! String)
                            print("email+")
                        }
                            
                        else
                        {
                            stateGovernmentEmail[0].append("nil")
                            print("email-")
                        }
                        
                        if(currentPerson["photoUrl"] == nil)
                        {
                            stateGovernmentPics[0].append("nil")
                        }
                        else
                        {
                            stateGovernmentPics[0].append(currentPerson["photoUrl"] as! String)
                            
                        }
                        
                    }//end of items in entriesvalue
                }//end of entries in newArray2
                print("wash titles")
                print(stateGovernmentTitles)
            }//end ofWashington
            else
            {
            
            for titles in stateOfficeList
            {
                for entries in newArray2
                {
                    if(entries.key==titles)
                    {
                        if(entries.key=="United States Senate")
                        {
                            stateGovernmentTitles[0].append(entries.key)
                            stateGovernmentTitles[0].append(entries.key)
                        }
                        else{
                            stateGovernmentTitles[0].append(entries.key)
                            
                        }
                        
                        for items in entries.value
                        {
                            
                            
                            var currentPerson=currentOfficials[items as! Int] as! NSDictionary
                            stateGovernmentNames[0].append(currentPerson["name"] as! String)
                            if(currentPerson["party"]==nil)
                            {
                                stateGovernmentParties[0].append("nil")
                            }
                            else{
                            stateGovernmentParties[0].append(currentPerson["party"] as! String)
                            }
                            var telephoneArray: NSArray=[]
                            if(currentPerson["phones"] != nil)
                            {
                                telephoneArray=currentPerson["phones"] as! NSArray
                            }
                            else
                            {
                                telephoneArray=["nil"]
                            }
                            
                            stateGovernmentPhone[0].append(telephoneArray[0] as! String)
                            var urlArray1: NSArray=[]
                            if(currentPerson["urls"] != nil)
                            {
                                urlArray1=currentPerson["urls"] as! NSArray
                            }
                            else
                            {
                                urlArray1=["nil"]
                            }
                            stateGovernmentWeblink[0].append(urlArray1[0] as! String)
                            
                            
                            var emailArray1: NSArray=[]
                            if(currentPerson["emails"] != nil)
                            {
                                emailArray1=currentPerson["emails"] as! NSArray
                                stateGovernmentEmail[0].append(emailArray1[0] as! String)
                                print("email+")
                            }
                                
                            else
                            {
                                stateGovernmentEmail[0].append("nil")
                                print("email-")
                            }
                            
                            if(currentPerson["photoUrl"] == nil)
                            {
                                stateGovernmentPics[0].append("nil")
                            }
                            else
                            {
                                stateGovernmentPics[0].append(currentPerson["photoUrl"] as! String)
                                
                            }
                            if(entries.key=="United States Senate")
                            {
                                senateCount=senateCount+1
                            }
                            if(titles=="United States Senate" && senateCount==1 || titles != "United States Senate")
                            {
                                print("senate value is")
                                print(senateCount)
                                newArray2.removeValue(forKey: titles)
                            }
                            
                        }//end of items in entries value
                    }//end of entries.key=titles
                }//end of entries in newArray2
                print("wash titles11")
                print(stateGovernmentTitles)
         
                }//end of state List
            }
            
            newArray2.removeValue(forKey: "United States Senate")
            print("your array is")
            print(newArray2)
            if(address != "washington")
            {
            for thingsLeft in newArray2
            {
                
                
                stateGovernmentTitles[0].append(thingsLeft.key)
                
                print("look ehre russ")
                print(stateGovernmentTitles)
                for numbers in thingsLeft.value
                {
                    var currentPerson=currentOfficials[numbers as! Int] as! NSDictionary
                    stateGovernmentNames[0].append(currentPerson["name"] as! String)
                    if(currentPerson["party"]==nil)
                    {
                        stateGovernmentParties[0].append("nil")
                    }
                    else
                    {
                    stateGovernmentParties[0].append(currentPerson["party"] as! String)
                    }
                    var telephoneArray: NSArray=[]
                    if(currentPerson["phones"] != nil)
                    {
                        telephoneArray=currentPerson["phones"] as! NSArray
                    }
                    else
                    {
                        telephoneArray=["nil"]
                    }
                    
                    stateGovernmentPhone[0].append(telephoneArray[0] as! String)
                    var urlArray1: NSArray=[]
                    if(currentPerson["urls"] != nil)
                    {
                        urlArray1=currentPerson["urls"] as! NSArray
                    }
                    else
                    {
                        urlArray1=["nil"]
                    }
                    stateGovernmentWeblink[0].append(urlArray1[0] as! String)
                    
                    
                    var emailArray1: NSArray=[]
                    if(currentPerson["emails"] != nil)
                    {
                        emailArray1=currentPerson["emails"] as! NSArray
                        stateGovernmentEmail[0].append(emailArray1[0] as! String)
                        print("email+")
                    }
                        
                    else
                    {
                        stateGovernmentEmail[0].append("nil")
                        print("email-")
                    }
                    
                    if(currentPerson["photoUrl"] == nil)
                    {
                        stateGovernmentPics[0].append("nil")
                    }
                    else
                    {
                        stateGovernmentPics[0].append(currentPerson["photoUrl"] as! String)
                        
                    }
                }
                }//end of things left in newArray2
            }
            
            
            
            print("step 5")
            print(stateGovernmentTitles)
            print(stateGovernmentParties)
            /*print(stateGovernmentNames)
            print(stateGovernmentPics)
            print(stateGovernmentEmail)
            print(stateGovernmentPhone)
            print(stateGovernmentWeblink)
            print(stateGovernmentTitles.count)*/
            
            
            
            
            searchWindow.isHidden=true
            
            
        }//end else state selector
        
        representativeResults.reloadData()
        loadingWheel.isHidden=true
        //searchWindow.isHidden=true
        titleList.removeAll()
        for items in stateGovernmentTitles
        {
            for things in items
            {
                titleList.append(things)
            }
        }
        print("hello george")
        print(titleList)
        jumpPicker.reloadAllComponents()
        
        }
    
    func processButton(sender: UIButton)
    {
        if(sender.titleLabel?.text?.range(of: "(") != nil)
        {
            //phone
            print("phone")
            let phoneNumber=sender.titleLabel?.text?.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
            print(phoneNumber)
            UIApplication.shared.open(URL(string: "tel://"+phoneNumber!)!, options: [:], completionHandler: nil)
        }
        else if(sender.titleLabel?.text?.range(of: "@") != nil)
        {
            //email
            print("email")
            let emailAdd=sender.titleLabel?.text
            UIApplication.shared.open(URL(string: "mailto:"+emailAdd!)!, options: [:], completionHandler: nil)
            
            
        }
        else if(sender.titleLabel?.text?.range(of: "Website") != nil)
        {
            //website
            print("website")
            let webAdd=sender.accessibilityLabel
            print("label")
            print(webAdd)
            UIApplication.shared.open(URL(string: webAdd!)!, options: [:], completionHandler: nil)
        }
        else
        {
            print("no button")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeadings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateGovernmentTitles[section].count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        
        return sectionHeadings[section]
        //print("IT is "+sectionHeadings[section])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel=UILabel()
        sectionLabel.text=sectionHeadings[section]
        
        sectionLabel.font = UIFont(name: "AmericanTypewriter", size: 18)
        sectionLabel.textColor=UIColor(red: 222/255, green: 232/255, blue: 249/255, alpha: 1)
        //sectionLabel.tintColor=UIColor(red: 28/255, green: 38/255, blue: 53/255, alpha: 1)
        sectionLabel.backgroundColor=UIColor(red: 28/255, green: 38/255, blue: 53/255, alpha: 1)
        sectionLabel.textAlignment=NSTextAlignment.center
        sectionLabel.numberOfLines=0
        sectionLabel.lineBreakMode=NSLineBreakMode.byWordWrapping
        
        return sectionLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(sectionHeadings[section].count<35)
        {
            return 25
        }
        else{
        
            return 50}
    }
    
    /*func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor=UIColor(red: 222/255, green: 232/255, blue: 249/255, alpha: 1)
        header?.tintColor=UIColor(red: 28/255, green: 38/255, blue: 53/255, alpha: 1)
        header?.textLabel?.font=UIFont(name: "AmericanTypewriter", size: 18)
        header?.textLabel?.numberOfLines=0
        header?.textLabel?.lineBreakMode=NSLineBreakMode.byWordWrapping
        header?.textLabel?.textAlignment = .center
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let theCell=representativeResults.dequeueReusableCell(withIdentifier: "RepresentativeShowCell", for: indexPath) as! RepresentativeResultCell
        //officesIndex[stateGovernmentTitles[0][indexPath.row]]=indexPath
        print(officesIndex)
        
        if(stateGovernmentTitles.count==1){
        if(stateGovernmentParties[0][indexPath.row]=="nil" || stateGovernmentParties[0][indexPath.row]=="Unknown")
        {
                theCell.partyLabel.text="No Party"
        }
        else
        {
            theCell.partyLabel.text=stateGovernmentParties[0][indexPath.row]
        }
        theCell.officeLabel.text=stateGovernmentTitles[0][indexPath.row]
        theCell.repName.text=stateGovernmentNames[0][indexPath.row]
        if(stateGovernmentPics[0][indexPath.row] != "nil")
        {
            let repImageUrl=URL(string: stateGovernmentPics[0][indexPath.row])
            var repImageData: Data?
            do{repImageData=try Data(contentsOf: repImageUrl!)}
            catch{
                print("error")
            }
            
            theCell.repPhoto.image=UIImage(data: repImageData!)
        }
        else{
            theCell.repPhoto.image=#imageLiteral(resourceName: "noPhotoImage")
            }
        if(stateGovernmentEmail[0][indexPath.row] != "nil")
        {
            theCell.repEmail.setTitle(stateGovernmentEmail[0][indexPath.row], for: UIControlState.normal)
        }
        else
        {
            theCell.repEmail.setTitle("", for: UIControlState.normal)
            theCell.repEmail.isEnabled=false
        }
            theCell.repEmail.addTarget(self, action: #selector(processButton), for: UIControlEvents.touchDown)
            theCell.repPhone.setTitle(stateGovernmentPhone[indexPath.section][indexPath.row], for: UIControlState.normal)
            theCell.repPhone.addTarget(self, action: #selector(processButton), for: UIControlEvents.touchDown)
            //theCell.repWebsite.setTitle(stateGovernmentWeblink[indexPath.section][indexPath.row], for: UIControlState.normal)
            theCell.repWebsite.addTarget(self, action: #selector(processButton), for: UIControlEvents.touchDown)
            theCell.repWebsite.accessibilityLabel=stateGovernmentWeblink[indexPath.section][indexPath.row]
        }
        else
        {
            if(stateGovernmentParties[indexPath.section][indexPath.row]=="nil" || stateGovernmentParties[indexPath.section][indexPath.row]=="Unknown")
            {
                theCell.partyLabel.text="No Party"
            }
            else
            {
                theCell.partyLabel.text=stateGovernmentParties[indexPath.section][indexPath.row]
            }
            theCell.officeLabel.text=stateGovernmentTitles[indexPath.section][indexPath.row]
            theCell.repName.text=stateGovernmentNames[indexPath.section][indexPath.row]
            if(stateGovernmentPics[indexPath.section][indexPath.row] != "nil")
            {
                let repImageUrl=URL(string: stateGovernmentPics[indexPath.section][indexPath.row])
                var repImageData: Data?
                do{repImageData=try Data(contentsOf: repImageUrl!)}
                catch{
                    print("error")
                }
                
                theCell.repPhoto.image=UIImage(data: repImageData!)
                
            }
            else{
                theCell.repPhoto.image=#imageLiteral(resourceName: "noPhotoImage")
            }
            print("height is")
            print(theCell.repPhoto.frame.height)
            if(stateGovernmentEmail[indexPath.section][indexPath.row] != "nil")
            {
                theCell.repEmail.setTitle(stateGovernmentEmail[indexPath.section][indexPath.row], for: UIControlState.normal)
            }
            else
            {
                theCell.repEmail.setTitle("", for: UIControlState.normal)
                //theCell.repEmail.isEnabled=false
            }
            theCell.repEmail.addTarget(self, action: #selector(processButton), for: UIControlEvents.touchDown)
            theCell.repPhone.setTitle(stateGovernmentPhone[indexPath.section][indexPath.row], for: UIControlState.normal)
            theCell.repPhone.addTarget(self, action: #selector(processButton), for: UIControlEvents.touchDown)
            //theCell.repWebsite.setTitle(stateGovernmentWeblink[indexPath.section][indexPath.row], for: UIControlState.normal)
            theCell.repWebsite.addTarget(self, action: #selector(processButton), for: UIControlEvents.touchDown)
            theCell.repWebsite.accessibilityLabel=stateGovernmentWeblink[indexPath.section][indexPath.row]
        }
        
        
        return theCell
    }
    
    func openJumpWindow(sender: UIButton)
    {
        
        
        jumpPicker.reloadAllComponents()
        jumpWindow.isHidden=false
    }
    func closeJumpWindow(Sender: UIButton)
    {
        jumpWindow.isHidden=true
        
        var section: Int=0
        var currentRow: Int=0
        var count: Int=0
        
        for sectionIndex in 0..<stateGovernmentTitles.count
        {
            for arrayIndex in 0..<stateGovernmentTitles[sectionIndex].count
            {
                if(stateGovernmentTitles[sectionIndex][arrayIndex]==jumpOfficeSelection)
                {
                    section=sectionIndex
                    currentRow=arrayIndex
                }
            }
        }
        
        
        
        
        print(section)
        print(currentRow)
        let currentPath=IndexPath(row: currentRow, section: section)
        
        representativeResults.scrollToRow(at: currentPath, at: UITableViewScrollPosition.middle, animated: true)
    }
    
    func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    
    
    func switchSearchScreens(sender: UIButton)
    {
        if(sender==localSwitchButton)
        {
            stateInstructionLabel.isHidden=true
            stateSearchPicker.isHidden=true
            stateGoButton.isHidden=true
            stateSwitchButton.isHidden=false
            stateCancel.isHidden=true
            localSwitchButton.isHidden=true
            localInstructionLabel.isHidden=false
            localSearchField.isHidden=false
            localGoButton.isHidden=false
            localCancel.isHidden=false
        }
        else
        {
            stateInstructionLabel.isHidden=false
            stateSearchPicker.isHidden=false
            stateGoButton.isHidden=false
            stateCancel.isHidden=false
            addressInvalid.isHidden=true
            localSwitchButton.isHidden=false
            stateSwitchButton.isHidden=true
            localInstructionLabel.isHidden=true
            localSearchField.isHidden=true
            localGoButton.isHidden=true
            localCancel.isHidden=true
        }
    }
    
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("it loaded")
        showSearch.isEnabled=false
        localSearchField.returnKeyType = .search
        jumpButton.isEnabled=false
        homeButton.isEnabled=false
        self.view.addSubview(loadingWheel)
        self.view.bringSubview(toFront: loadingWheel)
        loadingWheel.layer.zPosition=1
        loadingWheel.isHidden=true
        print(self.view.subviews)
        stateInstructionLabel.isHidden=true
        stateSearchPicker.isHidden=true
        stateGoButton.isHidden=true
        stateCancel.isHidden=true
        addressInvalid.isHidden=true
        localSwitchButton.isHidden=true
        localSwitchButton.addTarget(self, action: #selector(switchSearchScreens), for: UIControlEvents.touchDown)
        stateSwitchButton.addTarget(self, action: #selector(switchSearchScreens), for: UIControlEvents.touchDown)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        jumpPicker.delegate=self
        jumpPicker.dataSource=self
        stateSearchPicker.delegate=self
        stateSearchPicker.dataSource=self
        //cancelButton.addTarget(self, action: #selector(cancelSearch), for: UIControlEvents.touchDown)
        jumpPicker.tag=100
        print("tag is")
        print(jumpPicker.tag)
        self.representativeResults.delegate=self
        self.representativeResults.dataSource=self
        jumpWindow.isHidden=true
        jumpButton.addTarget(self, action: #selector(openJumpWindow), for: UIControlEvents.touchDown)
        jumpGoButton.addTarget(self, action: #selector(closeJumpWindow), for: UIControlEvents.touchDown)
        
        self.view.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        
        currentStateAbbr="AL"
        currentState="Alabama"
        representativeResults.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        
        
        localGoButton.addTarget(self, action: #selector(showRepresentatives), for: UIControlEvents.touchDown)
        stateGoButton.addTarget(self, action: #selector(showRepresentatives), for: UIControlEvents.touchDown)
        showSearch.addTarget(self, action: #selector(openSearchWindow), for: UIControlEvents.touchDown)
        localCancel.addTarget(self, action: #selector(hideSearchWindow), for: UIControlEvents.touchDown)
        stateCancel.addTarget(self, action: #selector(hideSearchWindow), for: UIControlEvents.touchDown)
        
        
        
    }

    func openSearchWindow(sender: UIButton)
    {
        searchWindow.isHidden=false
        localSearchField.text=""
        showSearch.isEnabled=false
        
        jumpButton.isEnabled=false
        homeButton.isEnabled=false
        
    }
    
    @IBAction func searchFunc(_ sender: Any) {
        
        print("its over numbnuts")
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
