//
//  ViewController.swift
//  EmployeeRegistrationCoreData_30March
//
//  Created by apple on 30/03/26.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filepath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        print(filepath!)
        // Do any additional setup after loading the view.
    }


    @IBAction func BtnLogin(_ sender: UIButton) {
        if username.text == "" || password.text == "" {
               alertFail()
               return
           }
        let AppDel = UIApplication.shared.delegate as! AppDelegate
        let ctx = AppDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<Employee_Table>(entityName: "Employee_Table")
        
        do{
            let data = try ctx.fetch(request)
            
            var isFound = false  

                   for item in data {
                       if item.username == username.text && item.password == password.text {
                           isFound = true
                           break
                       
                }
            }
            if isFound {
            alertSuccess()
        } else {
            alertFail()
        }

        }catch{
            print("Error",error.localizedDescription)
        }
    }
    
    func alertSuccess() {
        let alert = UIAlertController(title: "Login", message: "Success", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: { _ in
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let next = sb.instantiateViewController(withIdentifier: "SecondViewController")
            self.navigationController?.pushViewController(next, animated: true)
            
        }))
        present(alert,animated: true)
    }
    
    func alertFail(){
        let alert = UIAlertController(title: "Login", message: "Failed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
        present(alert,animated: true)
    }
}

