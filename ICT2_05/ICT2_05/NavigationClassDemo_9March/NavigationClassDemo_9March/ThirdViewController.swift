//
//  ThirdViewController.swift
//  NavigationClassDemo_9March
//
//  Created by ict2batch1 on 09/03/26.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var lblpurple: UILabel!
    
    var thirdvariable : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblpurple.text = thirdvariable
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
