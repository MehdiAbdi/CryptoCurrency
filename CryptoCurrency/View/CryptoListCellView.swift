//
//  CryptoListCellView.swift
//  CryptoCurrency
//
//  Created by Mehdi on 11/26/22.
//

import SwiftUI

struct CryptoListCellView<Content: View>: View {
    @State var symbol :String
    @State var name :String
    
    @State var currentPrice: Double
    @State var lowInDay: Double
    @State var highInDay: Double
    @State var priceChangedPercentage: Double
    
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            HStack {
                LeftSideStack(symbol: $symbol, name: $name) {
                    content
                }
                
                Spacer()
                
                RightSideStack(currentPrice: $currentPrice, lowInDay: $lowInDay, highInDay: $highInDay, priceChangedPercentage: $priceChangedPercentage)
                
            }
        }
    }
}

fileprivate struct LeftSideStack<Content: View>: View {
    @Binding var symbol :String
    @Binding var name :String
    
    @ViewBuilder var content: Content
    
    var body: some View {
        HStack {
            content
            
            VStack(alignment: .leading) {
                Text(symbol.uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

fileprivate struct RightSideStack: View {
    @Binding var currentPrice: Double
    @Binding var lowInDay: Double
    @Binding var highInDay: Double
    @Binding var priceChangedPercentage: Double
    
    var body: some View {
        HStack {
            VStack (alignment: .trailing) {
                Text(currentPrice.formatToFourDigitCurrency())
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(highInDay.formatToFourDigitCurrency())
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            
            VStack(alignment: .trailing) {
                Text(priceChangedPercentage.formatToPercentage())
                    .font(.headline)
                    .foregroundColor(priceChangedPercentage < 0 ? .red : .green)
                
                Text(lowInDay.formatToFourDigitCurrency())
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CryptoListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
            CryptoListCellView(symbol: "BTC", name: "Bitcoin", currentPrice: 1667.6, lowInDay: 2.666, highInDay: 3.206, priceChangedPercentage: 1.231321) {
                Text("Hi")
            }
        }
    }
}
