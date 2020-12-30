import UIKit
import Charts
import PinLayout

final class StockDetailViewController: UIViewController {
    var output: StockDetailViewOutput?

    private weak var cardPresenter: CardViewPresenterType?

    private weak var showMyStocksButton: UIButton!

    private weak var companyNameLabel: UILabel!

    private weak var stockDetailCardView: NewCardView!

    private weak var chartContainerView: UIView!

    private weak var stockSymbolLabel: UILabel!

    private weak var stockCurrentCostLabel: UILabel!

    private weak var stockAmountLabel: UILabel!

    private weak var buyButton: UIButton!

    private weak var sellButton: UIButton!

    private weak var buyTextFieldContainerView: UIView!

    private weak var sellTextFieldContainerView: UIView!

    private weak var buyTextField: UITextField!

    private weak var sellTextField: UITextField!

    private weak var loadIndicator: UIActivityIndicatorView!

    private weak var stockLineChartView: (StockDetailChartView & StockDetailChartViewInput)!

    private var keyboardOffset: CGFloat?

    private func setupChartContainerView() {
        let chartView = UIView()

        chartContainerView = chartView
        view.addSubview(chartContainerView)

        chartContainerView.backgroundColor = Constants.ChartContainerView.backgoundColor
        chartContainerView.layer.cornerRadius = Constants.ChartContainerView.cornerRadius
        chartContainerView.layer.shadowColor = Constants.ChartContainerView.shadowColor.cgColor
        chartContainerView.layer.shadowOffset = Constants.ChartContainerView.shadowOffset
        chartContainerView.layer.shadowRadius = Constants.ChartContainerView.shadowRadius
        chartContainerView.layer.shadowOpacity = Constants.ChartContainerView.shadowOpacity
    }

    private func setupStockDetailCardView() {
        let cardView = CardViewContainer.assemble(with: CardViewContext()).view

        stockDetailCardView = cardView
        view.addSubview(stockDetailCardView)

        stockDetailCardView.backgroundColor = Constants.StockDetailCardView.backgoundColor
        stockDetailCardView.layer.cornerRadius = Constants.StockDetailCardView.cornerRadius
        stockDetailCardView.layer.cornerRadius = Constants.StockDetailCardView.cornerRadius
        stockDetailCardView.layer.shadowColor = Constants.StockDetailCardView.shadowColor.cgColor
        stockDetailCardView.layer.shadowOffset = Constants.StockDetailCardView.shadowOffset
        stockDetailCardView.layer.shadowRadius = Constants.StockDetailCardView.shadowRadius
        stockDetailCardView.layer.shadowOpacity = Constants.StockDetailCardView.shadowOpacity

        self.cardPresenter = stockDetailCardView.presenter

        self.cardPresenter?.setUpperTextLeft(text: Constants.StockDetailCardView.leftText)
        self.cardPresenter?.setUpperTextRight(text: Constants.StockDetailCardView.rightText)
    }

    private func setupBuyButton() {
        let button = UIButton()

        buyButton = button
        view.addSubview(buyButton)

        buyButton.backgroundColor = Constants.BuyButton.backgroundColor
        buyButton.titleLabel?.font = Constants.Buttons.font
        buyButton.setTitleColor(Constants.Buttons.textColor, for: .normal)
        buyButton.setTitle(Constants.BuyButton.text, for: .normal)
        buyButton.layer.cornerRadius = Constants.Buttons.cornerRadius

        buyButton.layer.shadowColor = Constants.Buttons.shadowColor.cgColor
        buyButton.layer.shadowOffset = Constants.Buttons.shadowOffset
        buyButton.layer.shadowRadius = Constants.Buttons.shadowRadius
        buyButton.layer.shadowOpacity = Constants.Buttons.shadowOpacity

        buyButton.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
    }

    @objc
    private func didTapBuyButton() {
        output?.didTapBuyButton(amount: buyTextField.text)
    }

    @objc
    private func didTapSellButton() {
        output?.didTapSellButton(amount: sellTextField.text)
    }

