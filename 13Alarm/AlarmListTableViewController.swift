//
//  AlarmListTableViewController.swift
//  13Alarm
//
//  Created by Andrew Drechsel on 1/14/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate, AlarmScheduler {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AlarmController.shared.alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell
        
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell?.alarm = alarm
        

        return cell ?? UITableViewCell()
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            cancelLocalNotification(for: alarm)            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleEnabled(for: alarm)
        
        if alarm.enabled {
            
            scheduleLocalNotification(for: alarm)
        } else {
            cancelLocalNotification(for: alarm)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toAlarmDetail" {
            guard let alarmDetail = segue.destination as? AlarmDetailsTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            alarmDetail.alarm = AlarmController.shared.alarms[indexPath.row]
            
        }
        
        // Pass the selected object to the new view controller.
        
    }
    

}
