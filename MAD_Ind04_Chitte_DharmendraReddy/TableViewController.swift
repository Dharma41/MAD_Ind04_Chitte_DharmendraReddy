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

