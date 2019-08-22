//
//  File.swift
//  Tet Currency
//
//  Created by armands.berzins on 22/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//
import Foundation

extension String {
    func getEmoji(for currencyCode: String) -> String {
        switch currencyCode {
            case "AUD": return "🇦🇺"
            case "BGN": return "🇧🇬"
            case "BLR": return "🇧🇾"
            case "CAD": return "🇨🇦"
            case "CHF": return "🇨🇭"
            case "CNY": return "🇨🇳"
            case "CZK": return "🇨🇿"
            case "DKK": return "🇩🇰"
            case "EUR": return "🇪🇺"
            case "GBP": return "🇬🇧"
            case "HKD": return "🇭🇰"
            case "HRK": return "🇭🇷"
            case "HUF": return "🇭🇺"
            case "IDR": return "🇮🇩"
            case "ILS": return "🇮🇱"
            case "INR": return "🇮🇳"
            case "ISK": return "🇮🇸"
            case "JPY": return "🇯🇵"
            case "KRW": return "🇰🇷"
            case "MXN": return "🇲🇽"
            case "MYR": return "🇲🇾"
            case "NOK": return "🇳🇴"
            case "NZD": return "🇳🇿"
            case "PHP": return "🇵🇭"
            case "PLN": return "🇵🇱"
            case "RON": return "🇷🇴"
            case "RUB": return "🇷🇺"
            case "SEK": return "🇸🇪"
            case "SGD": return "🇸🇬"
            case "THB": return "🇹🇭"
            case "TRY": return "🇹🇷"
            case "USD": return "🇺🇸"
            case "ZAR": return "🇿🇦"
        default:
            return " "
        }
    }
}
