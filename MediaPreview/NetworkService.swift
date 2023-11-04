//
//  NetworkService.swift
//  MediaPreview
//
//  Created by Saeed on 8/13/1402 AP.
//

import Foundation
import Combine
import SwiftUI

class NetworkService {
    
    func fetchMediaList() -> AnyPublisher<[Media], Error> {
        guard let url = URL(string: "https://c62881db-c803-4c5e-907e-3b1d843fa7fd.mock.pstmn.io/medialist") else {
            return Fail(error: NSError(domain: "Invalid URL", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Media].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func downloadImage(from url: String) -> AnyPublisher<UIImage, URLError> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .map { UIImage(data: $0.data) }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}

