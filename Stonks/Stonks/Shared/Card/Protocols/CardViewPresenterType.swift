protocol CardViewPresenterType: class {
    init(view: CardViewType)

    func setUpperTextLeft(text: String)

    func setUpperTextRight(text: String)

    func setNumberLeft(num: Int?)

    func setNumberRight(num: Int?)
}
