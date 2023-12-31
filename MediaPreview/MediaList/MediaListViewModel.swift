//
//  ImageListVM.swift
//  MediaPreview
//
//  Created by Saeed on 8/13/1402 AP.
//

import Foundation
import Combine
import SwiftUI

class MediaListViewModel: ObservableObject {
    
    @Published var images: [String: UIImage] = [:]
    @Published var mediaList: [Media] = []
    
    private var cancellable: AnyCancellable?
    private var cancellableSet: Set<AnyCancellable> = []
    private var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        fetchImageURLs()
    }
    
    
    func fetchImageURLs() {
        cancellable = networkService.fetchMediaList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { mediaList in
                self.mediaList = mediaList
            })
    }
    
    
    func downloadImages(at link: String) {
        guard imageCache.object(forKey: link as NSString) == nil else { return }

        networkService.downloadImage(from: link)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { image in
                self.imageCache.setObject(image, forKey: link as NSString)
                self.images[link] = image
            }).store(in: &cancellableSet)
    }

}
