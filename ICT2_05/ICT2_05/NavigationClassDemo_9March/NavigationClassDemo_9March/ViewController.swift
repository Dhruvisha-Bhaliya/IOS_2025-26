//
//  ViewController.swift
//  NavigationClassDemo_9March
//
//  Created by ict2batch1 on 09/03/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRedColor" {

        let destination = segue.destination as! SecondViewController
            destination.secondvariable = txtname.text
        }
        else if segue.identifier == "ShowPurpleColor" {
            let dest = segue.destination as! ThirdViewController
            dest.thirdvariable = txtname.text
        }
        
    }


}

