//
//  AsyncImageView.swift
//  CryptoCurrency
//
//  Created by Mehdi on 11/26/22.
//

import SwiftUI

struct AsyncImageView: View {
    @ObservedObject var downloader: ImageDownloader
    
    init(url: URL) {
        downloader = ImageDownloader(url: url)
    }
    
    private var image: some View {
        Group {
            if downloader.image != nil {
                Image(uiImage: downloader.image!)
                    .resizable()
                    .frame(width: 50, height: 50)
            } else  {
                ProgressView()
            }
        }
    }
    
    var body: some View {
        image.onAppear {
            downloader.start()
        }
        .onDisappear {
            downloader.stop()
        }
    }
}
