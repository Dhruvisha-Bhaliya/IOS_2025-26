//
//  TableViewController.swift
//  coredata_28March
//
//  Created by ICT2Batch1 on 28/03/26.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    var emplist:[Employee]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emplist.count
      

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines=0
        let c = emplist[indexPath.row]
        cell.textLabel?.text="\(c.name!)\n\(c.email!)\n\(c.password!)"

        return cell
    }
    
    func LoadData(){
        let appDel = UIApplication.shared.delegate as!AppDelegate
        let ctx = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        do{
            try emplist = ctx.fetch(request)
            tableView.reloadData()
            print("Total records:", emplist.count)
        }catch{
            print("error")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(emplist[indexPath.row])
            try?context.save()
            emplist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = emplist[indexPath.row]
        let alert = UIAlertController(title: "Update Employee", message: nil, preferredStyle: .alert)
        
        alert.addTextField{$0.text = item.name}
        alert.addTextField{$0.text = item.email}
        alert.addTextField{$0.text = item.password}
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Update", style: .default,handler:{_ in
            let ctx = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
            item.name = alert.textFields?[0].text
            item.email = alert.textFields?[1].text
            item.password = alert.textFields?[2].text
            try?  ctx.save()
            tableView.reloadData()
        }))
        present(alert, animated: true)
    }

}
