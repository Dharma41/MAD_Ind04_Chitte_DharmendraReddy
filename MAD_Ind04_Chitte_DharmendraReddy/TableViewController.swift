//
//  TableViewController.swift
//  MAD_Ind04_Chitte_DharmendraReddy
//
//  Created by DHARMENDRA REDDY CHITTE on 4/16/24.
//

import UIKit

import Foundation

struct State: Codable {
    let name: String
    let nickname: String
}


class TableViewController: UITableViewController {
    var states = [State]()
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        fetchStates()
    }

    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        activityIndicator.startAnimating()
    }


    func fetchStates() {
        guard let url = URL(string: "https://cs.okstate.edu/~dchitte/states.php") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {  // Ensure all UI updates are on the main thread
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()

                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                if let decodedResponse = try? JSONDecoder().decode([State].self, from: data) {
                    self.states = decodedResponse
                    self.tableView.reloadData()
                } else {
                    print("Invalid response from server")
                }
            }
        }.resume()
    }


    // Table View Data Source Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = state.nickname
        return cell
    }
}


//class TableViewController: UITableViewController {
//    
//    struct StateInfo {
//        let name: String
//        let nickname: String
//        let flagImageName: String
//        let mapImageName: String
//        let area: String
//    }
//    // Datasource of 50 states of USA
//    let myDatasource: [StateInfo] = [
//        StateInfo(name: "Alabama", nickname: "The Yellowhammer State", flagImageName: "AlabamaFlag", mapImageName: "1", area: "52,420 sq mi"),
//        StateInfo(name: "Alaska", nickname: "The Last Frontier", flagImageName: "AlaskaFlag", mapImageName: "2", area: "663,267 sq mi"),
//        StateInfo(name: "Arizona", nickname: "The Grand Canyon State", flagImageName: "ArizonaFlag", mapImageName: "3", area: "113,990 sq mi"),
//        StateInfo(name: "Arkansas", nickname: "The Natural State", flagImageName: "ArkansasFlag", mapImageName: "4", area: "53,179 sq mi"),
//        StateInfo(name: "California", nickname: "The Golden State", flagImageName: "CaliforniaFlag", mapImageName: "5", area: "163,695 sq mi"),
//        StateInfo(name: "Colorado", nickname: "The Centennial State", flagImageName: "ColoradoFlag", mapImageName: "6", area: "104,094 sq mi"),
//        StateInfo(name: "Connecticut", nickname: "The Constitution State", flagImageName: "ConnecticutFlag", mapImageName: "7", area: "5,543 sq mi"),
//        StateInfo(name: "Delaware", nickname: "The First State", flagImageName: "DelawareFlag", mapImageName: "8", area: "2,489 sq mi"),
//        StateInfo(name: "Florida", nickname: "The Sunshine State", flagImageName: "FloridaFlag", mapImageName: "9", area: "65,758 sq mi"),
//        StateInfo(name: "Georgia", nickname: "The Peach State", flagImageName: "GeorgiaFlag", mapImageName: "10", area: "59,425 sq mi"),
//        StateInfo(name: "Hawaii", nickname: "The Aloha State", flagImageName: "HawaiiFlag", mapImageName: "11", area: "10,932 sq mi"),
//        StateInfo(name: "Idaho", nickname: "The Gem State", flagImageName: "IdahoFlag", mapImageName: "12", area: "83,569 sq mi"),
//        StateInfo(name: "Illinois", nickname: "The Prairie State", flagImageName: "IllinoisFlag", mapImageName: "13", area: "57,914 sq mi"),
//        StateInfo(name: "Indiana", nickname: "The Hoosier State", flagImageName: "IndianaFlag", mapImageName: "14", area: "36,420 sq mi"),
//        StateInfo(name: "Iowa", nickname: "The Hawkeye State", flagImageName: "IowaFlag", mapImageName: "15", area: "56,273 sq mi"),
//        StateInfo(name: "Kansas", nickname: "The Sunflower State", flagImageName: "KansasFlag", mapImageName: "16", area: "82,278 sq mi"),
//        StateInfo(name: "Kentucky", nickname: "The Bluegrass State", flagImageName: "KentuckyFlag", mapImageName: "17", area: "40,408 sq mi"),
//        StateInfo(name: "Louisiana", nickname: "The Pelican State", flagImageName: "LouisianaFlag", mapImageName: "18", area: "52,378 sq mi"),
//        StateInfo(name: "Maine", nickname: "The Pine Tree State", flagImageName: "MaineFlag", mapImageName: "19", area: "35,380 sq mi"),
//        StateInfo(name: "Maryland", nickname: "The Old Line State", flagImageName: "MarylandFlag", mapImageName: "20", area: "12,406 sq mi"),
//        StateInfo(name: "Massachusetts", nickname: "The Bay State", flagImageName: "MassachusettsFlag", mapImageName: "21", area: "10,554 sq mi"),
//        StateInfo(name: "Michigan", nickname: "The Great Lakes State", flagImageName: "MichiganFlag", mapImageName: "22", area: "96,714 sq mi"),
//        StateInfo(name: "Minnesota", nickname: "The North Star State", flagImageName: "MinnesotaFlag", mapImageName: "23", area: "86,936 sq mi"),
//        StateInfo(name: "Mississippi", nickname: "The Magnolia State", flagImageName: "MississippiFlag", mapImageName: "24", area: "48,432 sq mi"),
//        StateInfo(name: "Missouri", nickname: "The Show Me State", flagImageName: "MissouriFlag", mapImageName: "25", area: "69,707 sq mi"),
//        StateInfo(name: "Montana", nickname: "The Treasure State", flagImageName: "MontanaFlag", mapImageName: "26", area: "147,040 sq mi"),
//        StateInfo(name: "Nebraska", nickname: "The Cornhusker State", flagImageName: "NebraskaFlag", mapImageName: "27", area: "77,348 sq mi"),
//        StateInfo(name: "Nevada", nickname: "The Silver State", flagImageName: "NevadaFlag", mapImageName: "28", area: "110,572 sq mi"),
//        StateInfo(name: "New Hampshire", nickname: "The Granite State", flagImageName: "NewHampshireFlag", mapImageName: "29", area: "9,349 sq mi"),
//        StateInfo(name: "New Jersey", nickname: "The Garden State", flagImageName: "NewJerseyFlag", mapImageName: "30", area: "8,723 sq mi"),
//        StateInfo(name: "New Mexico", nickname: "The Land of Enchantment", flagImageName: "NewMexicoFlag", mapImageName: "31", area: "121,590 sq mi"),
//        StateInfo(name: "New York", nickname: "The Empire State", flagImageName: "NewYorkFlag", mapImageName: "32", area: "54,555 sq mi"),
//        StateInfo(name: "North Carolina", nickname: "The Tar Heel State", flagImageName: "NorthCarolinaFlag", mapImageName: "33", area: "53,819 sq mi"),
//        StateInfo(name: "North Dakota", nickname: "The Peace Garden State", flagImageName: "NorthDakotaFlag", mapImageName: "34", area: "70,698 sq mi"),
//        StateInfo(name: "Ohio", nickname: "The Buckeye State", flagImageName: "OhioFlag", mapImageName: "35", area: "44,826 sq mi"),
//        StateInfo(name: "Oklahoma", nickname: "The Sooner State", flagImageName: "OklahomaFlag", mapImageName: "36", area: "69,899 sq mi"),
//        StateInfo(name: "Oregon", nickname: "The Beaver State", flagImageName: "OregonFlag", mapImageName: "37", area: "98,379 sq mi"),
//        StateInfo(name: "Pennsylvania", nickname: "The Keystone State", flagImageName: "PennsylvaniaFlag", mapImageName: "38", area: "46,055 sq mi"),
//        StateInfo(name: "Rhode Island", nickname: "The Ocean State", flagImageName: "RhodeIslandFlag", mapImageName: "39", area: "1,545 sq mi"),
//        StateInfo(name: "South Carolina", nickname: "The Palmetto State", flagImageName: "SouthCarolinaFlag", mapImageName: "40", area: "32,020 sq mi"),
//        StateInfo(name: "South Dakota", nickname: "The Mount Rushmore State", flagImageName: "SouthDakotaFlag", mapImageName: "41", area: "77,116 sq mi"),
//        StateInfo(name: "Tennessee", nickname: "The Volunteer State", flagImageName: "TennesseeFlag", mapImageName: "42", area: "42,144 sq mi"),
//        StateInfo(name: "Texas", nickname: "The Lone Star State", flagImageName: "TexasFlag", mapImageName: "43", area: "268,596 sq mi"),
//        StateInfo(name: "Utah", nickname: "The Beehive State", flagImageName: "UtahFlag", mapImageName: "44", area: "84,897 sq mi"),
//        StateInfo(name: "Vermont", nickname: "The Green Mountain State", flagImageName: "VermontFlag", mapImageName: "45", area: "9,616 sq mi"),
//        StateInfo(name: "Virginia", nickname: "The Old Dominion State", flagImageName: "VirginiaFlag", mapImageName: "46", area: "42,775 sq mi"),
//        StateInfo(name: "Washington", nickname: "The Evergreen State", flagImageName: "WashingtonFlag", mapImageName: "47", area: "71,298 sq mi"),
//        StateInfo(name: "West Virginia", nickname: "The Mountain State", flagImageName: "WestVirginiaFlag", mapImageName: "48", area: "24,230 sq mi"),
//        StateInfo(name: "Wisconsin", nickname: "The Badger State", flagImageName: "WisconsinFlag", mapImageName: "49", area: "65,496 sq mi"),
//        StateInfo(name: "Wyoming", nickname: "The Equality State", flagImageName: "WyomingFlag", mapImageName: "50", area: "97,813 sq mi")
//    ]
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }
//
//    // MARK: - Table view data source
//
//  
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return myDatasource.count
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        let stateInfo = myDatasource[indexPath.row]
//        cell.textLabel?.text = stateInfo.name
//        cell.detailTextLabel?.text = stateInfo.nickname  // or another suitable detail
//
//        return cell
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showStateDetail",
//           let destinationVC = segue.destination as? ViewController,
//           let indexPath = tableView.indexPathForSelectedRow {
//            let stateInfo = myDatasource[indexPath.row]
//            destinationVC.stateName = stateInfo.name
//            destinationVC.stateFlag = UIImage(named: stateInfo.flagImageName)
//            destinationVC.stateMap = UIImage(named: stateInfo.mapImageName)
//            destinationVC.stateArea = stateInfo.area
//        }
//    }
//
//
//    
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
