//
//  AddItemViewController.swift
//  To Do App v1
//
//  Created by Erik Fotta on 1/16/20.
//  Copyright © 2020 Erik Fotta. All rights reserved.
//

import UIKit
import Foundation

class AddItemViewController: UIViewController {
    
    // Declare variables
    var defaults = UserDefaults.standard
    var indexData: [Int] = []
    var titlesData: [String] = []
    var locationsData: [String] = []
    var notesData: [String] = []
    var deadlinesData: [String] = []
    var pointsData: [String] = []

    // Declare outlet variables
    @IBOutlet weak var titleTextEntry: UITextField!
    @IBOutlet weak var locationTextEntry: UITextField!
    @IBOutlet weak var notesTextEntry: UITextField!
    @IBOutlet weak var datePickerEntry: UIDatePicker!
    @IBOutlet weak var difficultyPickerEntry: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set mode of the date picker
        datePickerEntry.datePickerMode = UIDatePicker.Mode.dateAndTime
        
        // Call UserDefaults
        if let jobIndexData = defaults.array(forKey: "totalJobIndex") as? [Int] {
            indexData = jobIndexData
            }
        if let itemTitlesData = defaults.array(forKey: "itemTitles") as? [String] {
            titlesData = itemTitlesData
            }
        if let itemLocationsData = defaults.array(forKey: "itemLocations") as? [String] {
            locationsData = itemLocationsData
            }
        if let itemNotesData = defaults.array(forKey: "itemNotes") as? [String] {
            notesData = itemNotesData
            }
        if let itemDeadlinesData = defaults.array(forKey: "itemDeadlines") as? [String] {
        deadlinesData = itemDeadlinesData
            }
        if let itemPointsData = defaults.array(forKey: "itemPoints") as? [String] {
        pointsData = itemPointsData
            }
    }
    
    // Creates each agenda item
    func createItem(_ jobIndex: [Int]) {
        if jobIndex == [] {
            self.indexData.append(1)
        } else {
            self.indexData.append(indexData.last! + 1)
        }
        defaults.set(indexData, forKey: "totalJobIndex")
        
        // Append inputs to the saved arrays
        self.titlesData.append(titleTextEntry.text!)
        self.locationsData.append(locationTextEntry.text!)
        self.notesData.append(notesTextEntry.text!)
        
        // Get set date & append
        let deadline: Date = datePickerEntry.date
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: deadline)
        let year = calendar.component(.year, from: deadline)
        let month = calendar.component(.month, from: deadline)
        let day = calendar.component(.day, from: deadline)
        let hour = calendar.component(.hour, from: deadline)
        let minute = calendar.component(.minute, from: deadline)
        let realDay = weekDayMaker(dayOfWeek)
        let presentedDeadline = "\(realDay) \(month)/\(day)/\(year) at \(hour):\(minute)"
        self.deadlinesData.append(presentedDeadline)
        
        // Get difficulty setting & append
        let difficultyIndex = difficultyPickerEntry.selectedSegmentIndex
        let difficuty = difIndexPointMatch(difficultyIndex)
        self.pointsData.append(difficuty)
        
        // reset UserDefaults values
        defaults.set(titlesData, forKey: "itemTitles")
        defaults.set(locationsData, forKey: "itemLocations")
        defaults.set(notesData, forKey: "itemNotes")
        defaults.set(deadlinesData, forKey: "itemDeadlines")
        defaults.set(pointsData, forKey: "itemPoints")
    }
    
    // Convert and clean up date formatting for days of the week
    func weekDayMaker(_ weekDay: Int) -> String {
        if weekDay == 1 {
            return "Sunday"
        } else if weekDay == 2 {
            return "Monday"
        } else if weekDay == 3 {
            return "Tuesday"
        } else if weekDay == 4 {
            return "Wednesday"
        } else if weekDay == 5 {
            return "Thursday"
        } else if weekDay == 6 {
            return "Friday"
        } else {
            return "Saturday"
        }
    }
    
    // Create point values for the difficulty setting
    func difIndexPointMatch(_ index: Int) -> String {
        if index == 0 {
            return "10"
        } else if index == 1 {
            return "25"
        } else if index == 2 {
            return "45"
        } else if index == 3 {
            return "70"
        } else {
            return "100"
        }
    }
    
    // Complete a new item
    // Calls 'reload()' to refresh the table view to include the new item
    @IBAction func finishNewItem(_ sender: Any) {
        createItem(indexData)
        if let destinationViewController = self.presentingViewController as? UITabBarController,
            let tbvc = destinationViewController.selectedViewController as? MainToDoTableViewController {
            tbvc.reload()
        }
        dismiss(animated: true)
    }
    
    // Cancels new item in creation menu
    @IBAction func cancelNewItem(_ sender: Any) {
        dismiss(animated: true)
    }
}
