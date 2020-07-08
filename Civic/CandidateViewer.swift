//
//  CandidateViewer.swift
//  Civic
//
//  Created by lauren piera on 9/26/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class CandidateViewer: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    
    @IBOutlet weak var jumpView: UIView!
    
    @IBOutlet weak var jumpViewPicker: UIPickerView!
    
    @IBOutlet weak var jumpGoButton: UIButton!
    
    @IBOutlet weak var backToCal: UIButton!
    @IBOutlet weak var candidateDisplay: UITableView!
    var electionNumber: Int?
    var keyString: String="key=6b633e49549b6c63c659be06c2ee75f9"
    var voteSmartURL: String="http://api.votesmart.org/"
    var candidatesByElection: String="Candidates.getByElection"
    var candidatesInfo: String="Address.getCampaign"
    var candidateWebString: String="Address.getCampaignWebAddress"
    var candidateWebInfo: String="Address.getOfficeWebAddress"
    var candidatePhoto: String="CandidateBio.getBio"
    var dataParser: XMLParser?
    var currentCandidate: Candidate?
    var foundChars: String=""
    var candidates: [Candidate]=[]
    var webAddressType: String=""
    var webContactInfo: [String:[String]]=[:]
    var currentWebContactElement: [String]=["","",""]
    var currentID=""
    var websiteType: String=""
    var photoLinks: [String:String]=[:]
    var currentCandidateElecStatus: String=""
    var itemsToRemove: [Int]=[]
    var electionName: String=""
    
    @IBOutlet weak var electionLabelTop: UILabel!
    
   
    
    
    
    
    func processContactButton(sender: UIButton)
    {
            if(sender.titleLabel?.text?.range(of: "(") != nil)
            {
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
                
                let webAdd=sender.accessibilityLabel
                if(webAdd=="")
                { print("Address is nil")}
                if(webAdd != nil || webAdd != ""){
                    UIApplication.shared.open(URL(string: webAdd!)!, options: [:], completionHandler: nil)}
        }
    
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell=candidateDisplay.dequeueReusableCell(withIdentifier: "candidateResultCell", for: indexPath) as! CandidateResultCellTableViewCell
        
        if(candidates[indexPath.row].photoLink != "")
        {
            let repImageUrl=URL(string: candidates[indexPath.row].photoLink!)
            print("url iss "+candidates[indexPath.row].photoLink!)
            var repImageData: Data?
            do{repImageData=try Data(contentsOf: repImageUrl!)}
            catch{
                print("error")
            }
            
             currentCell.candidatePhoto.image=UIImage(data: repImageData!)
        }
        else
        {
            currentCell.candidatePhoto.image=#imageLiteral(resourceName: "noPhotoImage")
        }
        
        
        
        
        currentCell.candidateName.text=candidates[indexPath.row].candidateFirstName!+" "+candidates[indexPath.row].candidateLastName!
        currentCell.candidatePhone.setTitle(candidates[indexPath.row].phoneNumer, for: UIControlState.normal)
        currentCell.candidateEmail.setTitle(candidates[indexPath.row].eMail, for: UIControlState.normal)
        print("Website is "+candidates[indexPath.row].website!)
        //currentCell.candidateWebsite.setTitle(candidates[indexPath.row].website!, for: UIControlState.normal)
        currentCell.candidateWebsite.accessibilityLabel=candidates[indexPath.row].website!
        currentCell.candidateParty.text=candidates[indexPath.row].candidateParty
        currentCell.candidateRunningFor.text=candidates[indexPath.row].runningFor
        if(candidates[indexPath.row].website=="" || candidates[indexPath.row].website=="nil")
        {
            currentCell.webHeightConst.constant=0
            currentCell.candidateWebsite.isHidden=true
        }
        else{
        currentCell.candidateWebsite.addTarget(self, action: #selector(processContactButton), for: UIControlEvents.touchDown)
        }
        if(candidates[indexPath.row].phoneNumer=="" || candidates[indexPath.row].phoneNumer=="nil")
        {
            currentCell.phoneLblHgt.constant=1
            currentCell.candidatePhone.isHidden=true
        }
        else
        {
            currentCell.candidatePhone.addTarget(self, action: #selector(processContactButton), for: UIControlEvents.touchDown)
        }
        if(candidates[indexPath.row].eMail=="" || candidates[indexPath.row].eMail=="nil")
        {
            currentCell.emailLabelHgt.constant=0
            currentCell.candidateEmail.isHidden=true
        }
        
        else{
        
            currentCell.candidateEmail.addTarget(self, action: #selector(processContactButton), for: UIControlEvents.touchDown)}
        if(candidates[indexPath.row].districtNo! != "")
        {
            if(candidates[indexPath.row].runningFor! == "U.S. Senate")
            {
                currentCell.districtLabel.text=candidates[indexPath.row].districtNo!
            }
            else
            {
            currentCell.districtLabel.text="District "+candidates[indexPath.row].districtNo!
            }
            
        }
        
        else
        {
            print("your value is this")
            print(candidates[indexPath.row].districtNo!)
            currentCell.districtLabel.isHidden=true
            currentCell.distLabelHeight.constant=0
       
        }
        
        return currentCell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ello")
        electionLabelTop.text=electionName
        self.view.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        electionLabelTop.numberOfLines=0
        electionLabelTop.lineBreakMode=NSLineBreakMode.byWordWrapping
        print("election ")
        backToCal.titleLabel?.numberOfLines=0
        backToCal.titleLabel?.lineBreakMode=NSLineBreakMode.byWordWrapping
        backToCal.titleLabel?.textAlignment=NSTextAlignment.center
        var currentString:String="http://api.votesmart.org/"+candidatesByElection+"?key=6b633e49549b6c63c659be06c2ee75f9&electionId="+String(electionNumber!)
        //print(currentString)
        dataParser=XMLParser(contentsOf: URL(string: currentString)!)
        dataParser?.delegate=self
        dataParser?.parse()
       // print(candidates)
    
        
        for people in candidates
        {
                currentID=people.candidateID!
                var thisURL="http://api.votesmart.org/"+candidateWebString+"?key=6b633e49549b6c63c659be06c2ee75f9&candidateId="+currentID
                print(thisURL)
                dataParser=XMLParser(contentsOf: URL(string: thisURL)!)
                dataParser?.delegate=self
                dataParser?.parse()
                thisURL="http://api.votesmart.org/"+candidatesInfo+"?key=6b633e49549b6c63c659be06c2ee75f9&candidateId="+currentID
                dataParser=XMLParser(contentsOf: URL(string: thisURL)!)
                dataParser?.delegate=self
                dataParser?.parse()
            thisURL="http://api.votesmart.org/CandidateBio.getBio?key=6b633e49549b6c63c659be06c2ee75f9&candidateId="+currentID
            dataParser=XMLParser(contentsOf: URL(string: thisURL)!)
            dataParser?.delegate=self
            dataParser?.parse()
            
        }
        
       
        
        
        for items in candidates
        {
            print(webContactInfo[items.candidateID!])
            print("This is")
            //print(webContactInfo[items.candidateID!]?[0])
            if(webContactInfo[items.candidateID!]?[0] != nil)
            {
                items.eMail=webContactInfo[items.candidateID!]?[0]
            }
            else{
                items.eMail="nil"
            }
            if(webContactInfo[items.candidateID!]?[1] != nil){
                items.website=webContactInfo[items.candidateID!]?[1]}
            else
            {
                items.website="nil"
            }
            if(webContactInfo[items.candidateID!]?[2] != nil)
            {
                items.phoneNumer=webContactInfo[items.candidateID!]?[2]
            }
            else
            {
                items.phoneNumer="nil"
            }
            if(photoLinks[items.candidateID!] != nil)
            {
                items.photoLink=photoLinks[items.candidateID!]
            }
            else
            {
                items.photoLink="nil"
            }
        }
        
        for people in candidates
        {
            print(people.candidateFirstName!+" "+people.candidateLastName!)
            print(people.candidateID!)
            print(people.candidateParty!)
            print(people.candidateStatus!)
            print(people.eMail!)
            print("priority is")
            print(people.electionPriority!)
            print("phone is")
            print(people.phoneNumer!)
            print(people.runningFor!)
            print(people.website!)
            print(people.photoLink!)
            print("dist here")
            print("'"+people.districtNo!+"'")
        }
        
        candidateDisplay.delegate=self
        candidateDisplay.dataSource=self

        // Do any additional setup after loading the view.
    }
    
    class Candidate
    {
        var candidateID: String?
        var candidateFirstName: String?
        var candidateLastName: String?
        var candidateParty: String?
        var candidateStatus: String?
        var phoneNumer: String?
        var website: String?
        var eMail: String?
        var photoLink: String?
        var runningFor: String?
        var electionPriority: Int?
        var districtNo: String?
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        if(elementName=="candidate")
        {
            currentCandidate=Candidate()
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
    
        foundChars+=string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if(elementName=="electionOffice")
        {
            currentCandidate?.runningFor=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if(elementName=="candidateId")
            {
                    currentCandidate?.candidateID=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            if(elementName=="firstName")
            {
                currentCandidate?.candidateFirstName=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        if(elementName=="electionOfficeId")
        {
            currentCandidate?.electionPriority=Int(foundChars.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        if(elementName=="webAddressType")
        {
            webAddressType=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if(elementName=="phone1")
        {
            print("length is")
            //print(foundChars.characters.count)
            webContactInfo[currentID]?[2]=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if(elementName=="webAddress")
        {
            //webContactInfo[currentID]
            
            if(foundChars.range(of: "@") != nil)
            {
                currentWebContactElement[0]=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            print("web addy")
            print(webAddressType)
            print(foundChars)
            if(webAddressType=="Website"){
                print("youmadeit")
                print(webAddressType)
                if(foundChars.range(of: "http") != nil){
                    currentWebContactElement[1]=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)}
                else{
                    currentWebContactElement[1]="nil"
                }
                
                
            }
            print(currentWebContactElement)
            
        }
        if(elementName=="webaddress")
        {
            webContactInfo[currentID]=currentWebContactElement
            if(webContactInfo[currentID]?[2]=="")
            {
                webContactInfo[currentID]?[2]="nil"
            }
            currentWebContactElement[0]="nil"
            currentWebContactElement[1]="nil"
            currentWebContactElement[2]="nil"
        }
        if(elementName=="webAddressTypeId")
        {
            webAddressType=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if(elementName=="lastName")
        {
            currentCandidate?.candidateLastName=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if(elementName=="photo")
        {
            //print("phoot")
            //print(foundChars)
           photoLinks[currentID]=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
            
        }
        if(elementName=="electionParties")
        {
            currentCandidate?.candidateParty=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if(elementName=="electionDistrictName")
        {
                currentCandidate?.districtNo=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if(elementName=="electionStatus")
        {
            currentCandidateElecStatus=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
            currentCandidate?.candidateStatus=foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
            
        }
        if(elementName=="candidate")
        {
            //print("------here")
            //print(currentCandidateElecStatus)
            //print(currentCandidate?.candidateStatus)
            //print(currentCandidate?.candidateStatus)
            print("web address")
            print(currentWebContactElement[1])
            if(currentID == "")
            {
            if(currentCandidateElecStatus != nil)
                {
                    if(currentCandidateElecStatus != "Lost")
                    {
                        if(currentCandidateElecStatus != "Withdrawn")
                        {
                            candidates.append(currentCandidate!)
                        }
                    }
                        
                }
                
                   
            }
            
        }
        foundChars=""
        
        
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
