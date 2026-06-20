//
//  ViewController.swift
//  Assignment_3_1
//
//  Created by ict2batch1 on 10/02/26.
//

import UIKit

struct Student {
    var roll: String
    var name: String
    var marks: String
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
               
               let student = studentArray[indexPath.row]
               
        cell.textLabel?.numberOfLines = 0   // allow multiple lines
                
                cell.textLabel?.text =
                "Roll No : \(student.roll)\n" +
                "Name    : \(student.name)\n" +
                "Marks   : \(student.marks)"
               
               return cell
    }
    

    @IBOutlet weak var txtrollno: UITextField!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var txtmarks: UITextField!
    
    var studentArray : [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnadd(_ sender: UIButton) {
        if txtrollno.text != "" &&
            txtname.text != "" &&
            txtmarks.text != "" {
            
            let newStudent = Student(roll: txtrollno.text!, name: txtname.text!, marks: txtmarks.text!)
            
            
            studentArray.append(newStudent)
            tblview.reloadData()
        }
    }
    
}


