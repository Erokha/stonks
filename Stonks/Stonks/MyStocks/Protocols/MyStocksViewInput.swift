protocol MyStocksViewInput: class {
    func setAvaliableBalance(balance: Int)
    func setStocksTotal(total: Int)
    func reloadTable()
    func startActivity()
    func endActivity()
}
