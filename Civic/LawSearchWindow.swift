//
//  LawSearchWindow.swift
//  Civic
//
//  Created by lauren piera on 10/18/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit








class LawSearchWindow: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    
    
    
    
    
    

    
    let stateList: [String]=["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Washington, DC","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa", "Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont", "Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    
    let stateAbbr: [String]=["AL","AK","AZ","AR","CA","CO","CT","DE","washington","FL","GA","HI","ID","IL", "IN","IA","KS","KY","Louisiana","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC", "ND","OH","OK","OR","PA","rhodeisland","SC","SD","TN","TX","UT","VT","VA","Washingtonstate","WV","WI","WY"]
    
    
    var currentState: String=""
    var currentStateAbbr: String=""
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 51
    }
    
    //var parentController: RepresentativeFinder!
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        currentState=stateList[row]
        currentStateAbbr=stateAbbr[row]
    }
    
    var addressText: String=""
    
    
    @IBAction func getAddress(_ sender: Any) {
        
        addressText=(sender as! UITextField).text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // parentController=self.parent as! RepresentativeFinder
        //newDelegate=SearchFinderDelegate()
        print("it loaded")
       // newDelegate?.getResults(results: "hello there joe")
        
        dataSource=self
        delegate=self
        print("this isssss parent")
        print(self.parent)
        setViewControllers([localSearchWindow], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        searchControllers.append(localSearchWindow)
        searchControllers.append(stateSearchWindow)
        //localSearchButton.addTarget(self, action: #selector(testSend), for: UIControlEvents.touchDown)
        
        
    }
    
    public func testSend(sender: UIButton)
    {
        //parentController.testMethod(theString: "hello there how are you")
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var stateWheel: UIPickerView!
    
    @IBOutlet weak var stateCancelButton: UIButton!
    
    @IBOutlet weak var stateSearchButton: UIButton!
    
    var searchTerm: String="hello there, this is a test"
    //var stateAbbr: String=""
    
    @IBOutlet weak var localSearchField: UITextField!
    
    @IBOutlet weak var localCancelButton: UIButton!
    
    @IBOutlet weak var localSearchButton: UIButton!
    
    var testInteger: Int=12345
    
    
    
    
    var currentController: UIViewController?
    /*var localSearchWindow: UIViewController=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocalSearch")
    var stateSearchWindow: UIViewController=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StateSearch")
    */
    
    var localSearchWindow: UIViewController=LocalSearchWindow()
    var stateSearchWindow: UIViewController=StateSearchController()
    var searchControllers: [UIViewController]=[]
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if(searchControllers.index(of: viewController)==1)
        {
            return nil
        }
        else
        {
            return searchControllers[1]
        }
        
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if(searchControllers.index(of: viewController)==0)
        {
            return nil
        }
        else
        {
            return searchControllers[0]
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
