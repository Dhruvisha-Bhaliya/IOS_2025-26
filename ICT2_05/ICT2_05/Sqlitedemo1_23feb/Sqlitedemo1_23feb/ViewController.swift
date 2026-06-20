//
//  ViewController.swift
//  Sqlitedemo1_23feb
//
//  Created by ict2batch1 on 23/02/26.
//

import UIKit
import SQLite3

struct Student {
    var id:Int
    var name:String
    var age:Int
    
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var txtid: UITextField!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtage: UITextField!
    @IBOutlet weak var tblview: UITableView!
    
    @IBOutlet weak var btn: UIButton!
    let dbPath:String = "mydb.sqlite";
    var db:OpaquePointer?
    var studentList = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = opendb()
        createTable()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData () {
        studentList = read()
        tblview.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let student = studentList[indexPath.row]
        
        cell.textLabel?.text = "ID: \(student.id) | Name: \(student.name) | Age: \(student.age)"
        return cell
    }
    
    
    @IBAction func btnadd(_ sender: UIButton) {
        if(sender.titleLabel?.text=="Insert"){
            insert(id: Int(txtid.text!) ?? 0, name: txtname.text!, age: Int(txtage.text!) ?? 0)
            let student = Student(id: Int(txtid.text!) ?? 0, name: txtname.text!, age:
            Int(txtage.text!) ?? 0)
            studentList.append(student)
            txtid.text = ""
            txtname.text = ""
            txtage.text = ""
            
            tblview.reloadData()
            } else {
                update()
                tblview.reloadData()
            }
    }
    
    func opendb() -> OpaquePointer? {
        let fileURL = try!FileManager.default.url(for:.documentDirectory,in:.userDomainMask,appropriateFor:nil,create:false).appendingPathComponent(dbPath)
        var db:OpaquePointer? = nil

        if sqlite3_open(fileURL.path,&db) != SQLITE_OK {
            print("Unable open db")
            return nil
        }else {
            print("Db opned at\(fileURL.path)")
            return db
        }
    }
    
    func createTable() {
        let query = """
                    CREATE TABLE IF NOT EXISTS Student(Id
                    INTEGER PRIMARY KEY,
                    name TEXT,
                    age INTEGER);
                    """
        var statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db,query,-1,&statement,nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("TABLE Created")
            }else{
                print("TABLE NOT Created")
            }
        }
        sqlite3_finalize(statement)
//        sqlite3_exec(db, query, nil, nil, nil)
    }
    
    func insert(id: Int,name: String,age: Int) {
        let insertStatementString = "INSERT INTO Student (Id,name,age) VALUES (?,?,?)"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
        sqlite3_bind_int(insertStatement, 1, Int32(id))
        sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 3, Int32(age))
        if sqlite3_step(insertStatement) == SQLITE_DONE {
        print("Successfully inserted row.")
        } else {
            print("Insert failed: \(String(cString: sqlite3_errmsg(db)))") }        } else {
        print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

          let selectedData = studentList[indexPath.row]

          txtid.text = "\(selectedData.id)"
          txtname.text = selectedData.name
          txtage.text = "\(selectedData.age)"

//        btn.setTitle("Update", for: .normal)
      }
    

    @IBAction func btnupdate(_ sender: UIButton) {
            update()
            tblview.reloadData()
    }
    func update() {

           guard let idText = txtid.text,
                 let name = txtname.text,
                 let ageText = txtage.text,
                 !idText.isEmpty,
                 !name.isEmpty,
                 !ageText.isEmpty else {

               print("All fields required")
               return
           }

           let updateStatementString = """
           UPDATE Student SET name = "\(name)", age = \(ageText) WHERE Id = \(idText);
           """

           if sqlite3_exec(db, updateStatementString, nil, nil, nil) == SQLITE_OK {

               print("Student updated")

               let newArray = studentList.map { p in

                   if p.id == Int(idText) {

                       return Student(id: Int(idText)!,
                                      name: name,
                                      age: Int(ageText)!)

                   } else {

                       return p
                   }
               }

               studentList = newArray
               tblview.reloadData()

           } else {

               print("Update failed")
           }
       }

    func deleteByID(id: Int) {

        let deleteStatementString = "DELETE FROM Student WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {

            sqlite3_bind_int(deleteStatement, 1, Int32(id))

            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }

        } else {
            print("DELETE statement could not be prepared.")
        }

        sqlite3_finalize(deleteStatement)
    }
    
    func read() -> [Student] {

        let queryStatementString = "SELECT * FROM Student;"
        var queryStatement: OpaquePointer? = nil
        var students: [Student] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {

            while sqlite3_step(queryStatement) == SQLITE_ROW {

                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let age = sqlite3_column_int(queryStatement, 2)

                students.append(Student(id: Int(id), name: name, age: Int(age)))
            }

        } else {
            print("SELECT statement could not be prepared")
        }

        sqlite3_finalize(queryStatement)

        return students
    }

    @IBAction func btnclear(_ sender: Any) {
        txtid.text = ""
           txtname.text = ""
           txtage.text = ""
    }
    
    @IBAction func btndelete(_ sender: UIButton) {
        deleteByID(id: Int(txtid.text!) ?? 0)
        loadData()
    }
}

