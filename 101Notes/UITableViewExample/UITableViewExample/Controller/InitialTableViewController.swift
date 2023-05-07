//
//  InitialTableViewController.swift
//  UITableViewExample
//
//  Created by Gorkem Saka on 5/5/23.
//

import UIKit

class InitialTableViewController: UITableViewController {
    
    var tableViewData = [
        ["General", "Accesiblity", "Privacy"],
        ["Passwords"],
        ["Safari", "News"],
        ["Developer"]
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    
    // MARK: - Table view data source
    
    // Kac adet section olacak.
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableViewData.count // count, arrayin icinde kac eleman oldugunu temsil eder.
    }
    
    // Olusan gruplarin her birinde kac eleman gozukecek?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[section].count
    }

    
    // Cell'deki elemanlar ne olacak?
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableViewData[indexPath.section][indexPath.row]

        // Configure the cell...

        return cell
    }
    
    
    //ALERT DIALOG OLUSTURMAK ICIN KULLANILAN FONKSIYON
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Bir alertController olusturduk ve boylece hata penceremizde nelerin yazilacagina karar verdik.
        let alertController = UIAlertController(title: "Uyari",
                                                message: tableViewData[indexPath.section][indexPath.row],
                                                preferredStyle: UIAlertController.Style.alert)
        
        
        // Olusturdugumuz controlleri, ekranda gostermek icin kullanilan metoda "preseent" denir. Gosterilecek controlleri tanimladik ve controller olsurken animasyonlu acilip acilmamasini tanimladik
        present(alertController, animated: true)
        
        
        // Alert Dialogu olusturduktan sonra bir cikis tusu yapmak icin, bir addAction olusturduk.
        alertController.addAction(UIAlertAction(title:"Geri Don",
                                                style: UIAlertAction.Style.cancel,
                                                // handler ile bu buttonun ne yapicagini (yani bu ornekte cikis "dismiss"), belirleriz
                                                handler: { _ in
            alertController.dismiss(animated: false)
            2
        }))
        
        // Silme islemi yapabilmek icin bir addAction olusturuldu.
        alertController.addAction(UIAlertAction(title: "Sil", style: UIAlertAction.Style.default, handler: { _ in
            
            self.tableViewData[indexPath.section].remove(at: indexPath.row)
            tableView.reloadData()
            
        }))
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

}
