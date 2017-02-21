//
//  FirstViewController.swift
//  eToDoApp
//
//  Created by Jose Alejandro Apablaza on 2017-02-18.
//  Copyright © 2017 Jose Alejandro Apablaza. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var list:[String] = []
    var handle:FIRDatabaseHandle?
    var ref:FIRDatabaseReference?
    
    
    @IBOutlet weak var input: UITextField!
    
    @IBAction func addItem(_ sender: Any)
    {
        ref = FIRDatabase.database().reference()
        
        if input.text != ""
        {
            //list.append(input.text!)
            
            ref = FIRDatabase.database().reference()
            
            if input.text != ""
            {
                ref?.child("list").childByAutoId().setValue(input.text)
                input.text = ""
            }
            
        }
        
    }
    @IBOutlet weak var myTableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let item = self.list[indexPath.row]
            ref = FIRDatabase.database().reference()
            list.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = FIRDatabase.database().reference()
        
        handle = ref?.child("list").observe(.childAdded, with: { (snapshot) in
            
            if let item = snapshot.value as? String
            {
                
                self.list.append(item)
                self.myTableView.reloadData()
            }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
        
    
}
