

import UIKit
import MessageUI



class BooksViewController: UITableViewController,MFMailComposeViewControllerDelegate{
    
    
    
    
    var userName = [String]()
    var bookDescription = [String]()
    var bookName = [String]()
    var userEmail = [String]()
    let rest1 = RestCall1()
    
    
    override func viewDidLoad() {
        self.title = "Buy & Sell Books"
        rest1.getJSON("https://web.njit.edu/~au56/getbooks.php")
        super.viewDidLoad()
        
       let PostButton : UIBarButtonItem = UIBarButtonItem(title: "Sell", style: UIBarButtonItemStyle.Plain, target: self, action:Selector("postBooks:"))
        
        
        self.navigationItem.rightBarButtonItem = PostButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rest1.userName.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("booksTableCell", forIndexPath: indexPath)
            as! BooksTableControllerCell
        let row = indexPath.row
        cell.userName.text = rest1.userName[row]
        cell.bookName.text = rest1.bookName[row]
        cell.bookDescription.text = rest1.bookDescription[row]
        
        
        
        
        return cell
    }
    
    
    
    
    
    
    @IBAction func BuySendEmail(sender: AnyObject) {
        
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["seller@domain.com"])
        mailComposerVC.setSubject("Interested in buying this book")
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Title", message: "Message",preferredStyle:.Alert)
        
        let okAction = UIAlertAction(title:"OK",style:.Cancel){(action) in }
        
        sendMailErrorAlert.addAction(okAction)
        
        self.presentViewController(sendMailErrorAlert, animated: true){
            
        }
    }
    
    
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postBooks(sender: UIBarButtonItem!) {
        self.performSegueWithIdentifier("toBooks", sender: self)

    
}


}


