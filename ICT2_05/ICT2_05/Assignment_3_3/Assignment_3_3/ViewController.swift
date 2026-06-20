//
//  ViewController.swift
//  Assignment_3_3
//
//  Created by ict2batch1 on 02/03/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func LeftGesture(_ sender: UISwipeGestureRecognizer) {
        self.view.backgroundColor = .red
//    case .left : self.view.backgroundColor = .red
    }
    
    @IBAction func RightGesture(_ sender: UISwipeGestureRecognizer) {
        self.view.backgroundColor = .yellow
    }
    
    @IBAction func UpGesture(_ sender: UISwipeGestureRecognizer) {
        self.view.backgroundColor = .green
    }
    
    @IBAction func DownGesture(_ sender: UISwipeGestureRecognizer) {
        self.view.backgroundColor = .blue
    }
}

