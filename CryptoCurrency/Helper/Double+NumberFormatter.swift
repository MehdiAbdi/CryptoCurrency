//
//  Double+NumberFormatter.swift
//  CryptoCurrency
//
//  Created by Mehdi on 11/26/22.
//

import Foundation

extension Double {
    private var currencyNumber: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    
    func formatToFourDigitCurrency() -> String {
        let number = NSNumber(value: self)
        return currencyNumber.string(from: number) ?? "$0.0000"
    }
    
    func fotmatToStringWithTwoDigit() -> String {
        return String(format: "%.2f", self)
    }
    
    func formatToPercentage() -> String {
        return fotmatToStringWithTwoDigit() + "%"
    }
}

