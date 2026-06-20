//
//  ViewController.swift
//  classStaticTableView_9Feb
//
//  Created by ict2batch1 on 09/02/26.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var tblview: UITableView!
    
    let countries = ["US","UK","AUS","Canada","India"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

