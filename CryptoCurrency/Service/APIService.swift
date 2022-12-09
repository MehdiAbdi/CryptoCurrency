//
//  APIService.swift
//  CryptoCurrency
//
//  Created by Mehdi on 11/26/22.
//

import Foundation
import SwiftUI
import Combine

class DataDownloaderViewModel: ObservableObject {
    @Published var cryptoDatas = [CryptoModel]()
    private var downloadData = DownloadData()
    
    init() {
        getDatas()
    }
    
    private func getDatas() {
        downloadData.getData { res in
            switch res {
            case .success(let datas):
                DispatchQueue.main.async {
                    self.cryptoDatas = datas
                }
                
            case .failure(let failure):
                print("--Error: \(failure)")
            }
        }
    }
}

class ImageDownloader: ObservableObject {
    @Published var image: UIImage?
    private var cancelable: AnyCancellable?
    
    func startDownloading(url: String) {
        guard let safeURL = URL(string: url) else { return }
        
        cancelable = URLSession(configuration: .default)
            .dataTaskPublisher(for: safeURL)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func stop() { cancelable?.cancel() }
    
    deinit { cancelable?.cancel() }
}

fileprivate class DownloadData {
    func getData(completion: @escaping (Result<[CryptoModel], Error>) -> ()) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true") else {
            return
        }
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        session.dataTask(with: url) { data, respond, err in
            
            if let error = err {
                completion(.failure(error))
                print("--Error:\(error)")
            }
            
            guard let safeData = data else { return }
            
            do {
                let jsonData = try JSONDecoder().decode([CryptoModel].self, from: safeData)
                
                completion(.success(jsonData))
            }
            catch { print("--Error") }
        }
        .resume()
    }
}
