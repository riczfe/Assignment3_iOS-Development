//
//  MusicSearchViewController.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation
import UIKit

class MusicSearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var searchResults: [Music] = []

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let query = searchTextField.text ?? ""

        if query.isEmpty {
            // Handle empty search query error
            return
        }

        searchResults = DataManager.shared.searchMusic(query: query)
        tableView.reloadData()
    }
}

extension MusicSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicTableViewCell

        let music = searchResults[indexPath.row]
        let viewModel = MusicViewModel(music: music)
        cell.configure(with: viewModel)

        return cell
    }
}
