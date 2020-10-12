import UIKit


class MyStocksViewController: UIViewController, MyStocksViewInput {

    @IBOutlet weak var ViewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    var presenter: MyStocksViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTalbeView()
        
    }
    
    private func configureTalbeView() {
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
        guard let count = self.presenter?.model.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        guard let content = self.presenter?.model[indexPath.row] else { return UITableViewCell() }
        cell.setData(data: content)
        return cell
        
    }
    
}
