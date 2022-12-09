//
//  CryptoView.swift
//  CryptoCurrency
//
//  Created by Mehdi on 11/26/22.
//

import SwiftUI

struct CryptoView: View {
    @ObservedObject var dataDownload = DataDownloaderViewModel()
    
    @State var showDetailView = false
    @State var url = String()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.gradientBlue,.black], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    ScrollView {
                        ForEach(dataDownload.cryptoDatas) { item in
                            NavigationLink {
                                CryptoDetailView(name: item.name, symbol: item.symbol, currentPrice: item.currentPrice, marketCap: item.marketCapRank ?? 0, priceChangedPercentage: item.priceChangePercentage24H ?? 0.00, priceChanged: item.priceChange24H ?? 0.00, sparkline: item.sparklineIn7D?.price ?? [0.0]) {
                                    
                                    AsyncImageView(url: item.image)
                                }
                                
                            } label: {
                                CryptoListCellView(symbol: item.symbol, name: item.name, currentPrice: item.currentPrice, lowInDay: item.low24H ?? 0.00, highInDay: item.high24H ?? 0.00, priceChangedPercentage: item.priceChangePercentage24H ?? 0.00) {
                                    
                                    AsyncImageView(url: item.image)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Crypto Currency")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoView()
    }
}

