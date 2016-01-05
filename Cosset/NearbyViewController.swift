//
//  NearbyViewController.swift
//  Cosset
//
//  Created by Lauren Nicole Roth on 1/4/16.
//  Copyright © 2016 Cosset. All rights reserved.
//

import UIKit
import Firebase

class NearbyViewController: UITableViewController {
    
    //MARK: Constants
    let listAppointments = "ListAppointments"
    let rootRef = Firebase(url: "https://cosset.firebaseio.com/laurennicoleroth")
    let date = NSDate()
    let formatter = NSDateFormatter()

    //MARK: Properties
    var appointmentViewController: AppointmentViewController? = nil
    var appointments = [Appointment]()
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup swipe to delete
        tableView.allowsMultipleSelectionDuringEditing = false
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.appointmentViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? AppointmentViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        
        print("plus button pressed")
        print(rootRef)
        
        var alert = UIAlertController(title: "Appointment", message: "Add an appointment", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) {
            (action: UIAlertAction!) -> Void in
            
            let textField = alert.textFields![0] 
            let appointment = Appointment(startTime: "1pm", endTime: "2pm", type: textField.text!, booked: true, bookedByUser: "laurennicoleroth")
            self.appointments.append(appointment)
            
            
            let appointmentRef = self.rootRef.childByAppendingPath(textField.text!)
            
            appointmentRef.setValue(appointment.toAnyObject())
            
            
            print(self.appointments)
            print(self.appointments.count)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action: UIAlertAction!) -> Void in
            print("cancel pressed")
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let appointment = appointments[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! AppointmentViewController
                controller.detailItem = appointment
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
        print(appointments.count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let appointment = appointments[indexPath.row] 
        cell.textLabel!.text = appointment.key
        return cell
    }


    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            appointments.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}