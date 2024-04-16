//
//  ViewController.swift
//  MAD_Ind04_Chitte_DharmendraReddy
//
//  Created by DHARMENDRA REDDY CHITTE on 4/16/24.
//

import UIKit

// ViewController to display details about a U.S. state
class ViewController: UIViewController {
     
     // Properties to store state details
     var stateName: String? // Name of the state
     var stateNickname: String? // Nickname of the state
     var stateFlag: UIImage? // Image of the state's flag
     var stateMap: UIImage? // Image of the state's map
     var stateArea: String? // Area of the state
    
    // Outlets for UI elements in the storyboard
    @IBOutlet weak var flagImageView: UIImageView! // Displays the state's flag
    @IBOutlet weak var nameLabel: UILabel! // Displays the state's name
    @IBOutlet weak var mapImageView: UIImageView! // Displays the state's map
    @IBOutlet weak var areaLabel: UILabel! // Displays the state's area
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the UI elements with the data passed to this view controller
        nameLabel.text = stateName
        flagImageView.image = stateFlag
        mapImageView.image = stateMap
        areaLabel.text = stateArea
    }
}
