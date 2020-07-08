//
//  LawViewStateList.swift
//  Civic
//
//  Created by lauren piera on 8/15/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class LawViewStateList: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    @IBOutlet weak var stateScrollView: UIScrollView!
    let stateList: [String]=["US","US House & Senate","AL","Alabama","AK","Alaska","AR","Arkansas","AZ","Arizona","CA","California","CO","Colorado","CT","Connecticut","DE","Delaware","FL","Florida","GA","Georgia","HI","Hawaii","ID","Idaho","IL","Illinois","IN","Indiana","IA","Iowa","KS","Kansas","KY","Kentucky","LA","Louisiana","ME","Maine","MD","Maryland","MA","Massachusetts","MI","Michigan","MN","Minnesota","MO","Missouri","MS","Mississippi","MT","Montana","NC","North Carolina","ND","North Dakota","NE","Nebraska","NH","New Hampshire","NJ","New Jersey","NM","New Mexico","NV","Nevada","NY","New York","OH","Ohio","OK","Oklahoma","OR","Oregon","PA","Pennsylvania","RI","Rhode Island","SC","South Carolina","SD","South Dakota","TN","Tennessee","TX","Texas","UT","Utah","VA","Virginia","VT","Vermont","WA","Washington","DC","Washington, DC","WI","Wisconsin","WV","West Virginia","WY","Wyoming"]
    
    var sessionDates: [String:[Int]]=["AL":[2018,1,9],"AK":[2018,1,16],"AZ":[2018,1,8],"AR":[2018,2,12],"CA":[2018,1,1],"CO":[2018,1,10],"CT":[2018,2,4],"DE":[2018,1,9],"FL":[2018,1,8],"GA":[2018,1,8],"HI":[2018,1,17],"IA":[2018,1,8],"ID":[2018,1,8],"IL":[2018,1,10],"IN":[2018,1,8],"KS":[2018,1,8],"KY":[2018,1,2],"LA":[2018,3,12],"ME":[2018,1,3],"MD":[2018,1,10],"MA":[2018,1,3],"MI":[2018,1,10],"MN":[2018,2,20],"MS":[2018,1,2],"MO":[2018,1,3],"NE":[2018,1,3],"NH":[2018,1,3],"NJ":[2018,1,9],"MT":[0,0,0],"NV":[0,0,0],"NM":[2018,1,16],"NY":[2018,1,3],"NC":[2018,4,23],"ND":[0,0,0],"OH":[2018,1,2],"OK":[2018,2,5],"OR":[2018,2,5],"PA":[2018,1,2],"RI":[2018,1,2],"SC":[2018,1,9],"SD":[2018,1,9],"TN":[2018,1,10],"TX":[0,0,0],"UT":[2018,1,22],"VT":[2018,1,3],"VA":[2018,1,10],"WA":[2018,1,8],"WV":[2018,1,10],"WI":[2018,1,6],"WY":[2018,2,12],"DC":[2018,1,2],"US":[2018,1,5]]
    
    var buttonArray: [UIButton]=[]
    var yPos=10
    let theStoryboard=UIStoryboard(name: "Main", bundle: nil)
    var stateButtonID: String?
    
    
    
    
    //self.presentViewController(nextViewController, animated:true, completion:nil)

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //self.view.addSubview(Spinner())
        if let ViewController=segue.destination as? LegislationSearchController{
            ViewController.stateCode=stateButtonID?.lowercased()
        }
    }
    
    
    
    func pressed(sender: UIButton!)
    {
        self.view.addSubview(Spinner())
        //print("your state is "+stateButtonID)
        //let newVC=theStoryboard.instantiateViewController(withIdentifier: "LegislationSearch") as! LegislationSearchController
        stateButtonID = stateList[stateList.index(of: (sender.titleLabel?.text!)!)!-1]
        //print("your state is "+(stateButtonID?.lowercased())!)
       print(stateButtonID)
        //newVC.stateCode=stateButtonID
        
        performSegue(withIdentifier: "stateToLaw", sender: sender)
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        stateScrollView.contentSize.height=2400
        //stateScrollView.contentSize.width=screenSize.width
        let currentDate=Date()
        var dateComp=DateComponents()
        let currCalendar=Calendar.current
        let currentYear=currCalendar.component(.year, from: currentDate)
        let currentMonth=currCalendar.component(.month, from: currentDate)
        let currentDay=currCalendar.component(.day, from: currentDate)
        print("date state")
        print(currentYear)
        print(currentMonth)
        print(currentDay)
        
        for index in stride(from: 1, to: stateList.count, by: 2)
        {
            buttonArray.append(UIButton(frame: CGRect(x: Int(((UIScreen.main.bounds.width/2)-100) as CGFloat), y: yPos, width: 200, height: 20)))
            //buttonArray.last?.backgroundColor=UIColor.black
            print(stateList[index-1])
            print(sessionDates[stateList[index-1]]![0])
          if(sessionDates[stateList[index-1]]![0] >= currentYear && sessionDates[stateList[index-1]]![1] >= currentMonth && sessionDates[stateList[index-1]]![2] >= currentDay)
            {
                buttonArray.last?.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            else
          {
                buttonArray.last?.setTitleColor(UIColor.lightGray , for: UIControlState.normal)
            }
            buttonArray.last?.setTitleColor(UIColor.red, for: UIControlState.selected)
            buttonArray.last?.setTitle(stateList[index], for: UIControlState.normal)
            buttonArray.last?.titleLabel?.font=UIFont(name: "AmericanTypewriter", size: 20)
            buttonArray.last?.addTarget(self, action: #selector(pressed(sender:)), for: UIControlEvents.touchDown)
            
            
            yPos+=45
        }
        
    
        print(buttonArray)
        
        for buttons in buttonArray
        {
           stateScrollView.addSubview(buttons)
        }
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
