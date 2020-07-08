//
//  RepresentativeView.swift
//  Civic
//
//  Created by lauren piera on 9/11/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class RepresentativeView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var representativeResults: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        representativeResults.delegate=self
        representativeResults.dataSource=self

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theCell=representativeResults.dequeueReusableCell(withIdentifier: "RepresentativeResultCell", for: indexPath) as! RepresentativeViewCell
        
        let picUrl=URL(string:"http://bioguide.congress.gov/bioguide/photo/M/M001153.jpg")
        let photoData=try? Data(contentsOf: picUrl!)
        let thePhoto=UIImage(data: photoData!)
        print(thePhoto?.size.height)
        theCell.govTitle.text="Hello"
        theCell.govPhoto.image=UIImage(data: photoData!)
        
        return theCell
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
