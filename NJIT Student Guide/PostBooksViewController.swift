//
//  PostLostItemViewController.swift
//  NJIT Student Guide
//
//  Created by Venkatesh Muthukrishnan on 10/25/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit


class PostBooksViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var bookDescription: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var bookName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var bookCost: UITextField!
    
    var url = NSURL(string: "https://web.njit.edu/~au56/postbooks.php")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sell Books"
        self.bookDescription.delegate = self
        self.bookName.delegate = self
        self.userEmail.delegate = self
        self.userName.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    @IBAction func Post(sender: AnyObject) {
        //
        var x = bookName.text!
        var y = bookCost.text!
        var z = x + " for $" + y
        postJSON(userName.text!,useremail: userEmail.text!,bookname: z,bookdescription: bookDescription.text!)
        
    }
    
  
   
func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false
    }

    




func postJSON(username: String!,useremail: String!,bookname: String!,bookdescription: String!) {
    let myUrl = NSURL(string: "https://web.njit.edu/~au56/postbooks.php")
    let request = NSMutableURLRequest(URL:myUrl!)
    request.HTTPMethod = "POST"
    let postString = "username='\(username)'&useremail='\(useremail)'&bookname='\(bookname)'&bookdescription='\(bookdescription)'"
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request,completionHandler: {data,response, error ->
        Void in
        
        do{
            
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray

            print(json)
        }catch _ as NSError{
            print(error)
            
        }
        
        
        
    })
    task.resume()
    
}
    
}

