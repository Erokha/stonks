//
//  MyStocksInteractor.swift
//  Stonks
//
//  Created by kymblc on 23.10.2020.
//

import Foundation
import Alamofire

final class MyStocksInteractor {
    weak var output: MyStoksInteractorOutput?

    private func handleError(with error: AFError) {
        switch error {
        case .sessionTaskFailed:
            output?.didReciveError(with: AppError.networkError)
        default:
            output?.didReciveError(with: AppError.undefinedError)
        }
    }

    private func handleStock(with stocksRaw: [StockRaw]) {
        let stocks: [StockData] = stocksRaw.map({ StockData(with: $0) })
        output?.didRecive(stoks: stocks)
    }

}

extension MyStocksInteractor: MyStoksInteractorInput {
    func loadStoks() {
        let url = "http://stonks.kkapp.ru:8000/allStocks"
        let request = AF.request(url)
        request.responseDecodable(of: [StockRaw].self) { [weak self] response in
            switch response.result {
            case .success(let stocksRaw):
                self?.handleStock(with: stocksRaw)
            case .failure(let error):
                self?.handleError(with: error)
            }
        }
    }

}

final class MyStocksMockInteractor {
    weak var output: MyStoksInteractorOutput?

    private func handleError(with error: AFError) {
        switch error {
        case .sessionTaskFailed:
            output?.didReciveError(with: AppError.networkError)
        default:
            output?.didReciveError(with: AppError.undefinedError)
        }
    }

    private func handleStock(with stocksRaw: [StockRaw]) {
        let stocks: [StockData] = stocksRaw.map({ StockData(with: $0) })
        output?.didRecive(stoks: stocks)
    }

}

extension MyStocksMockInteractor: MyStoksInteractorInput {
    func loadStoks() {
        handleStock(with: [StockRaw(stockName: "asd", stockSymbol: "asd", stockPrice: 12, imageUrl: "asd")])
    }

}
