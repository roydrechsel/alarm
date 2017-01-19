//
//  AlarmDetailsTableViewController.swift
//  13Alarm
//
//  Created by Andrew Drechsel on 1/14/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import UIKit

class AlarmDetailsTableViewController: UITableViewController, AlarmScheduler {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var enableOrDisableButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let title = messageText.text,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSince(thisMorningAtMidnight)
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            cancelLocalNotification(for: alarm)
            scheduleLocalNotification(for: alarm)
            
        } else {
            let alarm = AlarmController.shared.addAlarm(fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
            scheduleLocalNotification(for: alarm)
        }
        
        let _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else { return }
        AlarmController.shared.toggleEnabled(for: alarm)
        if alarm.enabled {
            scheduleLocalNotification(for: alarm)
        } else {
            cancelLocalNotification(for: alarm)
        }
        updateViews()
    }

    // MARK: - Table view data source
    
    private func updateViews() {
        
        guard let alarm = alarm,
        let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight,
            isViewLoaded else {
                enableOrDisableButton.isHidden = true
                return
        }
        
        datePicker.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: thisMorningAtMidnight), animated: false)
        messageText.text = alarm.name
        
        enableOrDisableButton.isHidden = false
        if alarm.enabled {
            enableOrDisableButton.setTitle("Disable", for: UIControlState())
            enableOrDisableButton.setTitleColor(.white, for: UIControlState())
            enableOrDisableButton.backgroundColor = .red
        } else {
            enableOrDisableButton.setTitle("Enable", for: UIControlState())
            enableOrDisableButton.setTitleColor(.blue, for: UIControlState())
            enableOrDisableButton.backgroundColor = .gray
        }
        
        self.title = alarm.name
    }
    
    var alarm: Alarm? {
        
        didSet {
            
            updateViews()
        }
    }

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
