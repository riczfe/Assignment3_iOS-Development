//
//  MusicListViewController.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation
import UIKit

class MusicListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var music: [Music] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        music = DataManager.shared.loadMusic()
        tableView.reloadData()
    }
}

extension MusicListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return music.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicTableViewCell

        let musicItem = music[indexPath.row]
        let viewModel = MusicCellViewModel(music: musicItem) // Corrected class name to MusicCellViewModel
        cell.configure(with: viewModel)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let musicItem = music[indexPath.row]
        // Handle music item selection
    }
}
