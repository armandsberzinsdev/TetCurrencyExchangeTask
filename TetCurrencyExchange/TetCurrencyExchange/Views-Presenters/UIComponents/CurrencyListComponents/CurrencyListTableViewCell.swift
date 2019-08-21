//
//  CurrencyListTableViewCell.swift
//  Tet Currency
//
//  Created by armands.berzins on 21/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    @IBOutlet weak var rateKeyLbl: UILabel!
    @IBOutlet weak var rateValueLbl: UILabel!
    @IBOutlet weak var currencyInuptField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //self.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }
    
}
