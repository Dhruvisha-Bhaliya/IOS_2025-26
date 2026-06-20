//
//  ViewController.swift
//  LibraryCoreData_30March
//
//  Created by apple on 30/03/26.
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
        SelectedGenre = genrelist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genrelist[row]
    }
    

    @IBOutlet weak var bookdescription: UITextField!
    @IBOutlet weak var publishdate: UIDatePicker!
    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var booktitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filepath = FileManager.default.urls(for:.applicationSupportDirectory, in: .userDomainMask).first
        print(filepath!)
        // Do any additional setup after loading the view.
    }
    
    var SelectedGenre = ""
    let genrelist = ["Text books", "Research Books", "Journals", "Law", "Engineering"]


    @IBAction func BtnSubmit(_ sender: UIButton) {
        let appDel = UIApplication.shared.delegate as!AppDelegate
        let ctx = appDel.persistentContainer.viewContext
        let obj = Book_Table(context: ctx)
        
        let dt = DateFormatter()
        dt.dateFormat = "dd/MM/yy"
        let selectedDate = dt.string(from: publishdate.date)
        obj.bookid = UUID()
        obj.booktitle = booktitle.text!
        obj.author = author.text!
        obj.bookdescription = bookdescription.text!
        obj.genre = SelectedGenre
        obj.publishdate = selectedDate
        do{
            try ctx.save()
//            print("Inserted")
            alertSuccess()
           
        }catch{
            print("error :",error.localizedDescription)
        }
        
    }
    
    func alertSuccess(){
        let alert = UIAlertController(title: "Inserted", message: "Success", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
}

