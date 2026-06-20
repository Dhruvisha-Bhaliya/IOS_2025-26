//
//  TableViewController.swift
//  LibraryCoreData_30March
//
//  Created by apple on 30/03/26.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    var genrelist:[Book_Table]=[]
    
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
        return genrelist.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        let c = genrelist[indexPath.row]
        cell.textLabel?.text = "\(c.bookid!)\n\(c.booktitle!)\n\(c.author!)\n\(c.bookdescription!)\n\(c.genre!)\n\(c.publishdate!)"
        
        return cell
    }
    
    
        func LoadData() {
            let appDel = UIApplication.shared.delegate as!AppDelegate
            let ctx = appDel.persistentContainer.viewContext
    
            let request = NSFetchRequest<Book_Table>(entityName: "Book_Table")
            do{
                try genrelist = ctx.fetch(request)
                tableView.reloadData()
                //            print("Loading data…")
                //            print("Count:", genrelist.count)
            }catch{
                print("Error: ",error.localizedDescription)
            }
        }
    
    /*
    func LoadData(){
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let ctx = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<Book_Table>(entityName: "Book_Table")
//        do{
//            let totalBooks = try ctx.count(for: request)
//            print("Total Books in database: ",totalBooks)
//            genrelist = try ctx.fetch(request)
//            tableView.reloadData()
//        }catch{
//            print("Error: ",error.localizedDescription)
//        }
        do {
            request.predicate = NSPredicate(format: "genre == %@", "Engineering")
            let scienceBooksCount = try ctx.count(for: request)
            print("Number of Science books:", scienceBooksCount)
        } catch {
            print(error.localizedDescription)
        }
    }
     */
    
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
            
//            showConfirmationAlert(title: "Delete Book", message: "Are you sure you want to delete this book?", confirmActionTitle: "Delete"){
                // Delete the row from the data source
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                context.delete(self.genrelist[indexPath.row])
                try?context.save()
                self.genrelist.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            //}
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
        let item = genrelist[indexPath.row]
        let alert = UIAlertController(title: "Update Book", message: nil, preferredStyle: .alert)
        alert.addTextField{$0.text = item.booktitle}
        alert.addTextField{$0.text = item.author}
        alert.addTextField{$0.text = item.bookdescription}
        alert.addTextField{$0.text = item.genre}
        alert.addTextField{$0.text = item.publishdate != nil ? "\(item.publishdate!)" : ""}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: {_ in
            let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            item.booktitle = alert.textFields?[0].text
            item.author = alert.textFields?[1].text
            item.bookdescription = alert.textFields?[2].text
            item.genre = alert.textFields?[3].text
            item.publishdate = alert.textFields?[4].text
            try?ctx.save()
            tableView.reloadData()
        }))
        present(alert,animated: true)
    }

    
//    func showConfirmationAlert(title:String,message:String,confirmActionTitle:String,confirmHandler:@escaping () -> Void){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        alert.addAction(UIAlertAction(title:confirmActionTitle,style:.destructive,handler:{
//            _ in confirmHandler()
//        }))
//        
//        present(alert,animated: true)
//    }

}
