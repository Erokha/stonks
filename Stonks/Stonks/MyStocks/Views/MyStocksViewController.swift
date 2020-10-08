import UIKit


class MyStocksViewController: UIViewController, MyStocksViewType {

    @IBOutlet weak var ViewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    var presenter: MyStocksPresenterType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setShadow()
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "stockCell")
        tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    private func setShadow() {
        self.ViewContainer.layer.shadowColor = UIColor.black.cgColor
        self.ViewContainer.layer.shadowOpacity = 0.6
        self.ViewContainer.layer.shadowOffset = .zero
        self.ViewContainer.layer.shadowRadius = 10
    }
}

extension MyStocksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? TableViewCellType {
            cell.setData(data: self.presenter.model[indexPath.row])
            return cell as! UITableViewCell
        }
        return UITableViewCell()
    }
    
}
