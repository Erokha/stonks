protocol MyStocksPresenterType {
    var model: [Stock] { get set }
    
    init(view: MyStocksViewType, model: [Stock])
    
}
