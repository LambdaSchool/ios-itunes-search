//
//  SettingsViewController.swift
//  iTunes Search
//
//  Created by Dillon McElhinney on 9/11/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var numberOfResultsSlider: UISlider!
    @IBOutlet weak var numberOfResultsToDisplayLabel: UILabel!
    @IBOutlet weak var countryCodeSegmentedControl: UISegmentedControl!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if there is already a setting for number of results
        if UserDefaults.standard.integer(forKey: SettingsKeys.numberOfResultsKey.rawValue) == 0 {
            // If not, set it to the default of 40
            UserDefaults.standard.set(40, forKey: SettingsKeys.numberOfResultsKey.rawValue)
        }
        
        // Check if there is already a setting for country code
        if UserDefaults.standard.string(forKey: SettingsKeys.countryCodeKey.rawValue) == nil {
            // If not, set it to the default of US
            UserDefaults.standard.set(CountryCode.unitedStates.rawValue, forKey: SettingsKeys.countryCodeKey.rawValue)
        }
        
        // Set the slider to reflect the default value
        numberOfResultsSlider.value = UserDefaults.standard.float(forKey: SettingsKeys.numberOfResultsKey.rawValue)
        
        // Set the segmented controler to reflect the default value
        switch UserDefaults.standard.string(forKey: SettingsKeys.countryCodeKey.rawValue) {
        case "US": countryCodeSegmentedControl.selectedSegmentIndex = 0
        case "GB": countryCodeSegmentedControl.selectedSegmentIndex = 1
        case "JP": countryCodeSegmentedControl.selectedSegmentIndex = 2
        default: break
        }
        
        // Update label
        updateViews()
    }
    
    // MARK: - UI Methods
    @IBAction func changeNumber(_ sender: UISlider) {
        // When the value of the slider changes, update the user default and the label
        UserDefaults.standard.set(Int(sender.value), forKey: SettingsKeys.numberOfResultsKey.rawValue)
        updateViews()
    }
    
    @IBAction func changeCountry(_ sender: UISegmentedControl) {
        // When the segmented control changes, update the user default
        switch countryCodeSegmentedControl.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(CountryCode.unitedStates.rawValue, forKey: SettingsKeys.countryCodeKey.rawValue)
        case 1:
            UserDefaults.standard.set(CountryCode.greatBritain.rawValue, forKey: SettingsKeys.countryCodeKey.rawValue)
        case 2:
            UserDefaults.standard.set(CountryCode.japan.rawValue, forKey: SettingsKeys.countryCodeKey.rawValue)
        default: break
        }

    }

    // MARK: - Private Utility Methods
    private func updateViews() {
        let numberOfResultsToDisplay = UserDefaults.standard.integer(forKey: SettingsKeys.numberOfResultsKey.rawValue)
        numberOfResultsToDisplayLabel.text = "Number of Results to Display: \(numberOfResultsToDisplay)"
    }
}
