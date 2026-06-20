//
//  AddExpenseViewController.swift
//  sqlitepractise1_18March
//

import UIKit
import SQLite3

class AddExpenseViewController: UIViewController {

    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var txtcategory: UITextField!
    @IBOutlet weak var txtamount: UITextField!
    @IBOutlet weak var txttitle: UITextField!

    var categoryList = [Category]()
    var selectedCategoryId: Int?
    var db: OpaquePointer?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

        txtcategory.addTarget(self, action: #selector(selectCategory), for: .editingDidBegin)
    }

    func loadCategories() {
        categoryList.removeAll()
        let query = "SELECT * FROM Category"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id  = sqlite3_column_int(stmt, 0)
                let name = String(cString: sqlite3_column_text(stmt, 1))
                let imageName = String(cString: sqlite3_column_text(stmt, 2))
                categoryList.append(Category(id: Int(id), name: name, imageName: imageName))
            }
        }
        sqlite3_finalize(stmt)
    }

    func insertCategory(name: String) -> Int {
        let query = "INSERT INTO Category (name,imageName) VALUES (?,?)"
        var stmt: OpaquePointer?
        var newId = 0

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, name, -1, nil)
            sqlite3_bind_text(stmt, 2, "default", -1, nil)

            if sqlite3_step(stmt) == SQLITE_DONE {
                newId = Int(sqlite3_last_insert_rowid(db))
            }
        }
        sqlite3_finalize(stmt)
        return newId
    }

    @IBAction func btnadd(_ sender: UIButton) {
        guard let title = txttitle.text,
              let amountText = txtamount.text,
              let amount = Double(amountText),
              let categoryName = txtcategory.text, !categoryName.isEmpty else {
            showAlert(msg: "Fill all fields")
            return
        }

        var catId = selectedCategoryId
        if catId == nil {
            catId = insertCategory(name: categoryName)
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = formatter.string(from: datepicker.date)

        let query = "INSERT INTO Expense (title, amount, date, categoryId) VALUES (?,?,?,?)"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, title, -1, nil)
            sqlite3_bind_double(stmt, 2, amount)
            sqlite3_bind_text(stmt, 3, date, -1, nil)
            sqlite3_bind_int(stmt, 4, Int32(catId!))

            if sqlite3_step(stmt) == SQLITE_DONE {
                showAlert(msg: "Expense Added") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        sqlite3_finalize(stmt)
    }

    @objc func selectCategory() {
        let alert = UIAlertController(title: "Select Category", message: nil, preferredStyle: .actionSheet)
        for cat in categoryList {
            alert.addAction(UIAlertAction(title: cat.name, style: .default, handler: { _ in
                self.txtcategory.text = cat.name
                self.selectedCategoryId = cat.id
            }))
        }
        present(alert, animated: true)
    }

    func showAlert(msg: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Info", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
}
