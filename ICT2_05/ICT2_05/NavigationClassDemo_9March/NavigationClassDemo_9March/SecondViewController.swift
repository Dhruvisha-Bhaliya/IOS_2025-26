//
//  SecondViewController.swift
//  NavigationClassDemo_9March
//
//  Created by ict2batch1 on 09/03/26.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblred: UILabel!
    
    var secondvariable : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        lblred.text = secondvariable
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
