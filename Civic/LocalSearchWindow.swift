//
//  LocalSearchWindow.swift
//  Civic
//
//  Created by lauren piera on 10/18/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit



class LocalSearchWindow: UIViewController {
   
    
    
    
    var textDelegate: TestingProtocol?
    
    @IBOutlet weak var localSearchText: UITextField!
    
    @IBOutlet weak var localSearchButton: UIButton!
    
    func buttonPressed(sender: UIButton)
    {
        
        //textDelegate=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Representative Finder Main") as! TestingProtocol
        print("spot1")
        //performSegue(withIdentifier: "backToTable", sender: nil)
        //textDelegate?.showTheText(inputData: "hello joseph")
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //textDelegate=currentVC as! LocalSearchInputDelegate
        //localSearchButton.addTarget(self, action: #selector(buttonPressed), for: UIControlEvents.touchDown)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
