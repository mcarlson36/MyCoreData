//
//  ViewController.swift
//  MyCOntacts222
//
//  Created by Charles Konkol on 10/11/2021.
//  Copyright © 2019 Charles Konkol. All rights reserved.
//
import UIKit
//0) Add import for CoreData
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var booktitle: UITextField!
    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var datepublished: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBAction func btnEdit(_ sender: UIButton) {
        //**Begin Copy**
        
        //0a Edit contact
        booktitle.isEnabled = true
        author.isEnabled = true
        datepublished.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        booktitle.becomeFirstResponder()
        
        //**End Copy**
    }
    
    
    @IBAction func btnSave(_ sender: AnyObject) {
        //**Begin Copy**
        //1 Add Save Logic
        
        
        if (contactdb != nil)
        {
            
            contactdb.setValue(booktitle.text, forKey: "fullname")
            contactdb.setValue(author.text, forKey: "email")
            contactdb.setValue(datepublished.text, forKey: "phone")
            
        }
        else
        {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Contact",in: managedObjectContext)
            
            let contact = Contact(entity: entityDescription!,
                                  insertInto: managedObjectContext)
            
            contact.booktitle = booktitle.text!
            contact.author = author.text!
            contact.datepublished = datepublished.text!
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            //if error occurs
           // status.text = err.localizedFailureReason
        } else {
            self.dismiss(animated: false, completion: nil)
            
        }
        //**End Copy**
    }
    
    @IBAction func btnBack(_ sender: AnyObject) {
        
        //**Begin Copy**
        //2) Dismiss ViewController
       self.dismiss(animated: true, completion: nil)
//       let detailVC = ContactTableViewController()
//        detailVC.modalPresentationStyle = .fullScreen
//        present(detailVC, animated: false)
        //**End Copy**
    }
    
    //**Begin Copy**
    //3) Add ManagedObject Data Context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //**End Copy**
    
    
    //**Begin Copy**
    //4) Add variable contactdb (used from UITableView
    var contactdb:NSManagedObject!
    //**End Copy**
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //**Begin Copy**
        //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
        
        
        if (contactdb != nil)
        {
            booktitle.text = contactdb.value(forKey: "fullname") as? String
            author.text = contactdb.value(forKey: "email") as? String
            datepublished.text = contactdb.value(forKey: "phone") as? String
            btnSave.setTitle("Update", for: UIControl.State())
           
            btnEdit.isHidden = false
            booktitle.isEnabled = false
            author.isEnabled = false
            datepublished.isEnabled = false
            btnSave.isHidden = true
        }else{
          
            btnEdit.isHidden = true
            booktitle.isEnabled = true
            author.isEnabled = true
            datepublished.isEnabled = true
        }
        booktitle.becomeFirstResponder()
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //**End Copy**
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //**Begin Copy**
    //6 Add to hide keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches , with:event)
        if (touches.first as UITouch?) != nil {
            DismissKeyboard()
        }
    }
    //**End Copy**
    
    
    //**Begin Copy**
    //7 Add to hide keyboard
    
    @objc func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        booktitle.endEditing(true)
        author.endEditing(true)
        datepublished.endEditing(true)
        
    }
    //**End Copy**
    
    //**Begin Copy**
    
    //8 Add to hide keyboard
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }
    //**End Copy**
}
