import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var searchList: UITableView!
    @IBOutlet weak var buildNumber: UILabel!
    
    private var searchListDataSource: SearchListDataSource?
    var masterSearchListData = [""]

    @IBAction func searchTapped(_ sender: Any) {
        searchList.isHidden = true
        let searchResultsViewController = SearchResultsViewController()
        searchResultsViewController.text = textInput.text!
        navigationController?.pushViewController(searchResultsViewController, animated: true)
    }

    @IBAction func searchDidEnd(_ sender: Any) {
        searchList.isHidden = true
    }

    @IBAction func searchDidBegin(_ sender: Any) {
        searchList.isHidden = false
    }

    @IBAction func searchChanged(_ sender: Any) {
        Alamofire.request("http://localhost:8080/products").responseJSON { (response) in
            if let productsJson = response.result.value as? [String: Any] {
                self.masterSearchListData = productsJson.map({ (product) -> String in
                    product.key
                })
                self.searchList.isHidden = false
                self.searchListDataSource?.textEntered = self.textInput.text!
                self.searchList.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchList.accessibilityLabel = "SearchList"
        searchList.separatorColor = UIColor.clear
        searchList.isHidden = true
        searchListDataSource = SearchListDataSource()
        searchListDataSource?.viewController = self
        searchList.dataSource = searchListDataSource
        searchList.delegate = searchListDataSource
        let nib = UINib(nibName: "SearchRowCell", bundle: nil)
        searchList.register(nib, forCellReuseIdentifier: "SearchRowCell")
        setBuildNumber()
    }

    func setSearchText(text: String) {
        textInput.text = text
    }

    private func setBuildNumber() {
        buildNumber.text = ""
        if let url = Bundle.main.url(forResource: "Info", withExtension: ".plist") {
            if let info = NSDictionary(contentsOf: url) {
                if let appVersion = info["CFBundleShortVersionString"] as? String {
                    if let buildNo = info["CFBundleVersion"] as? String, buildNo != "" {
                        buildNumber.text = appVersion + "." + buildNo
                    } else {
                        buildNumber.text = appVersion + "." + "DEV"
                    }
                }

            }
        }

    }
}

class SearchListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var _textEntered: String = ""
    var viewController: ViewController?
    var textEntered: String {
        get {
            return _textEntered
        }
        set {
            _textEntered = newValue
            predictiveSearchListData = viewController?.masterSearchListData.filter({ (data) -> Bool in
                (data as AnyObject).localizedCaseInsensitiveContains(textEntered)
            }) ?? []
        }
    }
    var predictiveSearchListData: [String] = []

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictiveSearchListData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.setSearchText(text: predictiveSearchListData[indexPath.row])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchRowCell", for: indexPath)
        cell.accessibilityIdentifier = "SearchList_\(indexPath.row + 1)"
        if let searchRowCell = cell as? SearchRowCell {
            searchRowCell.configure(predictiveSearchListData[indexPath.row])
        }
        return cell
    }
}



