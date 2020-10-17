
import UIKit

class NewsViewController: UIViewController {

    var ViewModel = LoginViewModel()
    @IBOutlet var NewsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.NewsTableView.estimatedRowHeight = 200
        self.NewsTableView.rowHeight = UITableView.automaticDimension
        self.NewsTableView.separatorColor = UIColor.clear
        self.NewsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")

        self.NewsTableView.dataSource = self
        self.NewsTableView.delegate = self

        self.ViewModel.delegate = self
        self.ViewModel.GetNewsAPICall(onSuccess: { status , msg in
            self.NewsTableView.reloadWithAnimation()
        }, onFailure: { msg in
            self.failureMessage(message: msg)
        })
    }
 
    
}

extension NewsViewController : LoginVCDelegate {
    
}

extension NewsViewController : UITableViewDelegate , UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ViewModel.newsdata?.payload.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
            return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell


        cell.urlString = self.ViewModel.newsdata?.payload[indexPath.row].image ?? ""

        cell.newsTitlelbl.text = self.ViewModel.newsdata?.payload[indexPath.row].title ?? ""
        cell.newsDescriptionlbl.text = self.ViewModel.newsdata?.payload[indexPath.row].descriptionField ?? ""
        cell.newsDatelbl.text = self.ViewModel.newsdata?.payload[indexPath.row].date ?? ""

        return cell
    }
}

