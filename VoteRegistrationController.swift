//
//  VoteRegistrationController.swift
//  Civic
//
//  Created by lauren piera on 7/28/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit

class VoteRegistrationController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var resultsTable: UITableView!
    
    var stateAbbreviations: [String]=[]
    var stateNames: [String]=[]
    var voteInfoLinks: [String]=[]
    var onlineLink: [String]=[]
    var voterInformation: [[String]]=[
        ["AL","Alabama","http://sos.alabama.gov/alabama-votes/voter/register-to-vote","https://www.alabamainteractive.org/sos/voter_registration/voterRegistrationWelcome.action"],
        ["AK","Alaska","https://voterregistration.alaska.gov","https://voterregistration.alaska.gov/Registration/RegistrationDetails?haveValidAKDL=true"],
        ["AR","Arkansas","http://www.sos.arkansas.gov/elections/Pages/voterRegistration.aspx","nil"],
        ["AZ","Arizona","https://www.azsos.gov/elections/voting-election/register-vote-or-update-your-current-voter-information","https://servicearizona.com/webapp/evoter/selectLanguage"],
        ["CA","Calfornia","http://www.sos.ca.gov/elections/voter-registration/","http://registertovote.ca.gov"],
        ["CO","Colorado","http://www.sos.state.co.us/pubs/elections/main.html","https://www.sos.state.co.us/voter-classic/pages/pub/olvr/verifyNewVoter.xhtml"],
        ["CT","Connecticut","http://www.sots.ct.gov/sots/cwp/view.asp?a=3172&q=525432","https://voterregistration.ct.gov/OLVR/welcome.do"],
        ["DE","Delaware","http://electionsncc.delaware.gov/votreg.shtml","https://ivote.de.gov/voterlogin.aspx"],
        ["FL","Florida","http://dos.myflorida.com/elections/for-voters/voter-registration/register-to-vote-or-update-your-information/","https://registertovoteflorida.gov"],
        ["GA","Georgia","https://registertovote.sos.ga.gov/GAOLVR/welcome.do#no-back-button","https://registertovote.sos.ga.gov/GAOLVR/welcometoga.do#no-back-button"],
        ["HI","Hawaii","http://elections.hawaii.gov/frequently-asked-questions/online-voter-registration/","https://olvr.hawaii.gov"],
        ["ID","Idaho","http://www.idahovotes.gov/voter_info.shtml","nil"],
        ["IL","Illinois","https://www.elections.il.gov/votinginformation/register.aspx","https://ova.elections.il.gov"],
        ["IN","Indiana","https://indianavoters.in.gov/publicsite/ovr/introduction.aspx","https://indianavoters.in.gov/publicsite/ovr/introduction.aspx"],
        ["IA","Iowa","https://sos.iowa.gov/elections/voterinformation/voterregistration.html","https://mymvd.iowadot.gov/Account/Login?ReturnUrl=%2fVoterRegistration"],
        ["KS","Kansas","http://www.kssos.org/elections/elections_registration.html","https://www.kdor.ks.gov/Apps/VoterReg/Default.aspx"],
        ["KY","Kentucky","http://elect.ky.gov/registertovote/Pages/default.aspx","https://vrsws.sos.ky.gov/ovrweb/"],
        ["LA","Louisiana","http://www.sos.la.gov/electionsandvoting/registertovote/Pages/default.aspx","https://voterportal.sos.la.gov/VoterRegistration"],
        ["ME","Maine","http://www.maine.gov/sos/cec/elec/voter-info/votreg.html","nil"],
        ["MD","Maryland","http://elections.maryland.gov/voter_registration/index.html","https://voterservices.elections.maryland.gov/OnlineVoterRegistration/InstructionsStep1"],
        ["MA","Massachusetts","https://www.sec.state.ma.us/ele/eleifv/howreg.htm","https://www.sec.state.ma.us/ovr/"],
        ["MI","Michigan","http://www.michigan.gov/sos/0,4670,7-127-1633_8716_8726_47669---,00.html","nil"],
        ["MN","Minnesota","http://www.sos.state.mn.us/elections-voting/register-to-vote/","https://mnvotes.sos.state.mn.us/VoterRegistration/VoterRegistrationMain.aspx"],
        ["MS","Mississippi","http://www.sos.ms.gov/elections-voting/pages/voter-registration-information.aspx","nil"],
        ["MO","Missouri","https://www.sos.mo.gov/elections/govotemissouri/register","https://s1.sos.mo.gov/votemissouri/request"],
        ["MT","Montana","https://sos.mt.gov/elections/vote/index","nil"],
        ["NE","Nebraska","https://www.nebraska.gov/apps-sos-voter-registration/","https://www.nebraska.gov/apps-sos-voter-registration/"],
        ["NV","Nevada","https://nvsos.gov/sosvoterservices/Registration/step1.aspx","https://nvsos.gov/sosvoterservices/Registration/step1.aspx"],
        ["NH","New Hampshire","http://sos.nh.gov/VoterRegFAQ.aspx","nil"],
        ["NJ","New Jersey","http://www.njelections.org/voting-information.html","nil"],
        ["NM","New Mexico","http://www.sos.state.nm.us/Voter_Information/Voter_Registration_Information.aspx","nil"],
        ["NY","New York","http://www.elections.ny.gov/votingregister.html","nil"],
        ["NC","North Carolina","http://www.ncsbe.gov/Voters/Registering-to-Vote","nil"],
        ["ND","North Dakota","No Voter Registration","nil"],
        ["OH","Ohio","https://olvr.sos.state.oh.us","https://olvr.sos.state.oh.us"],
        ["OK","Oklahoma","https://www.ok.gov/elections/Voter_Info/Register_to_Vote/","nil"],
        ["OR","Oregon","http://sos.oregon.gov/voting/Pages/updatevoterregistration.aspx","https://secure.sos.state.or.us/orestar/vr/register.do?lang=eng&source=SOS"],
        ["PA","Pennsylvania","https://www.pavoterservices.pa.gov/Pages/VoterRegistrationApplication.aspx","https://www.pavoterservices.pa.gov/Pages/VoterRegistrationApplication.aspx"],
        ["RI","Rhode Island","http://www.elections.state.ri.us/voting/registration.php","https://vote.sos.ri.gov"],
        ["SC","South Carolina","https://www.scvotes.org","https://info.scvotes.sc.gov/eng/ovr/start.aspx"],
        ["SD","South Dakota","https://sdsos.gov/elections-voting/voting/register-to-vote/default.aspx","nil"],
        ["TN","Tennessee","http://sos.tn.gov/products/elections/register-vote","https://ovr.govote.tn.gov"],
        ["TX","Texas","http://www.votetexas.gov/register-to-vote/","nil"],
        ["UT","Utah","https://secure.utah.gov/voterreg/index.html","https://secure.utah.gov/voterreg/index.html"],
        ["VT","Vermont","https://www.sec.state.vt.us/elections/voters/registration.aspx","https://olvr.sec.state.vt.us"],
        ["VA","Virginia","http://www.elections.virginia.gov/voter-outreach/","https://vote.elections.virginia.gov/Registration/Eligibility"],
        ["WA","Washington","http://www.dol.wa.gov/driverslicense/voter.html","https://weiapplets.sos.wa.gov/MyVoteOLVR/MyVoteOLVR"],
        ["DC","Washington, DC","https://www.vote4dc.com/ApplyInstructions/Register","https://www.vote4dc.com/ApplyInstructions/Register"],
        ["WV","West Virginia","https://ovr.sos.wv.gov/Register/Landing","https://ovr.sos.wv.gov/Register/Landing"],
        ["WI","Wisconsin","https://myvote.wi.gov/en-us/","https://myvote.wi.gov/en-us/VoterRegistration"],
        ["WY","Wyoming","http://soswy.state.wy.us/Elections/RegisteringToVote.aspx","nil"]
    ]//end of array of arrays

    var infoURL: URL?
    var infoButtonArray = [UIButton]()
    var onlineButtonArray = [UIButton]()
    var infoArrayCount: Int=0
    var onlineArrayCount: Int=0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 51
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell=resultsTable.dequeueReusableCell(withIdentifier: "stateRegistrationCell", for: indexPath) as! VoterRegistraionCell
        
        print(indexPath.row)
        
        newCell.stateName.text=stateNames[indexPath.row]
        newCell.infoLink.addTarget(self, action: #selector(openInfoLink), for: UIControlEvents.touchDown)
        newCell.onlineRegistration.addTarget(self, action: #selector(openOnlineLink), for: UIControlEvents.touchDown)
        //print(voterInformation[indexPath.row][3])
       if(voteInfoLinks[indexPath.row] == "No Voter Registration")
        {
            newCell.infoLink.setTitle("No Voter Registration", for: UIControlState.normal)
            //newCell.onlineRegistration.isHidden=true
        }
        else
        {
            newCell.infoLink.tag=indexPath.row
            newCell.infoLink.setTitle("Information", for: UIControlState.normal)
            //print(voterInformation[indexPath.row][3])
            if(onlineLink[indexPath.row] != "nil")
            {   newCell.onlineRegistration.isHidden=false
                newCell.onlineRegistration.tag=indexPath.row}
            
        }
        
        return newCell
    }
    
    
    
   
    func openInfoLink(sender: UIButton)
   {
    
    if(voteInfoLinks[sender.tag].range(of: "http") != nil)
    {
    
    infoURL=URL(string: voteInfoLinks[sender.tag])
    UIApplication.shared.open(infoURL!, options: [:], completionHandler: nil)
    
    }
    }
    func openOnlineLink(sender: UIButton)
    {
        
        if(onlineLink[sender.tag].range(of: "http") != nil)
        {
        
        infoURL=URL(string: onlineLink[sender.tag])
        
        UIApplication.shared.open(infoURL!, options: [:], completionHandler: nil)
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        resultsTable.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        print(voterInformation.count)
        for items in voterInformation
        {
            stateAbbreviations.append(items[0])
            stateNames.append(items[1])
            voteInfoLinks.append(items[2])
            onlineLink.append(items[3])
        }
        
        
        resultsTable.delegate=self
        resultsTable.dataSource=self
        
        
        
       
        // Do any additional setup after loading the view.
}

    override func didReceiveMemoryWarning() {
        /*[Abbreviation,State Name,Voter Info,Online (nil if none)]   */}
    
    
        
    
    
    
    
    
    
   
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}
