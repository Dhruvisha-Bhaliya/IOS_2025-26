//
//  ViewController.swift
//  Form
//
//  Created by ict2batch1 on 03/02/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtv2: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var txtv1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnsubmit(_ sender: Any) {
        let first = Double(txtv1.text ?? " ") ?? 0
        let second = Double(txtv2.text ?? " ") ?? 0

       // let sum = first + second
       // let mul = first * second
        let divisible = first / second
       // result.text = String(mul)
        result.text = String(divisible)
    } 
}

