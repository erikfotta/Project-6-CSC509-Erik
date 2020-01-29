//
//  MainToDoTableViewController.swift
//  To Do App v1
//
//  Created by Erik Fotta on 1/16/20.
//  Copyright © 2020 Erik Fotta. All rights reserved.
//

import UIKit
import Foundation

class MainToDoTableViewController: UITableViewController {

    // Variable Declaration
    var defaults = UserDefaults.standard
    var totalJobIndex: [Int] = []
    var itemTitles: [String] = []
    var itemLocations: [String] = []
    var itemNotes: [String] = []
    var itemDeadlines: [String] = []
    var itemPoints: [String] = []
    var totalPoints: Int = 0
    var toDoTutorialSeen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UserDefaults
        if let jobIndexData = defaults.array(forKey: "totalJobIndex") as? [Int] {
            totalJobIndex = jobIndexData
            }
        if let itemTitlesData = defaults.array(forKey: "itemTitles") as? [String] {
            itemTitles = itemTitlesData
            }
        if let itemLocationsData = defaults.array(forKey: "itemLocations") as? [String] {
            itemLocations = itemLocationsData
            }
        if let itemNotesData = defaults.array(forKey: "itemNotes") as? [String] {
            itemNotes = itemNotesData
            }
        if let itemDeadlinesData = defaults.array(forKey: "itemDeadlines") as? [String] {
            itemDeadlines = itemDeadlinesData
            }
        if let itemPointsData = defaults.array(forKey: "itemPoints") as? [String] {
            itemPoints = itemPointsData
            }
        if let points = defaults.integer(forKey: "totalPoints") as Int? {
            totalPoints = points
            }
        if let toDoTutorialSeenData = defaults.bool(forKey: "toDoTutorialSeen") as Bool? {
            toDoTutorialSeen = toDoTutorialSeenData
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tutorialAlert = UIAlertController(title: "Welcome!", message: "This To Do app is designed with gamified aspects to impove personal habits. You will earn points based on the difficulty of each task you complete. These points are used to return you a rank, based on your dedication.", preferredStyle: UIAlertController.Style.alert)
        tutorialAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in tutorialAlert.dismiss(animated: true, completion: nil)}))
        if toDoTutorialSeen == false {
            self.toDoTutorialSeen = true
            self.defaults.set(self.toDoTutorialSeen, forKey: "toDoTutorialSeen")
            self.present(tutorialAlert, animated: true, completion: nil)
        } else {}
    }
    // Used to re-call UserDefaults
    // Reload() is called in AddItemViewController
     func reload() {
        if let jobIndexData = defaults.array(forKey: "totalJobIndex") as? [Int] {
            totalJobIndex = jobIndexData
            }
        if let itemTitlesData = defaults.array(forKey: "itemTitles") as? [String] {
            itemTitles = itemTitlesData
            }
        if let itemLocationsData = defaults.array(forKey: "itemLocations") as? [String] {
            itemLocations = itemLocationsData
            }
        if let itemNotesData = defaults.array(forKey: "itemNotes") as? [String] {
            itemNotes = itemNotesData
            }
        if let itemDeadlinesData = defaults.array(forKey: "itemDeadlines") as? [String] {
            itemDeadlines = itemDeadlinesData
            }
        if let itemPointsData = defaults.array(forKey: "itemPoints") as? [String] {
            itemPoints = itemPointsData
            }
        if let points = defaults.integer(forKey: "totalPoints") as Int? {
            totalPoints = points
            }
        if let toDoTutorialSeenData = defaults.bool(forKey: "toDoTutorialSeen") as Bool? {
            toDoTutorialSeen = toDoTutorialSeenData
            }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    // Only returns one section because no use for more
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of cells equals number of active tasks
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if totalJobIndex.count != 0 {
            return totalJobIndex.count
        } else {
            return 0
        }
    }

    // Create new cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testIdentifier", for: indexPath)
        if let taskCell = cell as? MainToDoTableViewCell {
            taskCell.titleLabel.text = itemTitles[indexPath.row]
            taskCell.locationLabel.text = itemLocations[indexPath.row]
            taskCell.notesLabel.text = itemNotes[indexPath.row]
            taskCell.deadlinesLabel.text = itemDeadlines[indexPath.row]
            taskCell.pointsLabel.text = itemPoints[indexPath.row]
            return taskCell
        }
        return cell
    }
    
    // Delete menu on left swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Remove Item?", message: "", preferredStyle: UIAlertController.Style.alert)
                // Cancels the alert with no other action
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
                // Removes the cell and all its properties, adds points for completion
                alert.addAction(UIAlertAction(title: "Complete", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
                    self.totalPoints += Int(self.itemPoints[indexPath.row])!
                    self.totalJobIndex.remove(at: indexPath.row)
                    self.itemTitles.remove(at: indexPath.row)
                    self.itemLocations.remove(at: indexPath.row)
                    self.itemNotes.remove(at: indexPath.row)
                    self.itemDeadlines.remove(at: indexPath.row)
                    self.itemPoints.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.defaults.set(self.totalJobIndex, forKey: "totalJobIndex")
                    self.defaults.set(self.itemTitles, forKey: "itemTitles")
                    self.defaults.set(self.itemLocations, forKey: "itemLocations")
                    self.defaults.set(self.itemNotes, forKey: "itemNotes")
                    self.defaults.set(self.itemDeadlines, forKey: "itemDeadlines")
                    self.defaults.set(self.itemPoints, forKey: "itemPoints")
                    self.defaults.set(self.totalPoints, forKey: "totalPoints")
                    tableView.reloadData()
                }))
                // Removes the cell and all its properties, does not add points
                alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
                    self.totalJobIndex.remove(at: indexPath.row)
                    self.itemTitles.remove(at: indexPath.row)
                    self.itemLocations.remove(at: indexPath.row)
                    self.itemNotes.remove(at: indexPath.row)
                    self.itemDeadlines.remove(at: indexPath.row)
                    self.itemPoints.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.defaults.set(self.totalJobIndex, forKey: "totalJobIndex")
                    self.defaults.set(self.itemTitles, forKey: "itemTitles")
                    self.defaults.set(self.itemLocations, forKey: "itemLocations")
                    self.defaults.set(self.itemNotes, forKey: "itemNotes")
                    self.defaults.set(self.itemDeadlines, forKey: "itemDeadlines")
                    self.defaults.set(self.itemPoints, forKey: "itemPoints")
                    tableView.reloadData()
                }))
                // Present
                self.present(alert, animated: true, completion: nil)
            } else if editingStyle == .insert {
        }    
    }
}
