//
//  CryptoDetailView.swift
//  CryptoCurrency
//
//  Created by Mehdi on 11/26/22.
//

import SwiftUI
import Charts

struct CryptoDetailView<Content: View>: View {
    @State var name: String
    @State var symbol :String
    @State var currentPrice :Double
    @State var marketCap :Double
    @State var priceChangedPercentage :Double
    @State var priceChanged: Double
    @State var sparkline: [Double]
    
    @ViewBuilder var image: Content
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gradientBlue,.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                TopSideStack(name: $name, symbol: $symbol, currentPrice: $currentPrice, marketCap: $marketCap, priceChangedPercentage: $priceChangedPercentage, priceChanged: $priceChanged) {
                    image
                }
                
                BottomSideStack(sparkline: $sparkline)
                Spacer()
            }
        }
    }
}

fileprivate struct TopSideStack<Content: View>: View {
    @Binding var name: String
    @Binding var symbol :String
    @Binding var currentPrice :Double
    @Binding var marketCap :Double
    @Binding var priceChangedPercentage :Double
    @Binding var priceChanged: Double
    
    @ViewBuilder var image: Content
    
    var body: some View {
        VStack {
            HStack {
                image.frame(width: 50, height: 50)
                Text(name).font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }.padding()
            
            HStack{
                VStack(alignment: .leading) {
                    Text(currentPrice.formatToFourDigitCurrency()).font(.largeTitle.bold())
                        .foregroundColor(.white)
                    HStack {
                        Text(symbol.uppercased())
                        Text("|")
                        Text("USD")
                    }
                    .foregroundColor(.gray)
                    .bold()
                }
                
                Text(priceChangedPercentage.formatToPercentage()).foregroundColor(currentPrice < 0 ? .red : .green)
                    .padding(.bottom)
                
                Spacer()
                VStack(alignment: .trailing) {
                    Text(priceChanged.formatToFourDigitCurrency()).foregroundColor(.white)
                        .font(.headline)
                    Text("Market Cap # \(Int(marketCap))")
                        .foregroundColor(.gray)
                }
            }.padding()
        }
    }
}

fileprivate struct BottomSideStack: View {
    @Binding var sparkline: [Double]
    @State var chartModel = [ChartDataModel]()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Market Average").foregroundColor(.gray)
                .padding()
            
                Chart(chartModel) {
                    LineMark(
                        x: .value("Type", $0.type),
                        y: .value("Value", $0.value)
                    )
                    
                    PointMark(
                        x: .value("Type", $0.type),
                        y: .value("Value", $0.value)
                    )
                }
                .padding()
                .frame(height: 350)
                .foregroundStyle(.white)
            
        }.onAppear {
            var counter = 1
            sparkline.forEach { value in
                chartModel.append(ChartDataModel(type: "\(counter)", value: value))
                counter += 1
            }
        }
    }
}

struct CryptoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [.gradientBlue,.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            BottomSideStack(sparkline: .constant([0.1, 2.44, 13.9]))
        }
    }
}
