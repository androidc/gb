//
//  TableViewController1.swift
//  part2lesson1
//
//  Created by Артем Солохин on 30.11.2022.
//

import UIKit

class TableViewController1: UITableViewController {

 //
    
    let friendsTestData:[FriendModel]  = [
        FriendModel(image: UIImage.init(systemName: "figure.walk"), name: "Уася"),
        FriendModel(image: UIImage.init(systemName: "person.2"), name: "Петя"),
        FriendModel(image: UIImage.init(systemName: "person.wave.2"), name: "Костя"),
        FriendModel(image: UIImage.init(systemName: "person.fill"), name: "Натаха"),
        FriendModel(image: UIImage.init(systemName: "person.fill.turn.left"), name: "Вика"),
        FriendModel(image: UIImage.init(systemName: "figure.stand"), name: "Рита")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow

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
        return friendsTestData.count
    }

//
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCellId", for: indexPath) as? FriendCell else {
            preconditionFailure("Friend cell not defined")
        }
        
        cell.imageFriend?.image =  friendsTestData[indexPath.row].image
        cell.friendName.text = friendsTestData[indexPath.row].name
        
        
       

        // Configure the cell...

        return cell
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
