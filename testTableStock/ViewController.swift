//
//  ViewController.swift
//  testTableStock
//
//  Created by kymblc on 30.09.2020.
//  Copyright © 2020 traceback. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    var stocksMas: [stockStruct]! {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        readStocksFromApi()
        
    }
    
    func readStocksFromApi() {
        let url = "http://192.168.31.36:8000/allStocks"
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else { print("Error hanled"); return }
            self.stocksMas = try? JSONDecoder().decode([stockStruct].self, from: data)
        }
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksMas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! TableViewCell
        cell.configure(arrivedStock: stocksMas[indexPath.row])
        return cell
    }
    
    
}
