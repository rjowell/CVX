//
//  FeedbackScreen.swift
//  Civic
//
//  Created by lauren piera on 10/4/17.
//  Copyright © 2017 Russell Jowell. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackScreen: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var commentBox: UITextView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var thanksScreen: UIView!
    
    @IBOutlet weak var feedbackDesc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor(red: 0, green: 0.25, blue: 0.50, alpha: 1.5)
        thanksScreen.isHidden=true
        sendButton.addTarget(self, action: #selector(sendFeedback), for: UIControlEvents.touchDown)
        cancelButton.addTarget(self, action: #selector(cancelScreen), for: UIControlEvents.touchDown)
        feedbackDesc.numberOfLines=0
        feedbackDesc.lineBreakMode=NSLineBreakMode.byWordWrapping
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view.
    }
    
    func cancelScreen(sender: UIButton)
    {
        self.view.addSubview(Spinner())
    }
   
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }    
    
    
    let mailer=MFMailComposeViewController()
    
    func sendFeedback(sender: UIButton)
    {
        let messageText=commentBox.text
        
        mailer.mailComposeDelegate=self
        mailer.setToRecipients(["russ@cvx4u.com"])
        mailer.setSubject("App Feedback")
        mailer.setMessageBody(messageText!, isHTML: false)
        
        self.present(mailer, animated: true, completion: nil)
                     }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func mailCompleted()
    {
        print("succes")
        thanksScreen.isHidden=false
        mailer.dismiss(animated: true)
        performSegue(withIdentifier: "backToMain", sender: self)
        
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
