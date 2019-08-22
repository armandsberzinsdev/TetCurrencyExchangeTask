//
//  CurrencyListTableViewCell.swift
//  Tet Currency
//
//  Created by armands.berzins on 21/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

protocol CurrencyRateCellDelegate: AnyObject {
    func updateUserInput(with userNumber: Double)
}

class CurrencyListTableViewCell: UITableViewCell {
    @IBOutlet weak var rateKeyLbl: UILabel!
    @IBOutlet weak var rateValueLbl: UILabel!
    @IBOutlet weak var currencyInuptField: UITextField!
    @IBOutlet weak var cellBgView: CellBackgroundView!
    @IBOutlet weak var flgLbl: UILabel!
    
    var currencyRateCellDelegate: CurrencyRateCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        currencyInuptField.delegate = self
        self.selectionStyle = .none
        currencyInuptField.text = "1"
        currencyInuptField.tintColor = UIColor.TetColours.tetTintColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CurrencyListTableViewCell: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        let validtextFieldText = textField.text?.replacingOccurrences(of: ",", with: ".")
        let validString = string.replacingOccurrences(of: ",", with: ".")
        if let insertedNumber = Double("\(validtextFieldText ?? "")\(validString)") {
            self.currencyRateCellDelegate?.updateUserInput(with: insertedNumber)
        }
        return true
    }
}
