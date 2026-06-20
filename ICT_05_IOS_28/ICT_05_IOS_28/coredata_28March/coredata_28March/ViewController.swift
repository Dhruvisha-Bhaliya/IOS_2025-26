//
//  ViewController.swift
//  coredata_28March
//
//  Created by ICT2Batch1 on 28/03/26.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filepath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        print("DB Opned: ",filepath ?? "")
        print(filepath!)
        // Do any additional setup after loading the view.
    }

    @IBAction func btnadd(_ sender: UIButton) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let mac = appDel.persistentContainer.viewContext
        let obj = Employee(context: mac)
        obj.id = UUID()
        obj.name = name.text!
        obj.email = email.text!
        obj.password = password.text!
        
        do{
            try mac.save()
//            print("Data Inserted")
            alertSuccess()
        }catch{
            print("Errror: ",error.localizedDescription)
        }
    }
    
    func alertSuccess(){
        let alert = UIAlertController(title: "Inserted", message: "Success", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: {_ in self.navigate()}))
        alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
        present(alert,animated: true)
    }
    
    
}

