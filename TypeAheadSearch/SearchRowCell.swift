import UIKit

class SearchRowCell: UITableViewCell {
    @IBOutlet weak var textView: UILabel!
    func configure(_ text: String) {
        textView.text = text
    }
}
