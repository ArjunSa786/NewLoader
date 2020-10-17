
import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: AyncImageView!
    @IBOutlet weak var newsTitlelbl: UILabel!
    @IBOutlet weak var newsDescriptionlbl: UILabel!
    @IBOutlet weak var newsDatelbl: UILabel!

    var urlString: String? {
        didSet {
            if let url = urlString {
                newsImageView.loadAsyncFrom(url: url, placeholder: nil)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
