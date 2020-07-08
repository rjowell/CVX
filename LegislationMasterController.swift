//
//  LegislationMasterController.swift
//  Civic
//
//  Created by lauren piera on 8/10/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class LegislationMasterController: UIViewController {

    @IBOutlet weak var searchWindow: UIView!
    //var stateAbbr: String!
    //var stateArray=["MD","TX","LA"]
    var stateCode: String?
    var searchResults: [String]=[]
    var isSearchWindow: Bool=false
    
    @IBOutlet weak var searchButton: UIButton!
    //let saveFile=UserDefaults.standard
    var table=UITableView(frame: CGRect(x: 5, y: 50, width: (UIScreen.main.bounds.width) , height: (UIScreen.main.bounds.height) ))
    var controller: StateLawTableController?
    var searchTerms: [String]!
    var searchController: SearchResultsController?

    
    @IBOutlet weak var searchWindowDone: UIButton!
    @IBOutlet weak var legislabel: UILabel!
    var lawsToMonitor: [String:[String]]=[:]
    //let tableController=StateLawTableController as StateLawTableController
    var searchTerm: String!
    
    
    @IBOutlet weak var searchDateField: UIDatePicker!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var showAllBills: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("your state issss "+stateCode!)
        
        table.register(LawBlockPrototypeTableViewCell.self, forCellReuseIdentifier: "newCell")
        controller=StateLawTableController(style: UITableViewStyle.plain, state: stateCode!)
        table.dataSource=controller
        table.delegate=controller
        searchButton.addTarget(self, action: #selector(showSearchWindow), for: UIControlEvents.touchDown)
        searchWindowDone.addTarget(self, action: #selector(searchWindowClose), for: UIControlEvents.touchDown)
        self.view.addSubview(table)
        searchWindow.isHidden=true
        searchWindow.layer.borderWidth=3
        searchWindow.layer.borderColor=UIColor.red.cgColor
        searchWindow.layer.zPosition=1
        searchTextField.layer.borderWidth=1
        showAllBills.addTarget(self, action: #selector(showAllStateBills), for: UIControlEvents.touchDown)
        
        

        // Do any additional setup after loading the view.
    }
    
    func showAllStateBills(sender: UIButton)
    {
        
        
        table.dataSource=controller
        table.delegate=controller
        table.reloadData()
    }
    
    func showSearchWindow(sender: UIButton)
    {
        //print(searchTerms)
        searchTerm=""
        self.searchWindow.isHidden=false
        self.view.bringSubview(toFront: searchWindow)
        //searchTerms.removeAll()
        //searchTextField.text=nil
        
        //searchWindow.first
        //print(searchWindow.isFirstResponder)
    }
    func searchWindowClose(sender: UIButton)
    {
        
        searchResults.removeAll()
        self.searchWindow.isHidden=true
        searchWindow.resignFirstResponder()
        searchTerm=searchTextField.text
        //print(searchTerm)
        searchTerms=searchTerm.components(separatedBy: ",")
        //print(searchTerms)
        searchLaw(state: stateCode!, searchTerms: searchTerms)
        //print(searchResults)
        
        isSearchWindow=true
        searchController=SearchResultsController(style: UITableViewStyle.plain, searchResults: searchResults, stateName: stateCode!)
        //print(searchResults)
        //searchController?.searchResultString=searchResults
        
        
        
        table.delegate=searchController
        table.dataSource=searchController
        table.reloadData()
        
        //self.searchWindow.resignFirstResponder()
    }
    
    func searchLaw(state: String, searchTerms: [String])
    {
        let masterListURL="https://api.legiscan.com/?key=438bd89d24f6339ea0adcc17fd06cd58&op=getMasterList&state="+stateCode!
        let theData=try? Data(contentsOf: URL(string: masterListURL)!)
        var jsonData=try? JSONSerialization.jsonObject(with: theData!) as? [String:Any]
        var specificData=jsonData??["masterlist"] as! [String:Any]
        
        for items in specificData
        {
            if(items.key != "session")
            {
                var currentData: NSDictionary=items.value as! NSDictionary
                var currentTitle=currentData["title"] as! String
                var currentDesc=currentData["description"] as! String
                
                for words in searchTerms
                {
                    if(currentTitle.lowercased().range(of: words.lowercased()) == nil)
                    {
                        if(currentDesc.lowercased().range(of: words) != nil)
                        {
                            //print(currentData["bill_id"])
                            searchResults.append(items.key)
                        }
                    }
                    else
                    {
                        searchResults.append(items.key)
                    }
                }
                
                
            }
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
