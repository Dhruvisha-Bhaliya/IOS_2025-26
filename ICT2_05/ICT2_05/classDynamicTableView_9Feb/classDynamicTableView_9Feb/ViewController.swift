//
//  ViewController.swift
//  classDynamicTableView_9Feb
//
//  Created by ict2batch1 on 09/02/26.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var txtname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    var names : [String] = []
    
    @IBAction func btnadd(_ sender: UIButton) {
        if let text = txtname.text, !text.isEmpty{
            names.append(text)
            tblview.reloadData()
            txtname.text = ""
        }
    }
}

