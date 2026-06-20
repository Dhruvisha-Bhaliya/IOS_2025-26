//
//  SecondViewController.swift
//  EmployeeRegistrationCoreData_30March
//
//  Created by apple on 30/03/26.
//

import UIKit
import CoreData

class SecondViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderlist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = genderlist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderlist[row]
    }

    @IBOutlet weak var dob: UIDatePicker!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var Username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var selectedGender = ""
    let genderlist = ["Male","Female"]
    

    @IBAction func BtnRegister(_ sender: UIButton) {
        let AppDel = UIApplication.shared.delegate as! AppDelegate
        let ctx = AppDel.persistentContainer.viewContext
        let obj = Employee_Table(context:ctx)
        
        let dt = DateFormatter()
        dt.dateFormat = "dd/MM/yy"
        let selecteddob = dt.string(from: dob.date)
        obj.dob = selecteddob
        obj.empid = UUID()
        obj.email = email.text!
        obj.password = password.text!
        obj.username = Username.text!
        obj.gender = selectedGender
        do{
            try ctx.save()
            print("Inserted")
        }catch{
            print("erorr",error.localizedDescription)
        }
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
