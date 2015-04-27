//
//  SettingsTableViewController.swift
//  Gratuitous
//
//  Created by Rohit Jhangiani on 4/18/15.
//  Copyright (c) 2015 5TECH. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var defaultTipPercentageSegementedControl: UISegmentedControl!
    @IBOutlet weak var defaultRoundingSegementedControl: UISegmentedControl!
    @IBOutlet weak var defaultThemeSegementedControl: UISegmentedControl!
    
    // default values, ToDo: move to a helper class
    var defaultRoundingSettings = Rounding.None
    var defaultTheme = Theme.Light
    var defaultTipPercentage = 20
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var tipPercentages = [15,20,25] // ToDo: change to enum & move to helper class

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        loadDefaultSettings()
    }
    
    override func viewWillDisappear(animated: Bool) {
        saveDefaultSettings() // ToDo: wireup w segmented control actions
    }
    
    func loadDefaultSettings()
    {
        if let currentDefaultTipPercentage = defaults.objectForKey("defaultTipPercentage") as? Int {
            defaultTipPercentage = currentDefaultTipPercentage
        }
        
        if let currentRoundingSettings = defaults.objectForKey("defaultRoundingSettings") as? Int {
            defaultRoundingSettings = Rounding(rawValue: currentRoundingSettings)!
        }
        
        if let currentThemeSettings = defaults.objectForKey("defaultThemeSettings") as? Int {
            defaultTheme = Theme(rawValue: currentThemeSettings)!
        }
        
        switch(defaultTipPercentage)
        {
        case tipPercentages[0]:
            defaultTipPercentageSegementedControl.selectedSegmentIndex = 0
        case tipPercentages[1]:
            defaultTipPercentageSegementedControl.selectedSegmentIndex = 1
        case tipPercentages[2]:
            defaultTipPercentageSegementedControl.selectedSegmentIndex = 2
        default:
            defaultTipPercentageSegementedControl.selectedSegmentIndex = 1
        }
        
        switch(defaultRoundingSettings)
        {
        case Rounding.Down:
            defaultRoundingSegementedControl.selectedSegmentIndex = 0
        case Rounding.None:
            defaultRoundingSegementedControl.selectedSegmentIndex = 1
        case Rounding.Up:
            defaultRoundingSegementedControl.selectedSegmentIndex = 2
        default:
            defaultRoundingSegementedControl.selectedSegmentIndex = 1
        }
        
        switch(defaultTheme)
        {
        case Theme.Light:
            defaultThemeSegementedControl.selectedSegmentIndex = 0
        case Theme.Dark:
            defaultThemeSegementedControl.selectedSegmentIndex = 1
        default:
            defaultThemeSegementedControl.selectedSegmentIndex = 0
        }
    }
    
    func saveDefaultSettings() {
        defaultTipPercentage = tipPercentages[defaultTipPercentageSegementedControl.selectedSegmentIndex]
        
        switch(defaultRoundingSegementedControl.selectedSegmentIndex)
        {
        case 0:
            defaultRoundingSettings = Rounding.Down
        case 1:
            defaultRoundingSettings = Rounding.None
        case 2:
            defaultRoundingSettings = Rounding.Up
        default:
            defaultRoundingSettings = Rounding.None
        }
        
        switch(defaultThemeSegementedControl.selectedSegmentIndex)
        {
        case 0:
            defaultTheme = Theme.Light
        case 1:
            defaultTheme = Theme.Dark
        default:
            defaultTheme = Theme.Light
        }
        
        defaults.setObject(defaultTipPercentage, forKey: "defaultTipPercentage")
        defaults.setObject(defaultRoundingSettings.rawValue, forKey: "defaultRoundingSettings")
        defaults.setObject(defaultTheme.rawValue, forKey: "defaultThemeSettings")
        defaults.synchronize() // force sync, to be safe
    }
}