    @objc
    private func didTapShowMyStocksButton() {
        output?.didTapShowMyStocksButton()
    }

    @objc
    private func didTapLineChartView(_ sender: UITapGestureRecognizer) {
        output?.didTapLineChartView(location: sender.location(in: stockLineChartView))
    }

    private func setupSellButton() {
        let button = UIButton()

        sellButton = button
        view.addSubview(sellButton)

        sellButton.backgroundColor = Constants.SellButton.backgroundColor
        sellButton.titleLabel?.font = Constants.Buttons.font
        sellButton.setTitleColor(Constants.Buttons.textColor, for: .normal)
        sellButton.setTitle(Constants.SellButton.text, for: .normal)
        sellButton.layer.cornerRadius = Constants.Buttons.cornerRadius

        sellButton.layer.shadowColor = Constants.Buttons.shadowColor.cgColor
        sellButton.layer.shadowOffset = Constants.Buttons.shadowOffset
        sellButton.layer.shadowRadius = Constants.Buttons.shadowRadius
        sellButton.layer.shadowOpacity = Constants.Buttons.shadowOpacity

        sellButton.addTarget(self, action: #selector(didTapSellButton), for: .touchUpInside)
    }

    private func setupBuyTextField() {
        let textField = UITextField()

        buyTextField = textField
        buyTextFieldContainerView.addSubview(buyTextField)

        buyTextField.clipsToBounds = true
        buyTextField.layer.cornerRadius = Constants.TextField.cornerRadius
        buyTextField.layer.borderWidth = Constants.TextField.borderWidth
        buyTextField.backgroundColor = Constants.TextField.backgroundColor
        buyTextField.layer.borderColor = Constants.TextField.borderColor.cgColor

        buyTextField.leftView = UIView(frame: CGRect(x: .zero,
                                                         y: .zero,
                                                         width: Constants.textFieldTextLeftSpacing,
                                                         height: .zero))
        buyTextField.leftViewMode = .always
        buyTextField.rightView = UIView(frame: CGRect(x: .zero,
                                                          y: .zero,
                                                          width: Constants.textFieldTextRightSpacing,
                                                          height: .zero))
        buyTextField.rightViewMode = .unlessEditing

        buyTextField.clearButtonMode = .whileEditing
        buyTextField.autocorrectionType = .no

        buyTextField.font = Constants.TextField.font
        buyTextField.attributedPlaceholder = NSAttributedString(string: Constants.TextField.placeholderText,
                                                                attributes: [NSAttributedString.Key.foregroundColor: Constants.TextField.placeholderTextColor])
    }

    private func setupBuyTextFieldContainerView() {
        let container = UIView()

        buyTextFieldContainerView = container
        view.addSubview(buyTextFieldContainerView)

        buyTextFieldContainerView.layer.cornerRadius = Constants.TextField.cornerRadius

        buyTextFieldContainerView.layer.shadowColor = Constants.TextField.shadowColor.cgColor
        buyTextFieldContainerView.layer.shadowOffset = Constants.TextField.shadowOffset
        buyTextFieldContainerView.layer.shadowRadius = Constants.TextField.shadowRadius
        buyTextFieldContainerView.layer.shadowOpacity = Constants.TextField.shadowOpacity
    }

    private func setupSellTextField() {
        let textField = UITextField()

        sellTextField = textField
        sellTextFieldContainerView.addSubview(sellTextField)

        sellTextField.clipsToBounds = true
        sellTextField.layer.cornerRadius = Constants.TextField.cornerRadius
        sellTextField.layer.borderWidth = Constants.TextField.borderWidth
        sellTextField.backgroundColor = Constants.TextField.backgroundColor
        sellTextField.layer.borderColor = Constants.TextField.borderColor.cgColor

        sellTextField.leftView = UIView(frame: CGRect(x: .zero,
                                                         y: .zero,
                                                         width: Constants.textFieldTextLeftSpacing,
                                                         height: .zero))
        sellTextField.leftViewMode = .always
        sellTextField.rightView = UIView(frame: CGRect(x: .zero,
                                                          y: .zero,
                                                          width: Constants.textFieldTextRightSpacing,
                                                          height: .zero))
        sellTextField.rightViewMode = .unlessEditing

        sellTextField.clearButtonMode = .whileEditing
        sellTextField.autocorrectionType = .no

        sellTextField.font = Constants.TextField.font
        sellTextField.attributedPlaceholder = NSAttributedString(string: Constants.TextField.placeholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.TextField.placeholderTextColor])
    }

