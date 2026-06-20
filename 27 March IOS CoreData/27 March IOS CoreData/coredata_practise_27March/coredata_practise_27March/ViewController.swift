//
//  ViewController.swift
//  coredata_practise_27March
//
//  Created by ict2batch1 on 27/03/26.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filepath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        print(filepath!)
        // Do any additional setup after loading the view.
    }

    @IBAction func BtnLogin(_ sender: UIButton) {
        if username.text == "a" && password.text == "b"
        {
            alertSuccess()
        }
        else{
            alertFail()
        }
    }
    
    func navigate(){
        let next = storyboard?.instantiateViewController(withIdentifier: "first") as!
        FirstViewController;
        navigationController?.pushViewController(next, animated: true)
    }
    
    func alertSuccess(){
        let alert = UIAlertController(title: "Login", message: "Success", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in self.navigate()}))
        present(alert, animated: true)
    }
    
    func alertFail(){
        let alert = UIAlertController(title: "Login", message: "Failed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
        present(alert, animated: true)

    }
    
    
    
}

