//
//  FirstTableViewController.swift
//  coredata_practise_27March
//
//  Created by ict2batch1 on 27/03/26.
//

import UIKit
import CoreData

class FirstTableViewController: UITableViewController {

    var categories:[Shop_Table]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

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
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.numberOfLines = 0
        let c = categories[indexPath.row]
        cell.textLabel?.text = "\(c.foodID!)\n\(c.foodName!)\n\(c.price)\n\(c.fooddescription!)\n\(c.category!)\n\(c.date!)"
        return cell
    }
    
    func loadData() {
        let appDel = UIApplication.shared.delegate as!AppDelegate
        let ctx = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<Shop_Table>(entityName:"Shop_Table")
        do {
            try categories = ctx.fetch(request)
            tableView.reloadData()
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
            context.delete(categories[indexPath.row])
            try?context.save()
            categories.remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = categories[indexPath.row]
        let alert = UIAlertController(title: "Update Food", message: nil, preferredStyle: .alert)
           
           alert.addTextField { $0.text = item.foodName }
           alert.addTextField { $0.text = item.fooddescription }
           alert.addTextField { $0.text = "\(item.price)" }
           alert.addTextField { $0.text = item.category }
           alert.addTextField { $0.text = item.date != nil ? "\(item.date!)" : "" }
           
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
           alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { _ in
               let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
               item.foodName = alert.textFields?[0].text
               item.fooddescription = alert.textFields?[1].text
               item.price = Float(alert.textFields?[2].text ?? "0") ?? 0
               item.category = alert.textFields?[3].text
               item.date = alert.textFields?[4].text
               try? ctx.save()
               tableView.reloadData()
           }))
           
           present(alert, animated: true)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }z`
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

}
