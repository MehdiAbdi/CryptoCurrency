//
//  AsyncImageView.swift
//  CryptoCurrency
//
//  Created by Mehdi on 11/26/22.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var downloader = ImageDownloader()
    @State var url: String
    
    var body: some View {
        ZStack {
            if downloader.image != nil {
                Image(uiImage: downloader.image!)
                    .resizable()
                    .frame(width: 50, height: 50)
                
            } else { ProgressView() }
        }
        
        .onAppear { downloader.startDownloading(url: url) }
        .onDisappear { downloader.stop() }
    }
}
