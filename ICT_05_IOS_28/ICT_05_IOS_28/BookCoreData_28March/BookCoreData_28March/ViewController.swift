//
//  ViewController.swift
//  BookCoreData_28March
//
//  Created by ICT2Batch1 on 28/03/26.
//

import UIKit
import CoreData

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genrelist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedgenre = genrelist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genrelist[row]
    }

    @IBOutlet weak var publishdate: UIDatePicker!
    @IBOutlet weak var booktitle: UITextField!
    @IBOutlet weak var bookdescription: UITextField!
    @IBOutlet weak var author: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filepath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        print(filepath!)
        // Do any additional setup after loading the view.
    }
    
    var selectedgenre = ""
    let genrelist=["Text books", "Research Books", "Journals", "Law", "Engineering"]

    @IBAction func BtnSubmit(_ sender: UIButton) {
        let appDel = UIApplication.shared.delegate as!AppDelegate
        let ctx = appDel.persistentContainer.viewContext
        let obj = Book_Table(context: ctx)
        
        let dt = DateFormatter()
        dt.dateFormat = "dd/MM/yy"
        let selectedDate = dt.string(from:publishdate.date)
        obj.publishdate = selectedDate
        
        obj.genre = selectedgenre
        
        obj.bookid = UUID()
        obj.author = author.text!
        obj.bookdescription = bookdescription.text!
        obj.booktitle = booktitle.text!
        do {
            try ctx.save()
            print("Inserted")
        }catch{
            print("Error",error.localizedDescription)
        }
        
    }
    
}

