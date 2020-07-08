//
//  ElectionCalendarStateList.swift
//  Civic
//
//  Created by lauren piera on 8/22/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class ElectionCalendarStateList: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var electionCalStates: UITableView!
    var states: [String]=["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Washington, DC","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa", "Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont", "Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    var stateAbbr:[String]=["AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"]
    var selectedStates: [String]=[]
    var buttonArray: [UIButton]=[]
    let savedStates=UserDefaults.standard
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let ElectionCalendar=segue.destination as? ElectionCalendar
        {
            ElectionCalendar.stateAbbr=selectedStates
            savedStates.set(selectedStates, forKey: "savedStates")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(savedStates.array(forKey: "savedStates") != nil)
        {
            selectedStates=savedStates.array(forKey: "savedStates") as! [String]
        }
        self.view.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        electionCalStates.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        print("states are"+String(describing: selectedStates))
        print("count "+String(buttonArray.count))
        for buttons in buttonArray
        {
            print("tag is "+String(buttons.tag))
            for states in selectedStates
            {
                if(buttons.tag==stateAbbr.index(of: states))
                {
                    print("you made it")
                    buttons.setImage(#imageLiteral(resourceName: "checkBoxChecked"), for: UIControlState.normal)
                }
            }
        }
        
        electionCalStates.delegate=self
        electionCalStates.dataSource=self

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func buttonPressed(sender: UIButton)
    {
        //print(sender.state)
        if(sender.currentImage==#imageLiteral(resourceName: "checkBoxChecked"))
        {
            print(sender.tag)
            sender.setImage(#imageLiteral(resourceName: "checkBoxBlank"), for: UIControlState.normal)
            if(selectedStates.contains(stateAbbr[sender.tag]))
            {
                selectedStates.remove(at: selectedStates.index(of: stateAbbr[sender.tag])!)
            }
        }
        else
        {
            print(sender.state)
            sender.setImage(#imageLiteral(resourceName: "checkBoxChecked"), for: UIControlState.normal)
            print(sender.tag)
            selectedStates.append(stateAbbr[sender.tag])
        }
        
        print(selectedStates)
    }

    

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 51
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = electionCalStates.dequeueReusableCell(withIdentifier: "stateSelectionCell", for: indexPath) as! ElectionCalendarState
        
        
        
        print("these are "+String(describing: selectedStates))
        
        
        
        cell.stateCheckButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControlEvents.touchDown)
        cell.stateCheckButton.tag=indexPath.row
        cell.stateLabel.text=states[indexPath.row]
        
    
        
        
        
        if(selectedStates.index(of: stateAbbr[indexPath.row]) != nil)
        {
            print("yes")
            cell.stateCheckButton.setImage(#imageLiteral(resourceName: "checkBoxChecked"), for: UIControlState.normal)
        }
        else{
            print("no")
            cell.stateCheckButton.setImage(#imageLiteral(resourceName: "checkBoxBlank"), for: UIControlState.normal)
        }
        buttonArray.append(cell.stateCheckButton)

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
