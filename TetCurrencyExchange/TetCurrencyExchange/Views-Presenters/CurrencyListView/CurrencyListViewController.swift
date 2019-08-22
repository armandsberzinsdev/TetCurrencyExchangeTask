//  ViewController.swift
//  TetCurrencyExchange
//
//  Created by armands.berzins on 15/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var currencyListTableView: UITableView!

    let uiPresenter = CurrencyListPresenter()
    weak var uiPresenterDelegate: CurrencyListPresenterDelegate?
    weak var currencyRateCellDelegate: CurrencyListInteractorDelegate?
    var currentCurrencyRates: CurrencyRatesEntity?
    var loadingView: LoadingView!
    var currencyRatesOnly: Array<(key: String, value: Double)> = []
    var insertedAmount: Double = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        setupViewController()
    }
    
    func setupViewController() -> Void {
        uiPresenter.uiPresenterDelegate = self
        currencyListTableView.delegate = self
        currencyListTableView.dataSource = self
        currencyListTableView.register(UINib.init(nibName: "CurrencyListTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrecyRateCell")
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "tetLogo.png")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
    }
    
    func showLoading(){
        loadingView = LoadingView(frame: self.view.frame)
        self.view.addSubview(loadingView)
    }
    
    func hideLoading(){
        loadingView.removeFromSuperview()
    }
}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCurrencyRates?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CurrecyRateCell") as! CurrencyListTableViewCell
        cell.currencyRateCellDelegate = self
        if currentCurrencyRates != nil {
            cell.rateKeyLbl.text = self.currencyRatesOnly[indexPath.row].key
            cell.rateValueLbl.text = formatCurrencyText(index: indexPath.row)
            cell.flgLbl.text = String.getEmoji(for: self.currencyRatesOnly[indexPath.row].key)
            if indexPath.row > 0 {
                cell = unselectedCellStyling(for: cell, rate: cell.rateValueLbl.text!)
            } else {
                cell = selectedCellStyling(for: cell)
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = currencyListTableView.cellForRow(at: indexPath) as! CurrencyListTableViewCell
        selectedCell.currencyInuptField.isEnabled = true
        selectedCell.currencyInuptField.becomeFirstResponder()
        selectedCell.cellBgView.backgroundColor = UIColor.TetColours.tetMainColor
        selectedCell.rateKeyLbl.textColor = UIColor.TetColours.tetTintColor
        selectedCell.rateValueLbl.textColor = UIColor.TetColours.tetTintColor
        selectedCell.currencyInuptField.textColor = UIColor.TetColours.tetTintColor
        if currentCurrencyRates != nil {
        let itemToMove = self.currencyRatesOnly[indexPath.row]
        self.currencyRatesOnly.remove(at: indexPath.row)
        self.currencyRatesOnly.insert(itemToMove, at: 0)
        
            let destinationIndexPath = NSIndexPath(row: 0, section: 0)
            currencyListTableView.moveRow(at: indexPath, to:destinationIndexPath as IndexPath)
            reloadCells()
        }
    }
    
    func reloadCells() {
        for (index, _) in self.currencyRatesOnly.enumerated() {
            if index > 0 {
                self.currencyListTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            }
        }
    }
    
    func unselectedCellStyling(for cell: CurrencyListTableViewCell, rate: String) -> CurrencyListTableViewCell {
        cell.currencyInuptField.isEnabled = false
        cell.cellBgView.backgroundColor = UIColor.TetColours.tetCurrencyRateBGColour
        cell.rateKeyLbl.textColor = UIColor.TetColours.tetCurrencyRateInactiveTextColour
        cell.rateValueLbl.textColor = UIColor.TetColours.tetCurrencyRateInactiveTextColour
        cell.currencyInuptField.textColor = UIColor.TetColours.tetCurrencyRateInactiveTextColour
        var formattedInsertedAmount = String(self.insertedAmount)
        if formattedInsertedAmount.contains(".0") {
            formattedInsertedAmount = String(formattedInsertedAmount.dropLast(2))
        }
        formattedInsertedAmount = formattedInsertedAmount.replacingOccurrences(of: ".", with: ",")
        cell.rateValueLbl.text = rate
        cell.currencyInuptField.text = formattedInsertedAmount
        return cell
    }
    
    func selectedCellStyling(for cell: CurrencyListTableViewCell) -> CurrencyListTableViewCell {
        cell.currencyInuptField.isEnabled = true
        cell.cellBgView.backgroundColor = UIColor.TetColours.tetMainColor
        cell.rateKeyLbl.textColor = UIColor.TetColours.tetTintColor
        cell.rateValueLbl.textColor = UIColor.TetColours.tetTintColor
        cell.currencyInuptField.textColor = UIColor.TetColours.tetTintColor
        cell.currencyInuptField.becomeFirstResponder()
        return cell
    }
    
    func formatCurrencyText(index: Int) -> String {
        var formattedText = String(format: " € = %.2f ", self.currencyRatesOnly[index].value * self.insertedAmount)
        formattedText = formattedText.replacingOccurrences(of: ".", with: ",")
        return formattedText
    }
}

extension CurrencyListViewController: CurrencyListPresenterDelegate {
    func updateCurrencyListData(with currencyRates: CurrencyRatesEntity) {
        self.currentCurrencyRates = currencyRates
        self.currencyRatesOnly = Array(currencyRates.rates).sorted(by: { $0.key < $1.key })
        self.currencyListTableView.reloadData()
        hideLoading()
    }
    
    func presentErrorView(error: ErrorEntity) {
        error.alert(with: self)
        hideLoading()
    }
}

extension CurrencyListViewController: CurrencyRateCellDelegate {
    func updateUserInput(with userNumber: Double) {
        self.insertedAmount = userNumber
        let cell = self.currencyListTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CurrencyListTableViewCell
        cell.rateValueLbl.text = formatCurrencyText(index: 0)
        self.reloadCells()
    }
}
