//
//  ViewController.swift
//  demo1
//
//  Created by ict2batch1 on 27/01/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnsubmit(_ sender: UIButton) {
        lbl1.text="Hello World!"
    }
}

