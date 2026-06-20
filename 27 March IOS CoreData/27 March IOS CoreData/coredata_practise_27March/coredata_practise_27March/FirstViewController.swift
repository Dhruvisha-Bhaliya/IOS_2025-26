//
//  FirstViewController.swift
//  coredata_practise_27March
//
//  Created by ict2batch1 on 27/03/26.
//

import UIKit
import CoreData

class FirstViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorylist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categorylist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorylist[row]
    }
    
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var fooddate: UIDatePicker!
    @IBOutlet weak var foodname: UITextField!
    @IBOutlet weak var fooddescription: UITextField!
    @IBOutlet weak var category: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var selectedCategory = ""
    let categorylist = ["BreakFast", "Meal", "Dinner", "FastFood Combo", "Vegan Food"]
    

    @IBAction func btnadd(_ sender: UIButton) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let mac = appDel.persistentContainer.viewContext
        let obj = Shop_Table(context: mac)
      
        let ft = DateFormatter()
        ft.dateFormat = "dd/MM/yy"
        let selectedDate = ft.string(from:fooddate.date)

        obj.foodID = UUID()
        obj.foodName = foodname.text!
        obj.category = selectedCategory
        obj.price = Float(price.text!) ?? 0
        obj.fooddescription = fooddescription.text!
        obj.date = selectedDate
        
//        print("Desc:", fooddescription.text)
//        print("ID:", obj.foodID)
        do {
            try mac.save()
            print("Inserted")
        }catch {
            print("error: ",error.localizedDescription)
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
