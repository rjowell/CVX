//
//  VoteControllerViewController.swift
//  Civic
//
//  Created by lauren piera on 7/22/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit



class VoteControllerViewController: UIViewController {

   
    @IBOutlet weak var VoteController: UIView!
    
  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        do{
           
            let theData=try? Data(contentsOf: URL(string: "https://api.legiscan.com/?key=438bd89d24f6339ea0adcc17fd06cd58&op=getMasterList&state=TX")!)
            
            print(type(of: theData))
        
            var jsonData=try? JSONSerialization.jsonObject(with: theData!) as? [String:Any]
            
            //print(jsonData)
            
            var specificData=jsonData??["masterlist"] as! [String:Any]
            
            for items in specificData
            {
              
                var currentData: NSDictionary=items.value as! NSDictionary
                
                //print(currentData)
                print(currentData["description"] as! String)
            
                
                
                
            }
           
        //var specificData=jsonData??["masterlist"]
        
        //print(specificData)
        /*    var arrayData=jsonData??["masterlist"] as? [String:Any]
            
        for entries in arrayData!
        {
            print(entries)
        }*/
            
        
            
        
        //print(jsonData ?? "1")
            print("hellow")}
        
        catch{
            print("error is \(error)")
        }
        
        

        
        
        // Do any additional setup after loading the view.
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
