import Foundation

protocol MyStocksRouterInput: class {
    func showMainScreen()
    func showError(with error: Error)
}

protocol MyStoksInteractorInput: class {
    func loadStoks()
}

protocol MyStoksInteractorOutput: class {
    func didRecive(stoks: [Stock])
    func didReciveError(with error: Error)
}
