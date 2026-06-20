//
//  ViewController.swift
//  Practise_9Feb_Controllers
//
//  Created by ict2batch1 on 09/02/26.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    @IBOutlet weak var rb1: UIButton!
    @IBOutlet weak var rb2: UIButton!
    let countries = ["India","USA","UK","Canada","AUS"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        pickerView.delegate = self
//        pickerView.dataSource = self
        
        genderSegment.setTitle("Male", forSegmentAt: 0)
        genderSegment.setTitle("Female", forSegmentAt: 1)
        
        rb1.setImage(UIImage(systemName: "circle"), for: .normal)
        rb1.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        rb2.setImage(UIImage(systemName: "circle"), for: .normal)
        rb2.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        
        resultLabel.numberOfLines = 0
        
        // Do any additional setup after loading the view.
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
        
        let gender = genderSegment.selectedSegmentIndex == 0 ? "Male" : "Female"
        
        let selectedIndex = pickerView.selectedRow(inComponent: 0)
        
        let country = countries[selectedIndex]
        
        let status = statusSwitch.isOn ? "Active" : "Inactive"
        
        
        
        resultLabel.text = """
                        Name : \(name)
                        Gender : \(gender)
                        Country : \(country)
                        Status : \(status)
                        Gender2 : \(rbbutton!)
                        """
    }
    
    var rbbutton: String?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return countries.count
       }

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return countries[row]
       }
    
    @IBAction func maleActionTapped(_ sender: UIButton) {
        sender.isSelected = true;
        sender.setImage(UIImage(systemName:"circle.fill"), for: .selected)
        rb2.isSelected = false
        rbbutton = "male"
        
    }
    
    
    @IBAction func femaleActionTapped(_ sender: UIButton) {
        sender.isSelected = true;
        sender.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        rb1.isSelected = false
        rbbutton = "female"
    }
}

