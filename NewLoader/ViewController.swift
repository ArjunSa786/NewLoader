

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startLoaderact_clicked(_ sender: Any) {

        self.startActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.startActivityIndicator()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0, execute: {
            self.startActivityIndicator()
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.stopActivityIndicator()
        })
    }
}