    private func setupSellTextFieldContainerView() {
        let container = UIView()

        sellTextFieldContainerView = container
        view.addSubview(sellTextFieldContainerView)

        sellTextFieldContainerView.layer.cornerRadius = Constants.TextField.cornerRadius

        sellTextFieldContainerView.layer.shadowColor = Constants.TextField.shadowColor.cgColor
        sellTextFieldContainerView.layer.shadowOffset = Constants.TextField.shadowOffset
        sellTextFieldContainerView.layer.shadowRadius = Constants.TextField.shadowRadius
        sellTextFieldContainerView.layer.shadowOpacity = Constants.TextField.shadowOpacity
    }

    private func setupStockNameLabel() {
        let label = UILabel()

        stockSymbolLabel = label
        chartContainerView.addSubview(stockSymbolLabel)

        stockSymbolLabel.textAlignment = .left
        stockSymbolLabel.font = Constants.StockSymbolLabel.font
    }

    private func setupStockCurrentCostLabel() {
        let label = UILabel()

        stockCurrentCostLabel = label
        chartContainerView.addSubview(stockCurrentCostLabel)

        stockCurrentCostLabel.textAlignment = .right
        stockCurrentCostLabel.font = Constants.StockCurrentCostLabel.font
    }

    private func setupShowMyStocksButton() {
        let button = UIButton()

        showMyStocksButton = button
        view.addSubview(showMyStocksButton)

        showMyStocksButton.setImage(UIImage(named: Constants.ShowMyStocksButton.imageName), for: .normal)
        showMyStocksButton.imageView?.contentMode = .scaleAspectFill
        showMyStocksButton.addTarget(self, action: #selector(didTapShowMyStocksButton), for: .touchUpInside)
    }

    private func setupStockAmountLabel() {
        let label = UILabel()

        stockAmountLabel = label
        view.addSubview(stockAmountLabel)

        stockAmountLabel.textAlignment = .center
        stockAmountLabel.font = Constants.StockAmountLabel.font
    }

    private func setupCompanyNameLabel() {
        let label = UILabel()

        companyNameLabel = label
        view.addSubview(companyNameLabel)

        companyNameLabel.textAlignment = .center
        companyNameLabel.font = Constants.CompanyNameLabel.font
        companyNameLabel.numberOfLines = Constants.CompanyNameLabel.numberOfLines
        companyNameLabel.lineBreakMode = .byWordWrapping
    }

    private func setupStockLineChartView() {
        let chart = StockDetailChartView()

        stockLineChartView = chart
        chartContainerView.addSubview(stockLineChartView)

        stockLineChartView.backgroundColor = Constants.StockLineChartView.backgoundColor
        stockLineChartView.translatesAutoresizingMaskIntoConstraints = false

        stockLineChartView.clipsToBounds = true
        stockLineChartView.layer.cornerRadius = Constants.StockLineChartView.cornerRadius

        stockLineChartView.xAxis.enabled = false
        stockLineChartView.rightAxis.enabled = false
        stockLineChartView.leftAxis.enabled = false
        stockLineChartView.drawGridBackgroundEnabled = false
        stockLineChartView.xAxis.drawGridLinesEnabled = false
        stockLineChartView.leftAxis.drawGridLinesEnabled = false
        stockLineChartView.minOffset = Constants.StockLineChartView.minOffset
        stockLineChartView.legend.enabled = false

        stockLineChartView.scaleXEnabled = false
        stockLineChartView.scaleYEnabled = false
        stockLineChartView.isUserInteractionEnabled = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLineChartView))
        tapRecognizer.numberOfTapsRequired = 1
        stockLineChartView.addGestureRecognizer(tapRecognizer)
    }

    private func setupActivityIndicator() {
        let indicator = UIActivityIndicatorView()

        loadIndicator = indicator
        view.addSubview(loadIndicator)

        loadIndicator.hidesWhenStopped = true
    }

    private func setupSubviews() {
        setupCompanyNameLabel()
        setupShowMyStocksButton()
        setupStockDetailCardView()
        setupChartContainerView()
        setupStockLineChartView()
        setupStockNameLabel()
        setupStockCurrentCostLabel()
        setupStockAmountLabel()
        setupBuyButton()
        setupSellButton()
        setupBuyTextFieldContainerView()
        setupBuyTextField()
        setupSellTextFieldContainerView()
        setupSellTextField()
        setupActivityIndicator()
    }

    private func setupView() {
        view.backgroundColor = Constants.backgroundColor

        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))

        viewTapRecognizer.numberOfTapsRequired = Constants.TapRecognizer.tapsRequired
        view.addGestureRecognizer(viewTapRecognizer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSubviews()
        setupKeyboardHandling()

        output?.didLoadView()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateUI()
    }

    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func updateUI() {
        updateView()
        updateStockDetailCard()
        updateChartContainerView()
        updateLineChartView()
        updateBuyTextField()
        updateSellTextField()
    }

    private func updateView() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func updateStockDetailCard() {
        stockDetailCardView.backgroundColor = Constants.StockDetailCardView.backgoundColor
    }

    private func updateChartContainerView() {
        chartContainerView.backgroundColor = Constants.ChartContainerView.backgoundColor
    }

    private func updateLineChartView() {
        stockLineChartView.backgroundColor = Constants.StockLineChartView.backgoundColor
    }

    private func updateBuyTextField() {
        buyTextField.backgroundColor = Constants.TextField.backgroundColor
        buyTextField.layer.borderColor = Constants.TextField.borderColor.cgColor
        buyTextField.attributedPlaceholder = NSAttributedString(string: Constants.TextField.placeholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.TextField.placeholderTextColor])
    }

    private func updateSellTextField() {
        sellTextField.backgroundColor = Constants.TextField.backgroundColor
        sellTextField.layer.borderColor = Constants.TextField.borderColor.cgColor
        sellTextField.attributedPlaceholder = NSAttributedString(string: Constants.TextField.placeholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.TextField.placeholderTextColor])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutCompanyNameLabel()
        layoutShowMyStocksButton()
        layoutStockDetailCardView()
        layoutChartContainerView()
        layoutLineChartView()
        layoutStockNameLabel()
        layoutStockCurrentCostLabel()
        layoutStockAmountLabel()
        layoutBuyButton()
        layoutSellButton()
        layoutBuyTextFieldContainerView()
        layoutBuyTextField()
        layoutSellTextFieldContainerView()
        layoutSellTextField()
        layoutActivityIndicator()
    }

    private func layoutCompanyNameLabel() {
        companyNameLabel.pin
            .top(Constants.CompanyNameLabel.topPercent)
            .width(Constants.CompanyNameLabel.widthPercent)
            .height(Constants.CompanyNameLabel.height)
            .hCenter()
    }

    private func layoutShowMyStocksButton() {
        showMyStocksButton.pin
            .width(Constants.ShowMyStocksButton.widthConstant)
            .height(Constants.ShowMyStocksButton.heightConstant)
            .left(Constants.ShowMyStocksButton.leftPercent)
            .top(companyNameLabel.frame.midY - Constants.ShowMyStocksButton.heightConstant / 2)
    }

    private func layoutStockDetailCardView() {
        stockDetailCardView.pin
            .top(showMyStocksButton.frame.maxY + Constants.screenHeight * Constants.StockDetailCardView.topSpacingMultiplier)
            .width(Constants.StockDetailCardView.widthPercent)
            .height(Constants.StockDetailCardView.heightPercent)
            .hCenter()
    }

    private func layoutChartContainerView() {
        if let offset = keyboardOffset {
            chartContainerView.pin
                .top(chartContainerView.frame.minY - offset)
        } else {
            chartContainerView.pin
                .top(stockDetailCardView.frame.maxY + Constants.screenHeight * Constants.ChartContainerView.topSpacingMultiplier)
                .width(Constants.ChartContainerView.widthPercent)
                .height(Constants.ChartContainerView.heightPercent)
                .hCenter()
        }
    }

    private func layoutLineChartView() {
        stockLineChartView.pin
            .top(Constants.StockLineChartView.topPercent)
            .left(.zero)
            .right(.zero)
            .bottom(.zero)
    }

    private func layoutStockNameLabel() {
        stockSymbolLabel.pin
            .top(Constants.StockSymbolLabel.topPercent)
            .left(Constants.StockSymbolLabel.leftPercent)
            .width(Constants.StockSymbolLabel.widthPercent)
            .height(Constants.StockSymbolLabel.heightPercent)
    }

    private func layoutStockCurrentCostLabel() {
        stockCurrentCostLabel.pin
            .top(Constants.StockCurrentCostLabel.topPercent)
            .right(Constants.StockCurrentCostLabel.rightPercent)
            .width(Constants.StockCurrentCostLabel.widthPercent)
            .height(Constants.StockCurrentCostLabel.heightPercent)
    }

    private func layoutStockAmountLabel() {
        stockAmountLabel.pin
            .top(chartContainerView.frame.maxY + Constants.screenHeight * Constants.StockAmountLabel.topSpacingMultiplier)
            .width(Constants.StockAmountLabel.widthPercent)
            .hCenter()
            .height(Constants.StockAmountLabel.height)
    }

    private func layoutBuyButton() {
        buyButton.pin
            .top(stockAmountLabel.frame.maxY + Constants.screenHeight * Constants.BuyButton.topSpacingMultiplier)
            .left(Constants.Buttons.leftPercent)
            .width(Constants.Buttons.widthPercent)
            .height(Constants.Buttons.height)
    }

    private func layoutSellButton() {
        sellButton.pin
            .top(buyButton.frame.maxY + Constants.screenHeight * Constants.SellButton.topSpacingMultiplier)
            .left(Constants.Buttons.leftPercent)
            .width(Constants.Buttons.widthPercent)
            .height(Constants.Buttons.height)
    }

    private func layoutBuyTextField() {
        buyTextField.pin
            .all(.zero)
    }

    private func layoutBuyTextFieldContainerView() {
        buyTextFieldContainerView.pin
            .top(stockAmountLabel.frame.maxY + Constants.screenHeight * Constants.BuyTextFieldContainer.topSpacingMultiplier)
            .right(Constants.TextFieldContainer.rightPercent)
            .width(Constants.TextFieldContainer.widthPercent)
            .height(Constants.TextFieldContainer.height)
    }

    private func layoutSellTextField() {
        sellTextField.pin
            .all(.zero)
    }

    private func layoutSellTextFieldContainerView() {
        sellTextFieldContainerView.pin
            .top(buyTextFieldContainerView.frame.maxY + Constants.screenHeight * Constants.SellTextFieldContainer.topSpacingMultiplier)
            .right(Constants.TextFieldContainer.rightPercent)
            .width(Constants.TextFieldContainer.widthPercent)
            .height(Constants.TextFieldContainer.height)
    }

    private func layoutActivityIndicator() {
        loadIndicator.pin
            .top(chartContainerView.frame.midY - loadIndicator.bounds.size.height / 2)
            .left(chartContainerView.frame.midX - loadIndicator.bounds.size.width / 2)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        output?.viewWillDisappear()
    }

    private func animateCardViewDisappear() {
        UIView.animate(withDuration: Constants.StockDetailCardView.disappearAnimtaionLength,
                       animations: {
                        self.stockDetailCardView.alpha = .zero
                       },
                       completion: { (_) in
                        self.stockDetailCardView.isHidden = true
                       })
    }

    private func animateCardViewAppear() {
        UIView.animate(withDuration: Constants.StockDetailCardView.appearAnimationLength,
                       animations: {
                        self.stockDetailCardView.alpha = 1
                       },
                       completion: { (_) in
                        self.stockDetailCardView.isHidden = false
                       })
    }

    @objc
    private func didTapView() {
        output?.didTapView()
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardFrame = keyboardSize.cgRectValue

        if buyTextField.isEditing {
            if UIScreen.main.bounds.height - keyboardFrame.height - Constants.keyboardExtraOffset <= buyTextFieldContainerView.frame.maxY {
                keyboardOffset = buyTextFieldContainerView.frame.maxY - (UIScreen.main.bounds.height - keyboardFrame.height) + Constants.keyboardExtraOffset
                animateCardViewDisappear()
            }
        } else if sellTextField.isEditing {
            if UIScreen.main.bounds.height - keyboardFrame.height - Constants.keyboardExtraOffset <= sellTextFieldContainerView.frame.maxY {
                keyboardOffset = sellTextFieldContainerView.frame.maxY - (UIScreen.main.bounds.height - keyboardFrame.height) + Constants.keyboardExtraOffset
                animateCardViewDisappear()
            }
        }

        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        keyboardOffset = nil

        if stockDetailCardView.isHidden {
            animateCardViewAppear()
        }

        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

extension StockDetailViewController: StockDetailViewInput {
    func setCardLeftText(text: String) {
        cardPresenter?.setUpperTextLeft(text: text)
    }

    func setCardRightText(text: String) {
        cardPresenter?.setUpperTextRight(text: text)
    }

    func setCardLeftNumber(number: Int) {
        cardPresenter?.setNumberLeft(num: number)
    }

    func setCardRightNumber(number: Int) {
        cardPresenter?.setNumberRight(num: number)
    }

    func setStockSymbolLabel(with name: String) {
        stockSymbolLabel.text = name
    }

    func setCompanyNameLebel(with name: String) {
        companyNameLabel.text = name
    }

    func setStockAmountLabel(with amount: String) {
        stockAmountLabel.text = "You owns: " + amount
    }

    func setStockCurrentCostLabel(with cost: String) {
        stockCurrentCostLabel.text = cost
    }

    func getLineChartViewSize() -> CGSize {
        return stockLineChartView.bounds.size
    }

    func setChartData(with quotes: [ChartDataEntry]) {
        let chartDataset = LineChartDataSet(quotes)

        chartDataset.circleRadius = Constants.ChartDataset.circleRadius
        chartDataset.circleColors = [NSUIColor(cgColor: Constants.chartLineColor.cgColor)]
        chartDataset.setColor(NSUIColor(cgColor: Constants.chartLineColor.cgColor))

        chartDataset.mode = .cubicBezier
        chartDataset.lineWidth = Constants.ChartDataset.lineWidth

        chartDataset.drawFilledEnabled = true
        chartDataset.fill = Fill(color: NSUIColor(cgColor: Constants.chartFillColor.cgColor))
        chartDataset.drawHorizontalHighlightIndicatorEnabled = false
        chartDataset.drawVerticalHighlightIndicatorEnabled = false

        let data = LineChartData(dataSet: chartDataset)
        data.setDrawValues(false)

        stockLineChartView.data = data
    }

    func setNavigationBarTitle(with title: String) {
        navigationItem.title = title
    }

    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))

        present(alert, animated: true)
    }

    func showActivityIndicator() {
        chartContainerView.isHidden = true
        stockDetailCardView.isHidden = true
        stockAmountLabel.isHidden = true
        companyNameLabel.isHidden = true

        loadIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        chartContainerView.isHidden = false
        stockDetailCardView.isHidden = false
        stockAmountLabel.isHidden = false
        companyNameLabel.isHidden = false

        loadIndicator.stopAnimating()
    }

    func showPointInfo(percentageX: CGFloat, percentageY: CGFloat, cost: String) {
        stockLineChartView.configure(text: cost,
                                     percentageX: percentageX,
                                     percentageY: percentageY)
    }

    func disableKeyboard() {
        view.endEditing(true)
    }
}
