//
//  HomeViewController.swift
//  Gratuitous
//
//  Created by Rohit Jhangiani on 4/18/15.
//  Copyright (c) 2015 5TECH. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // outlets
    @IBOutlet weak var gratuitousTitleLabel: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipValueLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    @IBOutlet weak var splitTotalValueLabel: UILabel!
    @IBOutlet weak var settingsBarButton: UIBarButtonItem!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var horizontalSplitView: UIView!
    @IBOutlet weak var tipPercentageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var roundingSegementedControl: UISegmentedControl!
    @IBOutlet weak var barSplitterView: UIView!
    @IBOutlet weak var splitSlider: UISlider!
    
    // defaults
    var defaultTipPercentage = 20
    var defaultRoundingSettings = Rounding.None
    var defaultThemeSettings = Theme.Light
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeDefaults()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func billAmountTextFieldEditingChanged(sender: AnyObject) {
        var billAmount = (billAmountTextField.text as NSString).doubleValue
        var tipPercentages = [0.15, 0.20, 0.25] // ToDo: change to enum, move to helper class
        var roundingSettings = [Rounding.Down, Rounding.None, Rounding.Up]
        var selectedTipPercentage = tipPercentages[tipPercentageSegmentedControl.selectedSegmentIndex]
        var selectedRoundingSettings = roundingSettings[roundingSegementedControl.selectedSegmentIndex]
        
        var tip = billAmount * selectedTipPercentage
        var total = billAmount + tip
        var splitTotal = total
        
        switch selectedRoundingSettings
        {
        case Rounding.Down:
            
                total = floor(total)
                tip = total - billAmount
            
        case Rounding.Up:
            
                total = ceil(total)
                tip = total - billAmount
            
        default:
                total = billAmount + tip
        }
        
        var splitNumber = Int(splitSlider.value)
        var splitNumberDouble = Double(splitNumber)
        splitTotal = total/splitNumberDouble
        
        tipValueLabel.text = String(format: "$%0.2f",tip)
        totalValueLabel.text = String(format: "$%0.2",total)
        splitTotalValueLabel.text = String(format: "$%0.2",splitTotal)
    }
    
    @IBAction func splitSliderValueChanged(sender: AnyObject) {
        var splitSliderValue = Int(splitSlider.value)
        sliderLabel.text = "\(splitSliderValue)"
    }
    
    @IBAction func OnTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func initializeDefaults()  {
        tipValueLabel.text = "$0.00"
        totalValueLabel.text = "$0.00"
        splitTotalValueLabel.text = "$0.00"
        defaults.setObject(defaultTipPercentage, forKey: "defaultTipPercentage")
        defaults.setObject(defaultRoundingSettings.rawValue, forKey: "defaultRoundingSettings")
        defaults.setObject(defaultThemeSettings.rawValue, forKey: "defaultThemeSettings")
        defaults.synchronize() // just to be safe
    }
    
    override func viewWillAppear(animated: Bool) {
        loadWithCurrentSettings()
    }
    
    func loadWithCurrentSettings() {
        
        if var defaultTheme = defaults.objectForKey("defaultThemeSettings")! as? Int {
            defaultThemeSettings = Theme(rawValue: defaultTheme)!
            switch defaultThemeSettings
            {
            case Theme.Light:
                setLightThemeColors()
            case Theme.Dark:
                setDarkThemeColors()
            default:
                setLightThemeColors()
            }
        }
        
        if var defaultTipPercentage = defaults.objectForKey("defaultTipPercentage")! as? Int {
            switch defaultTipPercentage
            {
            case 15:
                tipPercentageSegmentedControl.selectedSegmentIndex = 0
            case 20:
                tipPercentageSegmentedControl.selectedSegmentIndex = 1
            case 25:
                tipPercentageSegmentedControl.selectedSegmentIndex = 2
            default:
                tipPercentageSegmentedControl.selectedSegmentIndex = 1
            }
        }
        
        if var defaultRounding = defaults.objectForKey("defaultRoundingSettings")! as? Int {
            defaultRoundingSettings = Rounding(rawValue: defaultRounding)!
            switch defaultRoundingSettings
            {
            case Rounding.Down:
                roundingSegementedControl.selectedSegmentIndex = 0
            case Rounding.None:
                roundingSegementedControl.selectedSegmentIndex = 1
            case Rounding.Up:
                roundingSegementedControl.selectedSegmentIndex = 2
            }
        }
    }
    
    func setLightThemeColors()
    {
        view.backgroundColor = UIColor.cyanColor()
        var lightThemeTextColor = UIColor.blueColor()
        gratuitousTitleLabel.textColor = lightThemeTextColor
        billAmountLabel.textColor = lightThemeTextColor
        tipLabel.textColor = lightThemeTextColor
        tipValueLabel.textColor = lightThemeTextColor
        totalLabel.textColor = lightThemeTextColor
        totalValueLabel.textColor = lightThemeTextColor
        splitLabel.textColor = lightThemeTextColor
        sliderLabel.textColor = lightThemeTextColor
        splitTotalLabel.textColor = lightThemeTextColor
        splitTotalValueLabel.textColor = lightThemeTextColor
        barSplitterView.backgroundColor = lightThemeTextColor
        splitSlider.tintColor = lightThemeTextColor
    }
    
    func setDarkThemeColors()
    {
        view.backgroundColor = UIColor.blackColor()
        var darkThemeTextColor = UIColor.lightGrayColor()
        gratuitousTitleLabel.textColor = darkThemeTextColor
        billAmountLabel.textColor = darkThemeTextColor
        tipLabel.textColor = darkThemeTextColor
        tipValueLabel.textColor = darkThemeTextColor
        totalLabel.textColor = darkThemeTextColor
        totalValueLabel.textColor = darkThemeTextColor
        splitLabel.textColor = darkThemeTextColor
        sliderLabel.textColor = darkThemeTextColor
        splitTotalLabel.textColor = darkThemeTextColor
        splitTotalValueLabel.textColor = darkThemeTextColor
        barSplitterView.backgroundColor = darkThemeTextColor
        splitSlider.tintColor = darkThemeTextColor
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
