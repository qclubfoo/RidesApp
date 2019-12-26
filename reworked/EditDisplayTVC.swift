//
//  EditDisplay.swift
//  reworked
//
//  Created by Дмитрий on 24.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

import UIKit

class EditDisplayTVC: UITableViewController {
    
    weak var currentDay: DayClass?
    weak var mainTVC: MainTVC?
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var metroOutlet: UILabel!
    @IBOutlet weak var tatOutlet: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var metroTFOutlet: UITextField!
    @IBOutlet weak var tatTFOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decreaseButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        increaseButton.layer.cornerRadius = 10
        metroTFOutlet.becomeFirstResponder()
        guard let guardedCurrentDay = currentDay else { return }
        dateOutlet.text = guardedCurrentDay.date
        metroOutlet.text = String(guardedCurrentDay.metroRide)
        tatOutlet.text = String(guardedCurrentDay.tatRide)
    }
    @IBAction func decreaseAction(_ sender: Any) {
        guard let guardedMainTVC = mainTVC else { return }
        let metro = Int(metroTFOutlet.text ?? "0") ?? 0
        let tat = Int(tatTFOutlet.text ?? "0") ?? 0
        if currentDay!.metroRide - metro >= 0 {
            currentDay?.metroRide -= metro
        }
        if currentDay!.tatRide - tat >= 0 {
            currentDay!.tatRide -= tat
        }
        dismiss(animated: true, completion: nil)
        guardedMainTVC.tableView.reloadData()
    }
    @IBAction func increaseAction(_ sender: Any) {
        guard let guardedMainTVC = mainTVC else { return }
        let metro = Int(metroTFOutlet.text ?? "0") ?? 0
        let tat = Int(tatTFOutlet.text ?? "0") ?? 0
        currentDay?.metroRide += metro
        currentDay?.tatRide += tat
        dismiss(animated: true, completion: nil)
        guardedMainTVC.tableView.reloadData()
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    static func storyboardInstance() -> EditDisplayTVC? {
        let storyboard = UIStoryboard(name: "EditDisplayTVC", bundle: nil)
        return storyboard.instantiateInitialViewController() as? EditDisplayTVC
    }
}
