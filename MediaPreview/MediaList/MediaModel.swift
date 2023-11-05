//
//  MediaModel.swift
//  MediaPreview
//
//  Created by Saeed on 8/13/1402 AP.
//

import Foundation

struct Media: Identifiable, Decodable, Hashable {
    let id = UUID()
    let title: String
    let previewLink: String
    let mediaLink: String
    let type: String
    var mediaType: MediaType {
            return MediaType(rawValue: type) ?? .image
    }
}

enum MediaType: String {
    case image = "image"
    case video = "video"
}
