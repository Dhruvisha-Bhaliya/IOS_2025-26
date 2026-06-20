//
//  ViewController.swift
//  Sqlite_Navigation_9March
//
//  Created by ict2batch1 on 09/03/26.
//

import UIKit
import SQLite3

struct Vehicle {
    var id : Int
    var typename : String
    var Brand : String
    var Date : Date
}

class ViewController: UIViewController {

    @IBOutlet weak var txtid: UITextField!
    @IBOutlet weak var txttypename: UITextField!
    @IBOutlet weak var txtbrand: UITextField!
    @IBOutlet weak var txtdate: UITextField!
    
    @IBOutlet weak var btnsub: UIButton!
    let dbPath:String = "vehicledb.sqlite";
    var db:OpaquePointer?
    var vehicleList = [Vehicle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = opendb()
        // Do any additional setup after loading the view.
    }
    
    func opendb()-> OpaquePointer?{
        let fileURL = try!FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        var db:OpaquePointer?=nil
        if sqlite3_open(fileURL.path,&db) != SQLITE_OK{
            print("Unable to open DB")
            return nil
        }else{
            print("Db opened at\(fileURL.path)")
            return db
        }
    }


    @IBAction func btnsubmit(_ sender: UIButton) {
    }
}

