//
//  MusicFilterViewController.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation
import UIKit

class MusicFilterViewController: UIViewController {
    @IBOutlet weak var genrePickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!

    var genres: [String] = []
    var filteredMusic: [Music] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        genrePickerView.delegate = self
        genrePickerView.dataSource = self

        genres = DataManager.shared.loadGenres()
        genrePickerView.reloadAllComponents()
    }

    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let selectedRow = genrePickerView.selectedRow(inComponent: 0)
        let genre = genres[selectedRow]

        if genre.isEmpty {
            // Handle empty genre error
            return
        }

        filteredMusic = DataManager.shared.filterMusic(genre: genre)
        tableView.reloadData()
    }
}

extension MusicFilterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMusic.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicTableViewCell

        let music = filteredMusic[indexPath.row]
        let viewModel = MusicViewModel(music: music)
        cell.configure(with: viewModel)

        return cell
    }
}

extension MusicFilterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
}
