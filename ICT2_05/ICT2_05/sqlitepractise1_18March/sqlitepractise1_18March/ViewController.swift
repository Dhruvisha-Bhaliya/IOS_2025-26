//
//  ViewController.swift
//  sqlitepractise1_18March
//
//  Created by ict2batch1 on 18/03/26.
//

import SQLite3
import UIKit

struct Category {
    var id: Int
    var name: String
    var imageName: String
}

struct Expense {
    var id: Int
    var title: String
    var amount: Double
    var date: String
    var categoryId: Int
    var categoryName: String
    var categoryImageName: String
}

class ViewController: UIViewController, UITableViewDelegate,
    UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return expenseList.count
        // return categoryList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tblview.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath)
        let e = expenseList[indexPath.row]
        cell.textLabel?.text = "\(e.title) - \(e.amount) (\(e.categoryName))"
        cell.imageView?.image = UIImage(named: e.categoryImageName)
        return cell
    }

    @IBOutlet weak var lbltotalexpense: UILabel!
    @IBOutlet weak var tblview: UITableView!

    let dbPath: String = "Expensedb.sqlite"
    var db: OpaquePointer?
    var expenseList = [Expense]()
    var categoryList = [Category]()

    func opendb() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask, appropriateFor: nil,
            create: false
        ).appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("unable open db")
            return nil
        } else {
            print("Db Opened at\(fileURL.path)")
            return db
        }
    }

    func createTables() {
        let categoryQuery = """
            CREATE TABLE IF NOT EXISTS Category(
            Id INTEGER PRIMARY KEY,
            name TEXT,
            imageName TEXT
            );
            """

        let expenseQuery = """
            CREATE TABLE IF NOT EXISTS Expense(
            ID INTEGER PRIMARY KEY,
            title TEXT,
            amount DOUBLE,
            date TEXT,
            categoryId INTEGER,
            FOREIGN KEY(categoryId) REFERENCES Category(Id)
            );
            """
        
        sqlite3_exec(db, categoryQuery, nil, nil, nil)
        sqlite3_exec(db, expenseQuery, nil, nil, nil)
    }
    
    func loadExpenses() {
        expenseList.removeAll()
        let query = """
        SELECT Expense.Id, Expense.title, Expense.amount, Expense.date,
        Expense.categoryId, Category.name, Category.imageName
        FROM Expense
        INNER JOIN Category ON Expense.categoryId = Category.Id
        """
        var stmt: OpaquePointer? = nil
        var total: Double = 0
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id  = sqlite3_column_int(stmt, 0)
                let title = String(cString: sqlite3_column_text(stmt, 1))
                let amount = sqlite3_column_double(stmt, 2)
                let date = String(cString: sqlite3_column_text(stmt, 3))
                let catid = sqlite3_column_int(stmt, 4)
                let catName = String(cString: sqlite3_column_text(stmt, 5))
                let catimage = String(cString: sqlite3_column_text(stmt, 6))
                total += amount
                expenseList.append(Expense(id: Int(id),title: title,amount: amount,date: date,categoryId: Int(catid),categoryName: catName,categoryImageName: catimage))
            }
        }
        sqlite3_finalize(stmt)
        lbltotalexpense.text = "Total: \(total)"
        tblview.reloadData()
    }

    func insertDefaultCategory() {
           let query = "INSERT OR IGNORE INTO Category (Id,name,imageName) VALUES (1,'Food','default'),(2,'Travel','default')"
           sqlite3_exec(db, query, nil, nil, nil)
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           db = opendb()
           createTables()
           insertDefaultCategory()
       }

       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           loadExpenses()
       }

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "addExpense" {
               let vc = segue.destination as! AddExpenseViewController
               vc.db = db
           }
       }
}
