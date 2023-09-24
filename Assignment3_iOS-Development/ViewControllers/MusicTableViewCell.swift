import UIKit

class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!ư
    
    func configure(with viewModel: MusicCellViewModel) {
        titleLabel.text = viewModel.title
        artistLabel.text = viewModel.artist
        albumLabel.text = viewModel.album
    }
}
