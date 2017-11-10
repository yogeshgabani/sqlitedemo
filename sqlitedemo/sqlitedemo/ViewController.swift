//
//  ViewController.swift
//  sqlitedemo
//
//  Created by MACOS on 8/23/17.
//  Copyright © 2017 MACOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }

    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var tbl: UITableView!
    
    var arr :[Any] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = dbclass()
        
        let query = "select * from student"
        let arr = db.getdata(query: query)
        tbl.reloadData()
        print(arr)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func insert(_ sender: Any) {
        
        let db = dbclass()
        let query = "insert into student(id,name,address,city,mobile) values('\(id.text!)','\(name.text!)','\(address.text!)','\(city.text!)','\(mobile.text!)')"
        id.text = "";
        name.text = "";
        address.text = "";
        city.text = "";
        mobile.text = "";
        let st = db.dmloop(query: query)
        // tbl.reloadData()
        if st == true {
            print("record inserted successfully")
            
         //   let alert = UIAlertController(title: "success", message: "record inserted successfully", preferredStyle: .alert)
           // alert.self
            let db = dbclass()
            let query = "select * from student"
            arr = db.getdata(query: query)
            tbl.reloadData()
        }
        else {
            print("record not inserted")
          //  let alert = UIAlertController(title: "unsuccess", message: "record not inserted", preferredStyle: .alert)
          //  alert.self
            
        }
        
        
    }
    @IBAction func selects(_ sender: Any) {
    }
    @IBAction func updat(_ sender: Any) {
        let db = dbclass()
        let update = String(format: "update student set name = '%@',address = '%@',city = '%@',mobile = '%@' where  id = '%@'", name.text!,address.text!,city.text!,mobile.text!,id.text!)
        
        let st = db.dmloop(query: update)
      //  tbl.reloadData()
        if st == true {
            print("record updated successfully")
            //   let alert = UIAlertController(title: "success", message: "record inserted successfully", preferredStyle: .alert)
            // alert.self
            let db = dbclass()
            let query = "select * from student"
            arr = db.getdata(query: query)
            tbl.reloadData()
        }
        else {
            print("record not updated")
            //  let alert = UIAlertController(title: "unsuccess", message: "record not inserted", preferredStyle: .alert)
            //  alert.self
            
        }
        
        
    }
    @IBAction func deletes(_ sender: Any) {
        
        let db = dbclass()
        let delete = String(format: "delete from student where id = '%@'", id.text!)
        
        let st = db.dmloop(query: delete)
       // tbl.reloadData()
        if st == true {
            print("record deleted successfully")
            //   let alert = UIAlertController(title: "success", message: "record inserted successfully", preferredStyle: .alert)
            // alert.self
            let db = dbclass()
            let query = "select * from student"
            arr = db.getdata(query: query)
            tbl.reloadData()
        }
        else {
            print("record not deleted")
            //  let alert = UIAlertController(title: "unsuccess", message: "record not inserted", preferredStyle: .alert)
            //  alert.self
            
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var trmp = arr[indexPath.section] as! [String]
        cell.textLabel?.text = trmp[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var temp = arr[indexPath.section] as! [String]
        id.text! = temp[0]
        name.text! = temp[1]
        address.text! = temp[2]
        city.text! = temp[3]
        mobile.text! = temp[4]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

