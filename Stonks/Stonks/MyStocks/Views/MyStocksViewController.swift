import UIKit


class MyStocksViewController: UIViewController, MyStocksViewInput {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    var output: MyStocksViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTalbeView()
    }
    
    private func configureTalbeView() {
        setShadow()
        self.tableView.register(UINib(nibName: "StockTableViewCell", bundle: nil), forCellReuseIdentifier: StockTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setShadow() {
        self.viewContainer.layer.shadowColor = UIColor.black.cgColor
        self.viewContainer.layer.shadowOpacity = 0.6
        self.viewContainer.layer.shadowOffset = .zero
        self.viewContainer.layer.shadowRadius = 10
    }
}

extension MyStocksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.output?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseIdentifier, for: indexPath) as? StockTableViewCell else { return UITableViewCell()}
        guard let viewModel = output?.stock(at: indexPath) else { return UITableViewCell() }
        cell.setData(data: viewModel)

        return cell
        
    }
    
}
